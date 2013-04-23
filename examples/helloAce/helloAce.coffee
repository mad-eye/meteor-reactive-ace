if Meteor.isClient
  Template.demo.helpers
    lineNumber: ->
      editor.lineNumber

    column: ->
      editor.column

    selection: ->
      console.log editor.selection
      editor.selection

    checksum: ->
      editor.checksum