class @ReactiveAce
  constructor: ->
    @_deps = {}

  attach: (editorId) ->
    @_editor = ace.edit editorId
    for k, v of @deps
      v.changed()

  depend: (key) ->
    @_deps[key] ?= new Deps.Dependency
    @_deps[key].depend()


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
    descriptor.get = =>
      return getter()
  if setter
    descriptor.set = (value) =>
      setter value

Object.defineProperty ReactiveAce.prototype, 'lineNumber',
  get: ->
    @depend 'lineNumber'
    @_editor?.getCursorPosition().row + 1

  set: (value) ->
    row = value - 1
    return if row == @_editor?.getCursorPosition().row
    @_deps['lineNumber']?.changed()
    column = @_editor?.getCursorPosition().column
    @_editor?.navigateTo row, column

