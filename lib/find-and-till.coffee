FindAndTillInputElement = require './find-and-till-input-element'
{CompositeDisposable} = require 'atom'

reverse = (line, char, cursorPos) ->
  line.slice(0, cursorPos - 1).lastIndexOf(char)

forward = (line, char, cursorPos) ->
  line.indexOf(char, cursorPos + 1)

moveCursors = (editor, [first, rest...]) ->
  [row, column] = first
  editor.setCursorBufferPosition([row, column])
  rest.forEach ([row, column]) ->
    editor.addCursorAtBufferPosition([row, column])

module.exports = FindAndTill =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-text-editor', 'find-and-till:find': => @find()
    @subscriptions.add atom.commands.add 'atom-text-editor', 'find-and-till:find-backwards': => @findBackwards()
    @subscriptions.add atom.commands.add 'atom-text-editor', 'find-and-till:till': => @till()
    @subscriptions.add atom.commands.add 'atom-text-editor', 'find-and-till:till-backwards': => @tillBackwards()

  deactivate: ->
    @subscriptions.dispose()

  find: -> @FindAndTill(0, forward)
  findBackwards: -> @FindAndTill(1, reverse)
  till: -> @FindAndTill(1, forward)
  tillBackwards: -> @FindAndTill(0, reverse)

  FindAndTill: (offset, finder) ->
    return unless editor = atom.workspace.getActiveTextEditor()

    new FindAndTillInputElement().initialize (text) ->
      return unless text
      char = text[0]

      newCursors = editor.getCursorBufferPositions().map (cursor) ->
        line = editor.lineTextForBufferRow(cursor.row)
        index = finder(line, char, cursor.column)
        return cursor unless index > 0
        [cursor.row, index + offset]

      moveCursors(editor, newCursors)
