class @ReactiveAce
  constructor: ->
    @_deps = {}

  attach: (editorId) ->
    return if @_attached
    @_attached = true
    @_editor = ace.edit editorId
    for k, dep of @deps
      dep.changed()
    @setupEvents()

  depend: (key) ->
    @_deps[key] ?= new Deps.Dependency
    @_deps[key].depend()

  change: (key) ->
    @_deps[key]?.changed()

  setupEvents: ->
    @_editor.on "changeSelection", =>
      #TODO could be smarter and only invalidate these when they change
      @change 'lineNumber'
      @change 'column'
      @change 'selection'

    @_editor.on "change", =>
      @change 'checksum'
      @change 'value'

  _getEditor: ->
    @depend 'attached'
    return @_editor

  _getSession: ->
    @depend 'attached'
    return @_editor?.getSession()

ReactiveAce.addProperty = (name, getter, setter) ->
  descriptor = {}
  if getter
    descriptor.get = ->
      @depend name
      return getter.call(this)
  if setter
    descriptor.set = (value) ->
      return if getter and value == getter.call this
      @change name
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
    @_editor?.getShowInvisibles()
  , (value) ->
    @_editor?.setShowInvisibles value

ReactiveAce.addProperty 'tabSize', ->
    return @_getSession()?.getTabSize()
  , (value) ->
    @_getSession()?.setTabSize value

ReactiveAce.addProperty "theme", ->
    return @_editor?.getTheme()?.split("/").pop()
  , (value) ->
    @_editor?.setTheme "ace/theme/#{value}"

ReactiveAce.addProperty "syntaxMode", ->
    return @_getSession()?.getMode()?.$id?.split("/").pop()
  , (value) ->
    @_getSession()?.setMode "ace/mode/#{value}"

#TODO: Doesn't work yet
#ReactiveAce.addProperty "keybinding", ->
    #return @_editor?.getKeyboardHandler()
  #, (value) ->
    #@_editor?.setKeyboardHandler "ace/keyboard/#{value}"

ReactiveAce.addProperty 'useSoftTabs', ->
    return @_getSession()?.getUseSoftTabs()
  , (value) ->
    @_getSession()?.setUseSoftTabs value
    
ReactiveAce.addProperty 'wordWrap', ->
    return @_getSession()?.getUseWrapMode()
  , (value) ->
    @_getSession()?.setUseWrapMode value
    @_getSession()?.setWrapLimitRange null, null

###
# Read Only properties
###

#TODO: Throttle this with _.throttle
ReactiveAce.addProperty 'value', ->
    return @_editor?.getValue()

ReactiveAce.addProperty 'selection', ->
    @_editor?.getSelectionRange()
    #TODO code below doesn't work..
#  , (value) ->
#    @_editor?.clearSelection()
#    @_editor?.addSelectionMarker(value)

#TODO: Defined this using Object.defineProperty, and use value's Dep
ReactiveAce.addProperty 'checksum', ->
  #TODO maybe need to rate limit this?
  if @_editor?.getValue()
    crc32 @_editor?.getValue()
