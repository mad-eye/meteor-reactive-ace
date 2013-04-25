if Meteor.isClient
  Template.demo.helpers
    lineNumber: ->
      editor.lineNumber

    column: ->
      editor.column

    selection: ->
      editor.selection

    checksum: ->
      editor.checksum