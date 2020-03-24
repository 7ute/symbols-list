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
* JS/Mocha ( source.js )
* TypeScript ( source.ts )
* CoffeeScript ( source.coffee )
* Python( source.python )
* Ruby( source.ruby )
* INI/conf ( source.ini )
* Github Markdown ( source.gfm )
* C# ( source.cs )
* Perl ( source.pl, source.pm )
* Blade ( text.html.php.blade )
* Twig ( text.html.twig )
* SASS/SCSS ( source.sass, source.css.scss )
* Vue components ( text.html.vue )
* LaTeX ( text.tex.latex )
* SQL ( source.sql )

## Settings
* `Start Up` Set panel visibility at startup
* `Alphabetical Sorting` Sorts the symbols alphabetically
* `Hide On Empty List` Hide the list if empty
* `Panel Width` Width of the symbols-list panel (in pixels)
* `Position After Jump` Editor position after selecting symbols (Center, ScrollFromTop or ScrollFromBottom)
* `Position Scroll` Additional line scrolling for fine tuning after position jump

## TO DO
* Add the choice of active keyword per language in the settings
* Add more languages/symbols :
  * shell
  * java
  * swift
  * template toolkit
  * …

## Contributing
To add support for your favorite language, or submit new features, feel free to do a pull request.
For new languages, please include a test file in the `tests` directory.
