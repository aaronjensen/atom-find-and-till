EditorState = require './editor-state'

describe "Find and Till", ->
  [editor, editorView] = []

  beforeEach ->
    expect(atom.packages.isPackageActive("find-and-till")).toBe false

    waitsForPromise -> atom.workspace.open()
    runs ->
      editor = atom.workspace.getActiveTextEditor()
      editorView = atom.views.getView(editor)
      workspaceElement = atom.views.getView(atom.workspace)
      jasmine.attachToDOM(workspaceElement)

  describe "find", ->
    it "moves after the letter pressed", ->
      setState "tes[0]ting 1234"
      sendCommand "find-and-till:find", "g"
      expectStateToBe "testing[0] 1234"

    it "handles multiple cursors", ->
      setState "zz aa[0]aa zz\nzz bb[1]bb zz"
      sendCommand "find-and-till:find", "z"
      expectStateToBe "zz aaaa z[0]z\nzz bbbb z[1]z"

  setState = (state) ->
    EditorState.set(editor, state)

  sendCommand = (command, char) ->
    activationPromise = atom.packages.activatePackage("find-and-till")
    atom.commands.dispatch editorView, command
    waitsForPromise -> activationPromise
    runs -> editor.findAndTillInputView.getModel().setText(char)

  expectStateToBe = (state) ->
    runs -> expect(EditorState.get(editor)).toBe state
