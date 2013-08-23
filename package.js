Package.describe({
  summary: "Easily include ace, receive reactive varibles for cursor position, editor contents, etc"
});


var bundlerApi = null
var path = Npm.require("path");
var fs = Npm.require("fs");
/**XXX TERRIBLE HACK
We need to add js files as non-bundled resources the client can pull on need.
This will be obsolete once Meteor's linker is released.
*/
Package.register_extension("hack", function(bundlerApi, source_path, serve_path, where){
  var directory = path.dirname(source_path)
  var files = fs.readdirSync(path.join(directory, "ace-builds/src"));
  files.forEach(function(file){
    if (file == 'snippets') {
      return;
    }
    bundlerApi.add_resource({
      type: "static",
      path: "/ace/" + file,
      source_file: path.join(directory, "ace-builds/src/" + file),
      where: "client"
    });
  });

  var snippets = fs.readdirSync(path.join(directory, "ace-builds/src/snippets"));
  snippets.forEach(function(file){
    bundlerApi.add_resource({
      type: "static",
      path: "/ace/snippets/" + file,
      source_file: path.join(directory, "ace-builds/src/snippets/" + file),
      where: "client"
    });
  });
});

Package.on_use(function (api, where) {
  api.use(["templating", "coffeescript", "underscore", "deps"], ["client"]);
  api.add_files(["ace-builds/src/ace.js", "ace-builds/src/ext-modelist.js", "lib/utils.coffee", "lib/crc32.js", "lib/esprima.js", "editor.coffee", "editorSetup.coffee", "hack.hack", "templates.html"], "client");
});

