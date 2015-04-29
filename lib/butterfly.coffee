ButterflyView = require './butterfly-view'
{CompositeDisposable} = require 'atom'

module.exports = Butterfly =
  butterflyView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @butterflyView = new ButterflyView(state.butterflyViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @butterflyView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'butterfly:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @butterflyView.destroy()

  serialize: ->
    butterflyViewState: @butterflyView.serialize()

  toggle: ->
    if confirm "Are you sure you wish to harness the power of the butterfly?"
      alert "Amazing Physics going on!"
      alert "Successfully flipped one bit!"
    else
      alert "It's time to teach you how to be a true programmer"
      window.load "http://xkcd.com/378"

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
      @modalPanel.hide()
