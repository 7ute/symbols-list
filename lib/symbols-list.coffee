SymbolsListView = require './symbols-list-view'
RegexList = require './symbols-list-regex'
{CompositeDisposable} = require 'atom'

module.exports =
    config:
        startUp:
            type: 'boolean'
            default: true
            description: 'Set panel visibility at startup.'
        alphabeticalSorting:
            type: 'boolean'
            default: false
            description: 'Sort the list alphabetically'
        hideOnEmptyList:
            type: 'boolean'
            default: false
            description: 'Hide the list if empty'

    SymbolsListView: null,
    panel: null,
    subscriptions: null,
    editor: null,
    code: null

    init: (service) ->


    activate: (state) ->

        # prepare symbols list view object
        @SymbolsListView = new SymbolsListView(state.SymbolsListViewState)
        @SymbolsListView.callOnConfirm = @moveToRange;
        SymbolsList = this

        # add event handlers
        @subscriptions = new CompositeDisposable
        @subscriptions.add atom.commands.add 'atom-workspace', 'symbols-list:toggle': => @toggle()
        @subscriptions.add atom.workspace.onDidChangeActivePaneItem => @reloadSymbols()
        @subscriptions.add atom.workspace.observeTextEditors (editor) =>
            editor.onDidSave ->
                SymbolsList.reloadSymbols()
        @subscriptions.add atom.workspace.observeTextEditors (editor) =>
            editor.onDidChangeCursorPosition (e) ->
                SymbolsList.updateActiveItem(e)

        # setup symbols list on right panel
        @panel = atom.workspace.addRightPanel(item: @SymbolsListView.element, visible: atom.config.get('symbols-list.startUp'), priority: 0)

        # reload symbols for the very first time
        SymbolsList.reloadSymbols()

    reloadSymbols: ->
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
                    SymbolsList.recursiveScanRegex(scopeArray, RegexList, window.performance.now() )

                    # check list for item count and hide it if needed
                    if SymbolsList.SymbolsListView.items.length
                        SymbolsList.panel.show()
                        SymbolsList.SymbolsListView.sortItems()
                        SymbolsList.SymbolsListView.loadingArea.hide()
                    else
                        if SymbolsList.panel.isVisible() && atom.config.get('symbols-list.hideOnEmptyList')
                            SymbolsList.panel.hide()
                        else
                            SymbolsList.panel.show()
                            SymbolsList.SymbolsListView.sortItems()
                            SymbolsList.SymbolsListView.loadingArea.hide()
                ,0)
        else
            if this.panel.isVisible()
                this.panel.hide()

    updateActiveItem: ( e )->
        if atom.config.get('symbols-list.alphabeticalSorting')
            return
        if e.oldBufferPosition.row == e.newBufferPosition.row
            return

        for key,item of @SymbolsListView.items
            if e.newBufferPosition.row < item.range.start.row
                continue;
            if (parseInt(key)+1) < @SymbolsListView.items.length && e.newBufferPosition.row >= @SymbolsListView.items[parseInt(key)+1].range.start.row
                continue;

            @SymbolsListView.selectItemView( @SymbolsListView.list.find('li').eq( key ) )

    recursiveScanRegex: ( scopeArray, regexGroup, start )->
            current = window.performance.now()
            recursive_time_limit = 500.0
            for key,val of regexGroup
                if key == 'regex'
                    for type,regex of val
                        current = window.performance.now()
                        if not @editor? || current - start > recursive_time_limit
                            return;
                        @editor.scan regex, (obj) =>
                            @SymbolsListView.addItem({ type:type, label: obj.match[1], objet: obj.match, range: obj.range })
                else if key == scopeArray[0] && current - start < recursive_time_limit
                    @recursiveScanRegex( scopeArray.slice(1), val, start )

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
