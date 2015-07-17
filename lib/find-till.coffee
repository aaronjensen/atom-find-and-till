FindTillInputElement = require './find-till-input-element'
{CompositeDisposable} = require 'atom'

module.exports = FindTill =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-text-editor', 'find-till:toggle': => @toggle()

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->

  toggle: ->
    return unless editor = atom.workspace.getActiveTextEditor()

    new FindTillInputElement().initialize (text) ->
      return unless text
      char = text[0]

      cursor = editor.getCursorBufferPosition()
      line = editor.lineTextForBufferRow(cursor.row)
      index = line.indexOf(char, cursor.column + 1)

      return unless index > 0

      editor.setCursorBufferPosition([cursor.row, index])
