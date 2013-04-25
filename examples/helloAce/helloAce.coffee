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
      
    ast: ->
      #Need to set editor.parseEnabled = true
      JSON.stringify editor.parsedBody

    parseError: ->
      #Need to set editor.parseEnabled = true
      editor.parseError

  Template.tagList.helpers
    #Not yet working.
    tags: ->
      console.log "tags"
      return unless editor.parsedBody
      tokens = editor.parsedBody?.tokens
      console.log "Found #{tokens?.length} tokens"
      _.filter tokens, (token) ->
        token.type == "Identifier"
