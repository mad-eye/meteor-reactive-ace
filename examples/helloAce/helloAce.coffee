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
      value = editor.value
      try 
        JSON.stringify esprima.parse value
      catch e
        #console.log "probably a parse error:", e.message

  Template.tagList.helpers
    tags: ->
      doc = null
      try
        doc = esprima.parse(editor.value)
        console.log "Doc:", doc
      catch e
        return
      tags = []
      for elt in doc.body
        console.log "Returning", JSON.stringify elt
        tags.push elt
      tags
           
