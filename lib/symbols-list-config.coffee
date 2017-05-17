module.exports =
    basic:
      order: 1
      type: "object"
      properties:
        startUp:
            order: 1
            title: "Start Up"
            type: "boolean"
            default: true
            description: "Set panel visibility at startup."
        alphabeticalSorting:
            order: 2
            title: "Alphabetical Sorting"
            type: "boolean"
            default: false
            description: "Sort the list alphabetically"
        hideOnEmptyList:
            order: 3
            title: "Hide On Empty List"
            type: "boolean"
            default: false
            description: "Hide the list if empty"
        panelWidth:
            order: 4
            title: "Panel Width"
            type: 'integer'
            default: 200
            description: 'Width of the symbols-list panel (in pixels)'
    positioning:
      order: 2
      type: "object"
      properties:
        positionAfterJump:
            order: 1
            title: "Position After Jump"
            type: "string"
            default: "ScrollFromTop"
            description: "Center = center the line after jump; ScrollFromTop = Scroll the line from the top (using Position Scroll); ScrollFromBottom = Scroll the line from the bottom (using Position Scroll)"
            enum: ["Center", "ScrollFromTop", "ScrollFromBottom"]
        positionScroll:
            order: 2
            title: "Position Scroll"
            type: ["integer"]
            default: 20
            description: "positive value = scroll from top / negative value = scroll from bottom"
