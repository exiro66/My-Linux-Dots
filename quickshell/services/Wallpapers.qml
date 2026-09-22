pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Qt.labs.folderlistmodel
import "../core"

// The wallpaper folder, and the commands that put one on screen.
//
// Applying a wallpaper is two separate jobs that must happen in this order:
//
//   1. Config.wallpaperCommand — the picture itself, with a transition;
//   2. Config.paletteCommand   — regenerate the colour scheme from it.
//
// Step 2 is what re-themes the whole shell: Theme.qml has a live FileView on
// ~/.cache/wal/colors.json, so the panel, the accent and every tone step
// follow the new wallpaper on their own, with nothing to wire up here. Both
// are templates rather than literals precisely because this is the layer
// that differs between machines — see Config's system-integration block.
//
// The two run in one *detached* shell rather than as Quickshell processes:
// the palette generator is slow enough to outlive a keypress, and it must
// not be a child of the shell it is about to re-colour.
QtObject {
    id: walls

    readonly property string _home: Quickshell.env("HOME") || ""
    // Config.wallpaperDir puede ser absoluto (override del picker) o
    // relativo a $HOME (system.wallpapers de shell.conf).
    readonly property string dir: Config.wallpaperDir.startsWith("/") ? Config.wallpaperDir : _home + "/" + Config.wallpaperDir
    // What is on screen now, written by `apply` below. Also the file a
    // "restore on login" would read, which is why it outlives the process.
    readonly property string stateFile: _home + "/.cache/current-wallpaper"

    // [{ name, path, url }]
    property var all: []
    property string current: ""

    property FolderListModel _folder: FolderListModel {
        folder: "file://" + walls.dir
        nameFilters: Config.wallpaperFormats
        showDirs: false
        showHidden: false
        onCountChanged: walls._rebuild()
        onStatusChanged: if (status === FolderListModel.Ready)
            walls._rebuild()
    }

    function _rebuild() {
        var out = [];
        for (var i = 0; i < _folder.count; i++) {
            var name = "" + _folder.get(i, "fileName");
            var path = "" + _folder.get(i, "filePath");
            out.push({
                name: name,
                path: path,
                url: "file://" + path
            });
        }
        // Natural order, so 2.png comes before 10.png. FolderListModel sorts
        // as text, which puts the whole set in an order nobody named their
        // files expecting.
        out.sort(function (a, b) {
            var d = walls._leadingNumber(a.name) - walls._leadingNumber(b.name);
            if (d !== 0)
                return d;
            return a.name < b.name ? -1 : a.name > b.name ? 1 : 0;
        });
        walls.all = out;
    }

    function _leadingNumber(name) {
        var m = name.match(/^(\d+)/);
        // Un-numbered names sort after every numbered one, among themselves
        // alphabetically.
        return m ? parseInt(m[1]) : 1e9;
    }

    function search(query) {
        var q = ("" + query).trim().toLowerCase();
        if (!q.length)
            return all;
        var out = [];
        for (var i = 0; i < all.length; i++)
            if (all[i].name.toLowerCase().indexOf(q) >= 0)
                out.push(all[i]);
        return out;
    }

    // ── folder browsing (integrated picker) ───────────────────
    // The folder view navigates with ".." and subdirectories; Enter on a
    // subfolder descends, the top row chooses. All inside the notch, no
    // external windows. Choosing writes the override and the images reload
    // on their own, no restarts.
    property string browseRoot: ""
    // [{ name, path, up }] — ".." first when a parent exists, then subdirs.
    property var folderEntries: []

    property FolderListModel _folders: FolderListModel {
        folder: "file://" + (walls.browseRoot.length ? walls.browseRoot : walls.dir)
        showDirs: true
        showHidden: false
        onCountChanged: walls._rebuildFolders()
        onStatusChanged: if (status === FolderListModel.Ready)
            walls._rebuildFolders()
    }

    function _rebuildFolders() {
        var base = walls.browseRoot.length ? walls.browseRoot : walls.dir;
        var out = [];
        var parent = base.replace(/\/[^\/]+\/?$/, "");
        if (parent.length && parent !== base)
            out.push({
                name: "..",
                path: parent === "" ? "/" : parent,
                up: true
            });
        var subs = [];
        for (var i = 0; i < _folders.count; i++) {
            if (("" + _folders.get(i, "fileIsDir")) !== "true")
                continue;
            subs.push({
                name: "" + _folders.get(i, "fileName"),
                path: "" + _folders.get(i, "filePath"),
                up: false
            });
        }
        subs.sort(function (a, b) {
            return a.name.toLowerCase() < b.name.toLowerCase() ? -1 : 1;
        });
        walls.folderEntries = out.concat(subs);
    }

    function browseTo(path) {
        if (path && path.length)
            walls.browseRoot = path;
    }

    // Fila superior fija + ".." siempre + subdirs filtradas por query.
    function searchFolders(query) {
        var base = walls.browseRoot.length ? walls.browseRoot : walls.dir;
        var tail = base.split("/");
        var rows = [{
            name: "Use this folder",
            sub: tail[tail.length - 1] || base,
            path: base,
            use: true,
            up: false
        }];
        var q = ("" + query).trim().toLowerCase();
        for (var i = 0; i < folderEntries.length; i++) {
            var e = folderEntries[i];
            if (e.up || !q.length || e.name.toLowerCase().indexOf(q) >= 0)
                rows.push(e);
        }
        return rows;
    }

    // Persists the chosen folder, and applies it at once (the watcher
    // does not always catch a newly created file, so it is not relied on).
    function setDir(path) {
        if (!path || !path.length)
            return;
        Settings.wallpaperDirOverride = path;
        _save.command = ["sh", "-c", "printf '%s' " + _quote(path) + " > '" + Settings.wallpaperDirFile + "'"];
        if (!_save.running)
            _save.running = true;
    }
    property Process _save: Process {}

    // Manual reload: re-reads the file and rebuilds the lists without
    // restarting anything. Belt and suspenders next to the automatic path.
    function refreshAll() {
        if (!_cat.running)
            _cat.running = true;
    }
    property Process _cat: Process {
        command: ["cat", Settings.wallpaperDirFile]
        stdout: StdioCollector {
            onStreamFinished: {
                var v = ("" + text).trim();
                if (v.length)
                    Settings.wallpaperDirOverride = v;
                walls._rebuild();
                walls._rebuildFolders();
            }
        }
    }

    // px/py: where on the screen the choice was made, in the wallpaper
    // daemon's coordinates (origin bottom-left). The new picture grows out of
    // that point, so the change starts where the user's attention already is.
    function apply(path, px, py) {
        if (!path || !path.length)
            return;

        var steps = [_fill(Config.wallpaperCommand, path, px, py)];
        if (Config.paletteCommand.length)
            steps.push(_fill(Config.paletteCommand, path, px, py));
        steps.push("printf '%s' " + _quote(path) + " > " + _quote(stateFile));

        Quickshell.execDetached(["sh", "-c", steps.join("; ")]);
        walls.current = path;
    }

    // The path is substituted already quoted, so a filename with a space or
    // an apostrophe in it is a filename and never an extra argument. The
    // replacements are functions rather than strings because a literal `$&`
    // in a filename is a back-reference to String.replace and would otherwise
    // rewrite itself.
    function _fill(tpl, path, px, py) {
        var q = _quote(path);
        var x = "" + Math.round(px);
        var y = "" + Math.round(py);
        return ("" + tpl).replace(/%[fxy]/g, function (m) {
            return m === "%f" ? q : m === "%x" ? x : y;
        });
    }

    function _quote(s) {
        return "'" + ("" + s).replace(/'/g, "'\\''") + "'";
    }

    // Read back so the list can mark what is already on screen. Older setups
    // stored a bare index or basename here rather than a path, so both
    // shapes are accepted.
    property FileView _state: FileView {
        path: walls.stateFile
        watchChanges: true
        onFileChanged: reload()
        onLoaded: {
            var t = ("" + text()).trim();
            if (!t.length)
                return;
            walls.current = t.indexOf("/") >= 0 ? t : walls.dir + "/" + t + ".png";
        }
        onLoadFailed: walls.current = ""
    }
}
