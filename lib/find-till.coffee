FindTillInputElement = require './find-till-input-element'
{CompositeDisposable} = require 'atom'

module.exports = FindTill =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'find-till:toggle': => @toggle()

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->

  toggle: ->
    el = new FindTillInputElement()
    el.initialize (text) ->
      console.log("found", text)
