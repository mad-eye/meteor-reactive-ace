if Meteor.isClient
  Template.demo.helpers
    lineNumber: ->
      editor.lineNumber

    column: ->
      editor.column

    selection: ->
      return unless editor.selection
      start = editor.selection.start
      end = editor.selection.end
      #TODO: Check for start == end and display differently?
      return "(#{start.lineNumber}, #{start.column}) -> (#{end.lineNumber}, #{end.column})"

    checksum: ->
      editor.checksum
      
    ast: ->
      #Need to set editor.parseEnabled = true
      JSON.stringify editor.parsedBody

    parseError: ->
      e = editor.parseError
      return unless e
      "(#{e.lineNumber}, #{e.column}) #{e.description}"

  Template.tagList.helpers
    #Not yet working.
    tags: ->
      console.log "tags"
      return unless editor.parsedBody
      tokens = editor.parsedBody?.tokens
      console.log "Found #{tokens?.length} tokens"
      _.filter tokens, (token) ->
        token.type == "Identifier"
