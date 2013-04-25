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
    @_editor.getShowInvisibles()
  , (value) ->
    @_editor.setShowInvisibles value

ReactiveAce.addProperty 'tabSize', ->
    return @_editor?.getSession()?.getTabSize()
  , (value) ->
    @_editor.getSession().setTabSize tabSize

ReactiveAce.addProperty 'useSoftTabs', ->
    return @_editor?.getSession()?.getUseSoftTabs()
  , (value) ->
    @_editor.getSession().setUseSoftTabs value
    
ReactiveAce.addProperty 'value', ->
    return @_editor?.getValue()

###
# Read Only properties
###

ReactiveAce.addProperty 'selection', ->
    @_editor?.getSelectionRange()
    #TODO code below doesn't work..
#  , (value) ->
#    @_editor?.clearSelection()
#    @_editor?.addSelectionMarker(value)

ReactiveAce.addProperty 'checksum', ->
  #TODO maybe need to rate limit this?
  if @_editor?.getValue()
    crc32 @_editor?.getValue()
