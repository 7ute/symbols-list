SymbolsListView = require './symbols-list-view'
RegexList = require './symbols-list-regex'
{CompositeDisposable} = require 'atom'

module.exports =
    config:
        startUp:
            type: 'boolean'
            default: true
            description: 'Set panel visibility at startup.'
        alphabecticalSorting:
            type: 'boolean'
            default: false
            description: 'Sort the list alphabetically'

    SymbolsListView: null,
    panel: null,
    subscriptions: null,
    editor: null,
    code: null

    init: (service) ->


    activate: (state) ->
        @SymbolsListView = new SymbolsListView(state.SymbolsListViewState)
        @SymbolsListView.callOnConfirm = @moveToRange;
        SymbolsList = this
        @subscriptions = new CompositeDisposable
        @subscriptions.add atom.commands.add 'atom-workspace', 'symbols-list:toggle': => @toggle()
        @subscriptions.add atom.workspace.onDidChangeActivePaneItem => @reloadSymbols()
        @subscriptions.add atom.workspace.observeTextEditors (editor) =>
            editor.onDidSave ->
                SymbolsList.reloadSymbols()
        @subscriptions.add atom.workspace.observeTextEditors (editor) =>
            editor.onDidChangeCursorPosition (e) ->
                SymbolsList.updateActiveItem(e)
        @panel = atom.workspace.addRightPanel(item: @SymbolsListView.element, visible: atom.config.get('symbols-list.startUp'), priority: 0)

    reloadSymbols: ->
        console.log(@editor,atom.workspace )
        @editor = atom.workspace.getActiveTextEditor()
        parent = @SymbolsListView
        @SymbolsListView.cleanItems()

        @SymbolsListView.setError()

        if @editor? and @editor.getGrammar()?
            scopeName = @editor.getGrammar().scopeName
            if scopeName?
                console.log('Scope:',scopeName)
                scopeArray = scopeName.split('.');
                SymbolsList = this
                @SymbolsListView.setLoading('Loading…')
                # Async loading
                setTimeout(->
                    SymbolsList.SymbolsListView.cleanItems()
                    SymbolsList.recursiveScanRegex(scopeArray, RegexList )
                    SymbolsList.SymbolsListView.sortItems()
                    SymbolsList.SymbolsListView.loadingArea.hide()
                ,0)

    updateActiveItem: ( e )->
        if e.oldBufferPosition.row == e.newBufferPosition.row
            return

        for key,item of @SymbolsListView.items
            if e.newBufferPosition.row < item.range.start.row
                continue;
            if (parseInt(key)+1) < @SymbolsListView.items.length && e.newBufferPosition.row >= @SymbolsListView.items[parseInt(key)+1].range.start.row
                continue;

            @SymbolsListView.selectItemView( @SymbolsListView.list.find('li').eq( key ) )

    recursiveScanRegex: ( scopeArray, regexGroup )->
        for key,val of regexGroup
            if key == 'regex'
                for type,regex of val
                    if not @editor?
                        return;
                    @editor.scan regex, (obj) =>
                        @SymbolsListView.addItem({ type:type, label: obj.match[1], objet: obj.match, range: obj.range })
            else if key == scopeArray[0]
                @recursiveScanRegex( scopeArray.slice(1), val )

    moveToRange:(range) ->
        @editor = atom.workspace.getActiveTextEditor()
        @editor.setCursorBufferPosition(range.start)
        @editor.scrollToCursorPosition({center: false})

    deactivate: ->
        @panel.destroy()
        @subscriptions.dispose()
        @SymbolsListView.destroy()

    serialize: ->
        SymbolsListViewState: @SymbolsListView.serialize()

    toggle: ->
        if @panel.isVisible()
            @panel.hide()
        else
            @panel.show()
            @reloadSymbols()
