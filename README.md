meteor-reactive-ace
===================

##Quick Start

0. Install [meteorite](https://github.com/oortcloud/meteorite)
`
npm install -g meteorite
`
1. Clone this repo
`
git clone git://github.com/mad-eye/meteor-reactive-ace.git; cd meteor-reactive-ace
`
2. Update submodules
`git submodule update --init ace-builds`
3. Check out the helloAce example
  1. `cd examples/helloAce`
  2. `mrt`

##Including in your project

### Simple Setup
1. Add reactive-ace to your smart.json file
2. Include `{{> aceEditor}}` in one of your templates
3. Use the global `editor` variable to access the editor's reactive variables (`editor.line`, `editor.value`, etc)

### Advanced setup
1. Add reactive-ace to your smart.json file
1. Create a div element with an id where you will attach the editor.  Wrap it inside of a `{{constant}}` block so that it is not rerendered.
2. Create an editor object by calling `new ReactiveAce()`
3. Attach the editor to the div by calling `editorObject.attach(divElementId)`
