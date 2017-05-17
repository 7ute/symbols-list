{CompositeDisposable} = require 'atom'
Configuration = require './symbols-list-config'
SymbolsListView = require './symbols-list-view'
RegexList = require './symbols-list-regex'

module.exports =
    config: Configuration,
    SymbolsListView: null,
    panel: null,
    subscriptions: null,
    editor: null,
    code: null,
    isVisible: null

    init: (service) ->

    activate: (state) ->

        # prepare symbols list view object
        @SymbolsListView = new SymbolsListView(state.SymbolsListViewState)
        @SymbolsListView.callOnConfirm = @moveToRange;
        SymbolsList = this

        # set initial visiblilty state
        @isVisible = atom.config.get('symbols-list.basic.startUp')

        # add event handlers
        @subscriptions = new CompositeDisposable
        @subscriptions.add atom.commands.add 'atom-workspace', 'symbols-list:toggle': => @toggle()
        @subscriptions.add atom.workspace.onDidChangeActivePaneItem => @reloadSymbols()
        @subscriptions.add atom.workspace.observeTextEditors (editor) =>
            editor.onDidSave ->
                SymbolsList.reloadSymbols()
            editor.onDidChangeCursorPosition (e) ->
                SymbolsList.updateActiveItem(e)

        # setup symbols list on right panel
        @panel = atom.workspace.addRightPanel(item: @SymbolsListView.element, visible: @isVisible, priority: 0)

        # reload symbols for the very first time
        SymbolsList.reloadSymbols()

    reloadSymbols: ->

        # prepare symbols list view for reload
        @SymbolsListView.cleanItems()
        @SymbolsListView.setError()

        # check if we face a text editor to reload the list for
        @editor = atom.workspace.getActiveTextEditor()

        SymbolsList = this

        #only show panel if toggled to visible
        if @isVisible is no
            SymbolsList.panel.hide()
            return

        # hide the list without an available text editor (i.e. in settings view)
        if not @editor? || not @editor.getGrammar()?
            SymbolsList.panel.hide()
            return

        scopeName = @editor.getGrammar().scopeName

        if not scopeName?
            SymbolsList.panel.hide()
            return

        scopeArray = scopeName.split('.');

        # asynchronous loading
        @SymbolsListView.setLoading('Loading…')

        setTimeout(->
            SymbolsList.SymbolsListView.cleanItems()
            SymbolsList.recursiveScanRegex(scopeArray, RegexList, window.performance.now() )

            # check list for item count and hide it if needed
            if SymbolsList.SymbolsListView.items.length

                # show panel, re-sort items and hide the loader afterwards
                SymbolsList.panel.show()
                SymbolsList.SymbolsListView.sortItems()
                SymbolsList.SymbolsListView.loadingArea.hide()

                # determine currently active line and update active item
                CursorBufferPosition = SymbolsList.editor.getCursorBufferPosition()
                SymbolsList.updateActiveItem(CursorBufferPosition)
            else
                if atom.config.get('symbols-list.basic.hideOnEmptyList')
                    SymbolsList.panel.hide()
                else
                    SymbolsList.panel.show()
                    SymbolsList.SymbolsListView.sortItems()
                    SymbolsList.SymbolsListView.loadingArea.hide()
        ,0)

    updateActiveItem: (e) ->

        # TODO: currently no active item updates on alphabetical sorting
        if atom.config.get('symbols-list.basic.alphabeticalSorting')
            return

        if e.row?
            ActiveRow = e.row
        else if e.newBufferPosition.row?
            if e.oldBufferPosition.row == e.newBufferPosition.row
                return
            else
                ActiveRow = e.newBufferPosition.row

        for key,item of @SymbolsListView.items
            if ActiveRow < item.range.start.row
                continue;
            if (parseInt(key)+1) < @SymbolsListView.items.length && ActiveRow >= @SymbolsListView.items[parseInt(key)+1].range.start.row
                continue;

            @SymbolsListView.selectItemView( @SymbolsListView.list.find('li').eq( key ) )

    recursiveScanRegex: ( scopeArray, regexGroup, start ) ->

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

    moveToRange: (range) ->

        PositionAfterJump = atom.config.get('symbols-list.positioning.positionAfterJump')

        Editor = atom.workspace.getActiveTextEditor()
        Editor.setCursorBufferPosition(range.start)

        Cursor = Editor.getCursorScreenPosition()
        View = atom.views.getView(Editor);
        PixelPosition = View.pixelPositionForScreenPosition(Cursor).top

        if PositionAfterJump == 'Center'
            PixelPosition -= (Editor.getHeight() / 2);
            Editor.setScrollTop PixelPosition
        else
            PositionScroll = atom.config.get('symbols-list.positioning.positionScroll')
            LineHeight = Editor.getLineHeightInPixels()
            if PositionAfterJump == 'ScrollFromTop'
                PixelPosition -= (LineHeight * PositionScroll);
                Editor.setScrollTop PixelPosition
            else
                PixelPosition += (LineHeight * PositionScroll);
                Editor.setScrollBottom PixelPosition

    deactivate: ->
        @panel.destroy()
        @subscriptions.dispose()
        @SymbolsListView.destroy()

    serialize: ->
        SymbolsListViewState: @SymbolsListView.serialize()

    toggle: ->
        if @isVisible
            @panel.hide()
            @isVisible = false
        else
            @panel.show()
            @isVisible = true
            @reloadSymbols()
