meteor-reactive-ace
===================

## Quick Start

If you just want to use the ace editor as is, you can add it to your project with

`meteor add dcsan:meteor-reactive-ace`

## Updating ace version

If you want to update the version of the ace-editor used, do this:

* Clone this repo

`git clone git://github.com/mad-eye/meteor-reactive-ace.git; cd meteor-reactive-ace`

* Update submodules

`git submodule update --init ace-builds`

* copy latest version of ace into vendor dir

`cp -r ace-builds/src vendor/ace`

## demo app

Also there is an example app:

* `cd examples/helloAce`
* `meteor`

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


