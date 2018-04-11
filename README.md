# symbols-list package

An alternative symbol list for Atom.io
It is a visual code navigator sidebar build to be as succinct as possible.
Unlike the embed symbol tagger, symbols-list uses a custom list of regexes to match only the essential symbols.

If you want to see more languages or added, open a ticket, or feel free to do a pull request.

![Symbols List](https://raw.githubusercontent.com/7ute/symbols-list/master/package_screenshot.png)

## Currently supported languages / source format
* HTML ( text.html )
* PHP ( text.html.php )
* CSS ( source.css )
* TSS ( source.css.tss )
* JS ( source.js )
* CoffeeScript ( source.coffee )
* Python( source.python )
* Ruby( source.ruby )
* INI/conf ( source.ini )
* Github Markdown ( source.gfm )
* C# ( source.cs )
* Perl ( source.pl, source.pm )

## Settings
* `Start Up` Set panel visibility at startup
* `Alphabetical Sorting` Sorts the symbols alphabetically
* `Hide On Empty List` Hide the list if empty
* `Panel Width` Width of the symbols-list panel (in pixels)
* `Position After Jump` Editor position after selecting symbols (Center, ScrollFromTop or ScrollFromBottom)
* `Position Scroll` Additional line scrolling for fine tuning after position jump
* `Extension File` Path to the CSON file contening your own regex

## Extension file
To add your own regex, create a CSON file in the config directory (usually ~/.atom), set the `Extension File` settings
with the path of that file, and reload/restart Atom.

The file should look like this :

```yaml
text:
    html:
        php:
            regex:
                todo: false
                fixme: false
                hack: /^[^\S\n]*(?:\/\/) \/!\\ (.+)/gmi
```

The hierarchy is ruled like this :

`scope : nested-scope : nested-scope : 'regex' : symbol's name : the regex, or 'false' `

- `scope` and `nested-scope` : This is the language you’re targeting. To get the scope hierarchy of the current open file in Atom, you can execute the command : `atom.workspace.getActivePaneItem().getGrammar().scopeName` in the developper's tool's console. Every sub-scope will inherit it's parent's regex.
- `regex` : keyword indicating the list of regex
- `symbol’s name` : The name of the symbol (#Sherlock). It must match the existing ones. The complete list can be found in the [symbols-list.less](https://github.com/7ute/symbols-list/blob/master/styles/symbols-list.less) file.
- `the regex` : The regex itself. Only the first matching group will be displayed as a label. If you pass `false` insted, it will disable the default regex for that symbol.

Of course, feel free to send your most awesome regex, so we can include them in the package!

## TO DO
* Add the choice of active keyword per language in the settings
* Add more languages/symbols :
  * shell
  * java
  * swift
  * typescript
  * template toolkit
  * …
