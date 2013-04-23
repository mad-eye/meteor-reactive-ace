class @ReactiveAce
  constructor: ->
    @_deps = {}

  attach: (editorId) ->
    return if @_attached
    @_attached = true
    @_editor = ace.edit editorId
    for k, v of @deps
      v.changed()
    @setupEvents()

  depend: (key) ->
    @_deps[key] ?= new Deps.Dependency
    @_deps[key].depend()

  setupEvents: ->
    @_editor.on "changeSelection", =>
      @_deps['lineNumber']?.changed()


#properties:
#  lineNumber
#  column
#  checksum?
#  selection (null or range)
#  theme
#
#

ReactiveAce.addProperty = (name, getter, setter) ->
  descriptor = {}
  if getter
    descriptor.get = ->
      @depend name
      return getter.call(this)
  if setter
    descriptor.set = (value) ->
      return if getter and value == getter.call this
      @_deps[name]?.changed()
      setter.call this, value
  Object.defineProperty ReactiveAce.prototype, name, descriptor

ReactiveAce.addProperty 'lineNumber', ->
    @_editor?.getCursorPosition().row + 1
  , (value) ->
    row = value - 1
    column = @_editor?.getCursorPosition().column
    @_editor?.navigateTo row, column

ReactiveAce.addProperty 'column', ->
    @_editor?.getCursorPosition().column + 1
  , (value) ->
    column = value - 1
    row = @_editor?.getCursorPosition().row
    @_editor?.navigateTo row, column

ReactiveAce.addProperty 'showInvisibles', ->
    @_editor.getShowInvisibles()
  , (value) ->
    @_editor.setShowInvisibles value

ReactiveAce.addProperty 'theme', ->
    @_editor.getTheme()
  , (value) ->
    @_editor.setTheme("ace/theme/"+value)

