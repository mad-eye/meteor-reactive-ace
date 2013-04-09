Package.describe({
  summary: "Easily include ace, receive reactive varibles for cursor position, editor contents, etc"
});

Package.on_use(function (api, where) {
  api.add_files("ace-builds/src/ace.js", ["client"]);
});
