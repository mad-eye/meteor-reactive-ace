class Editor
  constructor: (@_aceEditor)->

if Meteor.isClient
  Template.aceEditor.rendered = ->
    window.editor = new Editor(ace.edit("aceEditor"))
