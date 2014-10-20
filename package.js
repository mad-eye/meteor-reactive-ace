Package.describe({
  "summary": "Easily include ace, receive reactive varibles for cursor position, editor contents, etc",
  "version": "0.0.41",
  "name": "dcsan:reactive-ace",
  "git": 'https://github.com/dcsan/meteor-reactive-ace.git'
});

var bundlerApi = null
var path = Npm.require("path");
var fs = Npm.require("fs");

// var packagePath = path.join(path.resolve("."), "packages", "reactive-ace");
var packagePath = path.join(path.resolve(".") );

// console.log("packagePath:", packagePath);
// console.log("dirName:", __dirname);
// console.log("cwd:", path.resolve(".") );
// console.log(require.main.filename)

Package.on_use(function (api, where) {
  api.use([
    'jquery@1.0.0',
    "templating@1.0.0",
    "coffeescript@1.0.0",
    "underscore@1.0.0",
    "deps@1.0.0"
  ], ["client"]);

  // var srcPath = path.join(packagePath, "ace-builds", "src")
  var srcPath = path.join(packagePath, "vendor", "ace", "src")
  console.log('srcPath', srcPath)
  var files = fs.readdirSync(srcPath);
  files.forEach(function(file){
    console.log("add_file", file)
    if (file === "snippets"){return;}
    addPath = path.join("vendor", "ace", "src", file);
    api.add_files(addPath, "client", {isAsset: true});
  });

  var snippets = fs.readdirSync(path.join(packagePath, "ace-builds", "src", "snippets"));
  snippets.forEach(function(file){
    snippetPath = path.join("ace-builds", "src", "snippets", file)
    api.add_files(snippetPath, "client", {isAsset: true});
  })

  api.add_files([
    "ace-builds/src/ace.js", 
    "ace-builds/src/ext-modelist.js", 
    "lib/utils.coffee", 
    "lib/crc32.js", 
    "lib/esprima.js", 
    "editor.coffee", 
    "editorSetup.coffee", 
    "hack.hack", 
    "templates.html"
  ], "client");

});