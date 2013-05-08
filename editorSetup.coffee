ace.config.set "modePath", "/ace"
ace.config.set "themePath", "/ace"
ace.config.set "workerPath", "/ace"
ace.config.set "basePath", "/ace"

#editor will be instantiated in this way when user uses aceEditor helper is used
if Meteor.isClient
  window.editor = new ReactiveAce

  Template.aceEditor.rendered = ->
    #TODO
    #console.log "RENDERED, why is this being called so much?"
    editor.attach ace.edit "aceEditor"
