{View} = require 'atom-space-pen-views'
{SelectListView} = require 'atom-space-pen-views'

module.exports =
    class SymbolsListView extends SelectListView
        constructor: (serializedState) ->
            super
            @addClass('symbols-list')
            @setItems([])

        items: []
        callOnConfirm: null
        cancelling: true

        initialize: ->
            super

            @filterEditorView.getModel().placeholderText = 'Search…'

        viewForItem: (item) ->
            "<li class='full-menu list-tree'>" +
                "<span class='pastille list-item-#{item.type}'></span>" +
                "<span class='list-item'>#{item.label}</span>" +
            "</li>"

        confirmed: (item) ->
            if item.objet? and @callOnConfirm?
                @callOnConfirm( item.range )

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
            if atom.config.get('symbols-list.alphabecticalSorting')
                @items.sort (a, b) ->
                    a.label.localeCompare(b.label)
            else
                @items.sort (a, b) ->
                    a.range?.start.row - b.range?.start.row
            @setItems(@items)

        serialize: ->

        destroy: ->
            @element.remove()
