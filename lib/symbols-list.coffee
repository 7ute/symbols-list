{CompositeDisposable} = require 'atom'
Configuration = require './symbols-list-config'
SymbolsListView = require './symbols-list-view'
RegexList = require './symbols-list-regex'
Crypto = require 'crypto'
SYMBOLS_LIST_URI = 'atom://symbols-list'

module.exports =
    config: Configuration,
    SymbolsListView: null,
    subscriptions: null,
    editor: null,
    isVisible: false,
    FileHashes: []
    FileItemList: []

    initialize: (service) ->

    activate: (state) ->

        # prepare symbols list view object
        @SymbolsListView = new SymbolsListView(state.SymbolsListViewState)
        @SymbolsListView.callOnConfirm = @moveToRange

        # add event handlers
        @handleEvents()

        # set configured width of panel
        # if atom.config.get('symbols-list.basic.panelWidth')?
        #     @SymbolsListView.element.style.width = parseInt(panelWidth) + 'px'

        # set initial visiblilty state
        if atom.config.get('symbols-list.basic.startUp')
            @toggle()
            @reloadSymbols()

    handleEvents: ->

        @subscriptions = new CompositeDisposable

        # register commands
        @subscriptions.add atom.commands.add 'atom-workspace', 'symbols-list:toggle': => @toggle()

        # register opener for SymbolsListView objects
        @subscriptions.add atom.workspace.addOpener (uri) =>
            return @SymbolsListView if uri is SYMBOLS_LIST_URI

        # register event listeners
        SymbolsList = this
        @subscriptions.add atom.workspace.getCenter().onDidChangeActivePaneItem => @reloadSymbols()
        @subscriptions.add atom.workspace.observeTextEditors (editor) =>
            editor.onDidSave ->
                SymbolsList.reloadSymbols()
            editor.onDidChangeCursorPosition (e) ->
                SymbolsList.updateActiveItem(e)
        @subscriptions.add atom.workspace.observePaneItems (item) =>
            if item instanceof SymbolsListView
                atom.workspace.paneForURI(SYMBOLS_LIST_URI).onWillDestroyItem (event) =>
                    if event.item instanceof SymbolsListView
                        @isVisible = false

    show: ->
        atom.workspace.open(SYMBOLS_LIST_URI, {
            searchAllPanes: true,
        })

    hide: ->

        # Just hide the dock, if SymbolsList is the only item in the current pane
        # and/or if the related dock contains not more panes with items.
        SymbolsListPane = atom.workspace.paneForURI(SYMBOLS_LIST_URI)
        return if not SymbolsListPane?
        return if SymbolsListPane.items.length > 1
        return if SymbolsListPane.parent.element.children.length > 1

        atom.workspace.hide(@SymbolsListView)

    toggle: ->

        if @isVisible is false
            @isVisible = true
            @show()
            @reloadSymbols()
        else
            @isVisible = false
            @hide()

    serialize: ->
        SymbolsListViewState: @SymbolsListView.serialize()

    deactivate: ->
        @subscriptions.dispose()
        @SymbolsListView.destroy()

    reloadSymbols: ->

        SymbolsList = this

        # only show panel if toggled to visible
        if @isVisible is false
            @hide()
            return

        @editor = atom.workspace.getCenter().getActiveTextEditor()

        # hide the list without an available text editor (i.e. in settings view)
        if not @editor? || not @editor.getGrammar()?
            @hide()
            return

        scopeName = @editor.getGrammar().scopeName

        if not scopeName?
            @hide()
            return

        # check if we really need to reload the symbols list
        CurrentFileHash = Crypto.createHash('md5').update(@editor.getText()).digest('hex')
        CurrentFilePath = @editor.getPath()

        if not @FileHashes[CurrentFilePath]? || @FileHashes[CurrentFilePath] != CurrentFileHash

            # prepare symbols list view for reload
            @SymbolsListView.cleanItems()
            @SymbolsListView.setError()

            # asynchronous loading
            @SymbolsListView.setLoading('Loading…')

        setTimeout(->

            if not SymbolsList.FileHashes[CurrentFilePath]? || SymbolsList.FileHashes[CurrentFilePath] != CurrentFileHash

                scopeArray = scopeName.split('.')

                SymbolsList.SymbolsListView.cleanItems()
                SymbolsList.recursiveScanRegex(scopeArray, RegexList, window.performance.now() )

                SymbolsList.FileHashes[CurrentFilePath] = CurrentFileHash
                SymbolsList.FileItemList[CurrentFilePath] = SymbolsList.SymbolsListView.getItemList()
            else
                SymbolsList.SymbolsListView.setItemList(SymbolsList.FileItemList[CurrentFilePath])

            # check list for item count and hide it if needed
            if SymbolsList.SymbolsListView.items.length

                # show panel, re-sort items and hide the loader afterwards
                SymbolsList.show()
                SymbolsList.SymbolsListView.sortItems()
                SymbolsList.SymbolsListView.loadingArea.hide()

                # determine currently active line and update active item
                CursorBufferPosition = SymbolsList.editor.getCursorBufferPosition()
                SymbolsList.updateActiveItem(CursorBufferPosition)
            else
                if atom.config.get('symbols-list.basic.hideOnEmptyList')
                    SymbolsList.hide()
                else
                    SymbolsList.show()
                    SymbolsList.SymbolsListView.sortItems()
                    SymbolsList.SymbolsListView.loadingArea.hide()
        ,0)

    updateActiveItem: (e) ->

        # TODO: currently no active item updates on alphabetical sorting
        return if atom.config.get('symbols-list.basic.alphabeticalSorting')

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

        Editor = atom.workspace.getCenter().getActiveTextEditor()
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
