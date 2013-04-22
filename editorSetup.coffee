#editor will be instantiated in this way when user uses aceEditor helper is used
if Meteor.isClient
  Template.aceEditor.rendered = ->
    window.editor = new Editor(ace.edit("aceEditor"))
