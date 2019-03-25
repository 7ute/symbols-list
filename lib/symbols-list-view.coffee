{View} = require 'atom-space-pen-views'
{SelectListView} = require 'atom-space-pen-views'

module.exports =
    class SymbolsListView extends SelectListView
        @content: ->
            @div =>
                super
                @div class: 'panel-resize-handle', outlet: 'resizeHandle'

        items: []
        callOnConfirm: null
        cancelling: true


        handleEvents: =>
            @on 'mousedown', '.panel-resize-handle', (e) => @resizeStarted(e)

        resizeStarted: =>
            document.addEventListener('mousemove', @resizeListView)
            document.addEventListener('mouseup', @resizeStopped)

        resizeStopped: =>
            document.removeEventListener('mousemove', @resizeListView)
            document.removeEventListener('mouseup', @resizeStopped)

        resizeListView: ({pageX, which}) =>
            totalWidth  = document.body.clientWidth
            liste = document.querySelector(".symbols-list")
            newWidth   = parseInt( totalWidth - pageX )
            if ( newWidth >= 150 && newWidth < ( totalWidth / 2 ) )
                liste.style.width = parseInt( totalWidth - pageX ) + 'px'


        initialize: ->
            super

            @addClass('symbols-list')
            @setItems([])

            @filterEditorView.getModel().placeholderText = 'Start typing to filter...'
            @handleEvents()

            atom.commands.add @element, 'symbols-list:alt-confirm': (event) =>
                @altConfirmed()
                event.stopPropagation()

        escapeHtml: (unsafe) ->
            if (! unsafe)
                return ''
            return unsafe
                 .replace(/&/g, "&amp;")
                 .replace(/</g, "&lt;")
                 .replace(/>/g, "&gt;")
                 .replace(/"/g, "&quot;")
                 .replace(/'/g, "&#039;");

        viewForItem: (item) ->
            "<li class='full-menu list-tree'>" +
                "<span class='pastille list-item-#{item.type}'></span>" +
                "<span class='list-item'>" + @escapeHtml(item.label) + "</span>" +
            "</li>"

        confirmed: (item) ->
            if item.objet? and @callOnConfirm?
                @callOnConfirm( item.range )

        altConfirmed: () ->
            item = @getSelectedItem()

            if item.objet? and @callOnConfirm?
                @callOnConfirm( item.range, true )

        cleanItems: () ->
            @items = []
            @setItems(@items)

        cancel: ->
            @cleanItems()

        getFilterKey: () -> "label"

        addItem: (item) ->
            @items.push(item)
            @setItems(@items)

        sortItems: () ->
            if atom.config.get('symbols-list.basic.alphabeticalSorting')
                @items.sort (a, b) ->
                    a.label.localeCompare(b.label)
            else
                @items.sort (a, b) ->
                    a.range?.start.row - b.range?.start.row
            @setItems(@items)

        getItemList: ->
            return @items

        setItemList: (itemlist) ->
            @setItems(itemlist)

        serialize: ->

        destroy: ->
            @element.remove()
