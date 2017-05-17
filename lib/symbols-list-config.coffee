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
