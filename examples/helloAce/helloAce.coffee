if Meteor.isClient
  window.editor = new ReactiveAce

  Meteor.startup ->
    Template.aceEditor.rendered = ->
      editor.attach ace.edit "aceEditor"

  window.editor = new ReactiveAce

  Template.demo.rendered = ->
    #generate abstract syntax tree
    editor.parseEnabled = true

  Template.demo.helpers
    status: ->
      lineNumber = editor.lineNumber ? 0
      column = editor.column ? 0
      output = "(#{lineNumber}, #{column})"
      
      selection = editor.selection
      if selection and not _.isEqual selection.start, selection.end
        start = selection.start
        end = selection.end
        #TODO: Check for start == end and display differently?
        output += "\tSelection (#{start.lineNumber}, #{start.column}) -> (#{end.lineNumber}, #{end.column})"
      if editor.checksum
        output += "\tChecksum: #{editor.checksum}"
      output

    ast: ->
      #Need to set editor.parseEnabled = true
      JSON.stringify editor.parsedBody, null, 2
    
    functions: ->
      children = (parent)->
        _.each parent, (child)->
          console.log(child)
          if _.isArray(child) or _.isObject(child)
            console.log("fetch my children")
            children(child)
      return children(editor.parsedBody)

    errorDisplay: ->
      e = editor.parseError
      return unless e
      "SYNTAX ERROR: (#{e.lineNumber}, #{e.column}) #{e.description}"

  Template.tagList.helpers
    #Not yet working.
    tags: ->
      return unless editor.parsedBody
      tokens = editor.parsedBody.tokens
      tags = []
      for token in tokens
        continue unless token.type == "Identifier"
        tag =
            name: token.value
            position: token.loc.start
        tags.push tag
      return tags
        

