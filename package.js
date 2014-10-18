Package.describe({
  description: "Easily include ace, receive reactive varibles for cursor position, editor contents, etc",
  "version": "0.0.3",
  "name": "dcsan:reactive-ace",
});

var bundlerApi = null
var path = Npm.require("path");
var fs = Npm.require("fs");
var packagePath = path.join(path.resolve("."), "packages", "reactive-ace");

// console.log("packagePath:", packagePath);
// console.log("dirName:", __dirname);
// console.log("cwd:", path.resolve(".") );
// console.log(require.main.filename)

Package.on_use(function (api, where) {
  api.use(['jquery', "templating", "coffeescript", "underscore", "deps"], ["client"]);

  var files = fs.readdirSync(path.join(packagePath, "ace-builds", "src"));
  files.forEach(function(file){
    // console.log("loading file", file)
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


