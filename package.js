Package.describe({
  summary: "Easily include ace, receive reactive varibles for cursor position, editor contents, etc"
});

Package.on_use(function (api, where) {
  api.use(["templating", "coffeescript"], ["client"]);
  api.add_files("templates.html", ["client"]);
  api.add_files("templates.css", ["client"])
  api.add_files("ace-builds/src/ace.js", ["client"]);
  api.add_files("lib/utils.coffee", ["client"]);
  api.add_files("editor.coffee", ["client"]);
});
