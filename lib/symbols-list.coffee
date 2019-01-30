{CompositeDisposable} = require 'atom'
Configuration = require './symbols-list-config'
SymbolsListView = require './symbols-list-view'
RegexList = require './symbols-list-regex'
Crypto = require 'crypto'

module.exports =
    config: Configuration,
    SymbolsListView: null,
    panel: null,
    subscriptions: null,
    editor: null,
    code: null,
    isVisible: null,
    FileHashes: []
    FileItemList: []

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
        @subscriptions.add atom.commands.add 'atom-workspace', 'symbols-list:focus': => @focus()
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

        # set width of panel
        if atom.config.get('symbols-list.basic.panelWidth')
            newWidth = parseInt( atom.config.get('symbols-list.basic.panelWidth') )
            @SymbolsListView.element.style.width = newWidth + 'px'

    reloadSymbols: ->

        SymbolsList = this

        #only show panel if toggled to visible
        if @isVisible is no
            SymbolsList.panel.hide()
            return

        @editor = atom.workspace.getActiveTextEditor()

        # hide the list without an available text editor (i.e. in settings view)
        if not @editor? || not @editor.getGrammar()?
            SymbolsList.panel.hide()
            return

        scopeName = @editor.getGrammar().scopeName

        if not scopeName?
            SymbolsList.panel.hide()
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
                SymbolsList.panel.show()
                SymbolsList.SymbolsListView.sortItems()
                SymbolsList.SymbolsListView.loadingArea.hide()

                # determine currently active line and update active item
                if SymbolsList.editor?
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
                            clean_matches = obj.match.slice(1).filter (item) -> typeof(item) isnt 'undefined'
                            first_match = clean_matches[0] || ''
                            @SymbolsListView.addItem({ type:type, label: first_match, objet: obj.match, range: obj.range })
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
            PixelPosition -= (View.getHeight() / 2);
            View.setScrollTop PixelPosition
        else
            PositionScroll = atom.config.get('symbols-list.positioning.positionScroll')
            LineHeight = Editor.getLineHeightInPixels()
            if PositionAfterJump == 'ScrollFromTop'
                PixelPosition -= (LineHeight * PositionScroll);
                View.setScrollTop PixelPosition
            else
                PixelPosition += (LineHeight * PositionScroll);
                View.setScrollBottom PixelPosition

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

    focus: ->
      @SymbolsListView.focusFilterEditor()
