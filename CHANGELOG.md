## dev
* Added support for inheritance in Ruby
* Added SASS/SCSS mixins and functions
* Added Vue components regex
* Fixed [Alphabetical sorting doesn't work](https://github.com/7ute/symbols-list/issues/68)

## 2.5.2 - Multiline JS, SASS, Twig and Blade
* Added additional key controls like focus, unfocus and selection, courtesy of @konradjurk
* Added support of multiline method signatures in JS, courtesy of @konradjurk
* Added SASS and SCSS regex
* Added Twig regex
* Added Blade regex
* Improved regex matching

## 2.5.1 - No more warnings and exceptions
* Fixed deprecation warnings.
* Fixed uncaught exception errors (method call on undefined).

## 2.5.0 - Cascade of fixes
* Fixed: [HTML artefact in symbol list](https://github.com/7ute/symbols-list/issues/57)
* Added support for es7 decorators, courtesy of @guiguan
* Fixed: [Different color for public, private and protected methods (visibility)](https://github.com/7ute/symbols-list/issues/54), courtesy of @monsieurluge
* Fixed: [Hiding (toggling) symbol list does not persist when switching tabs](https://github.com/7ute/symbols-list/issues/51), courtesy of @JK-TC
* Fixed: [Javascript Es6Methods with spaces before parenthesis are not recognized](https://github.com/7ute/symbols-list/issues/58), courtesy of @FelixBrendel
* Fixed: [Configurable width setting](https://github.com/7ute/symbols-list/issues/46), courtesy of @DjLeChuck
* Fixed: [support cache for huge files](https://github.com/7ute/symbols-list/issues/47)
* Moved configuration to separate file symbols-list-config
* Added positioning feature and configs to either center the view after jump to line, scroll from top or from bottom for configured amount of lines.
* Added md5 hash checks to reload symbols just on real changes.

## 2.4.1 - Odin and ES2017 tweaks
* Added Odin regex, courtesy of @FelixBrendel
* Improved regex for ES2017, courtesy of @brigand
* Added export keyword for JS functions, poke @DjLeChuck

## 2.4 - Lots of improvements!
* Improved regex strings for Ruby (Differ between class methods and instance methods).
* Added todo,fixme and hack symbols.
* Added support for css.tss, courtesy of @m1ga
* Added new config option to hide panel on empty list.
* Added initial symbols reload to have the list on atom load.
* Added symbols for getters and setters in JavaScript.
* Hide panel in settings view.
* Changed Perl color of our-statements to blue (instead of signal color red).
* Improved Perl source regex strings.
* Improved CoffeeScript source regex strings.
* Improved Python source regex strings.
* Fixed misplaced number in list (not visible because of temporary transparency).
* Fixed height of search filter field to avoid scrollbars.
* Fixed: [Ruby: self is not the name of all class methods](https://github.com/7ute/symbols-list/issues/26)
* Fixed: [Unicode symbol not being recognized](https://github.com/7ute/symbols-list/issues/28)

## 2.3.6 - Perl, YAML and performances
* First trial at fixing [Performance with large files](https://github.com/7ute/symbols-list/issues/36)
* Added Perl regex, courtesy of @mbuc82
* Added YAML comments regex ( line starting with # ! )

## 2.3.5 - Bugfixes for C#
* Quick adjustement on C# regex to avoid control structures matching

## 2.3.4 - Basics for C#
* Added regex for C#

## 2.3.3 - Bugfixes
* List height bugfix

## 2.3.2 - Resizing and moar Python
* [Resizable?](https://github.com/7ute/symbols-list/issues/19) Resizable!
* Improve Python source regex strings, courtesy of @ajoubertza
* Added Github Markup regex

## 2.3.1 - Position highlight and ES2016 tweak
* Added cursor position highlight, courtesy of @JeroenOnstuimig
* Added ES6 method and const function regexes, courtesy of @wooandoo

## 2.3 - Ruby and bugfixes
* Added Ruby regex, courtesy of @aidistan
* Added protected functions
* Fixed jump to line above function for JS
* Fixed function declaration with multiline arguments

## 2.2 - Python and bugfixes
* Added Python regex, courtesy of @firejdl
* Altered PHP regex to add static methods
* Altered PHP and JS multiline comments regex
* Added toggle shortcut for Windows and Linux
* Fixed: [php: jump to lines above function](https://github.com/7ute/symbols-list/issues/8)
* Fixed: [php: methods with & prefix not being listed](https://github.com/7ute/symbols-list/issues/9)

## 2.1.4 - Regex and fix
* Altered JS method regex
* Fixed: [php: comment added to list](https://github.com/7ute/symbols-list/issues/7)

## 2.1.3 - More Regexes
* Altered function regex for PHP
* Added regex for INI

## 2.1.2 - Search and sort
* Bugfix: symbols missing on search field blur
* Added search field placeholder
* Added alphabetical sorting to the plugin settings

## 2.1.1 - EMACScript 6 regexes
* Added ES6 method syntax
* Added JS class expressions regex
* Changed comment symbol to "/" to avoid confusion with HTML anchors "#"

## 2.1.0 - Added test files to the package
* Altered function regex for PHP and JS
* Added HTML anchor regex
* Added test files

## 2.0.0 - First Release
* Because starting at v1 is too mainstream.
* Added regexes for HTML, CSS, JS and Angular, CoffeeScript and PHP
