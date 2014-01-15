Package.describe({
  summary: "Easily include ace, receive reactive varibles for cursor position, editor contents, etc"
});


var bundlerApi = null
var path = Npm.require("path");
var fs = Npm.require("fs");
var packagePath = path.join(path.resolve("."), "packages", "reactive-ace");

Package.on_use(function (api, where) {
  api.use(['jquery', "templating", "coffeescript", "underscore", "deps"], ["client"]);

  var files = fs.readdirSync(path.join(packagePath, "ace-builds", "src"));
  files.forEach(function(file){
    if (file === "snippets"){return;}
    api.add_files(path.join("ace-builds", "src", file), "client", {isAsset: true});
  });

  var snippets = fs.readdirSync(path.join(packagePath, "ace-builds", "src", "snippets"));
  snippets.forEach(function(file){
    snippetPath = path.join("ace-builds", "src", "snippets", file)
    api.add_files(snippetPath, "client", {isAsset: true});
  })


  api.add_files(["ace-builds/src/ace.js", "ace-builds/src/ext-modelist.js", "lib/utils.coffee", "lib/crc32.js", "lib/esprima.js", "editor.coffee", "editorSetup.coffee", "hack.hack", "templates.html"], "client");
});


