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

4. copy latest version of ace into vendor

    cp -r ace-builds/src vendor/ace

##Including in your project

###Setup
1. Add reactive-ace to your smart.json file
1. Create a div element with an id where you will attach the editor.  Wrap it inside of a `{{constant}}` block so that it is not rerendered.
2. Create an editor object by calling `new ReactiveAce()`
3. Attach the editor to the div by calling `editorObject.attach(divElementId)`

##Enabling syntax modes and themes
Assuming your editor is a variabled named `editor`, try 
`editor.theme = "monokai"`
`editor.syntaxMode = "javascript"`

[Full list of themes and modes](https://github.com/ajaxorg/ace-builds/tree/6df9748af5ebe5cf8bf43931aec940964353b20c/src)

##Turning on the javascript abstract syntax tree 
(powered by [esprima](https://github.com/ariya/esprima))

1. Turn on abstract syntax tree parsing with `editor.parseEnabled = true`
2. View it with `editor.parsedBody`
3. If you have an error in your javascript `editor.parsedError` will be populated.



