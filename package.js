Package.describe({
  summary: "Easily include ace, receive reactive varibles for cursor position, editor contents, etc"
});


var bundlerApi = null
var path = Npm.require("path");
var fs = Npm.require("fs");
/**XXX TERRIBLE HACK
We should try and get something pulled into meteor
so that js files easily be added 
*/
Package.register_extension("hack", function(bundlerApi, source_path, serve_path, where){
  var directory = path.dirname(source_path)
  var files = fs.readdirSync(path.join(directory, "ace-builds/src"));
  files.forEach(function(file){
    bundlerApi.add_resource({
      type: "static",
      path: "/ace/" + file,
      source_file: path.join(directory, "ace-builds/src/" + file),
      where: "client"
    });
  });
});

Package.on_use(function (api, where) {
  api.use(["templating", "coffeescript"], ["client"]);
  api.add_files(["templates.html", "templates.css", "ace-builds/src/ace.js", "lib/utils.coffee", "lib/crc32.js", "lib/esprima.js", "editor.coffee", "editorSetup.coffee", "hack.hack"], "client");
});

