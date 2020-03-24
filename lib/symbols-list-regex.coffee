# TO TEST REGEX
# https://regexper.com/

module.exports =
    text:
        html:
            regex:
                commentaire_html: /^[^\S\n]*<!-- ! (.+)-->/gmi
                structure: /^[^\S\n]*<(?:(?:head|body|section)(?:(?:[^<]*)aria-label="([^"]+)")|(head|body|section))/gmi
                entete: /^[^\S\n]*<h[1-9][^>]*>(?:(?!{{|{#|<\?php)([^<]*)|[^<]*)<\/h[1-9]>/gmi
                anchor: /^[^\S\n]*<[^>]*id=["']+([^"']+)["'][^>]*>/gmi
            php:
                regex:
                    commentaire: /^[^\S\n]*(?:\/\/|#) ! (.+)/gmi
                    commentaire_multi: /^[^\S\n]*\/\* ! (.+)[^\/]*\*\//gmi
                    class: /^[^\S\n]*class ([\w]+)/gmi
                    methode_statique: /^(?:final|abstract|private|protected|public|[^\S\n])*static\sfunction\s?((?:&\s?)?[\w]+ *\([^\)]*\))/gmi
                    function: /^(?:final|abstract|public|[^\S\n])*function\s?((?:&\s?)?[\w]+ *\([^\)]*\))/gmi
                    private_function: /^[^\S\n]*private[^\S\n]+function\s?((?:&\s?)?[\w]+ *\([^\)]*\))/gmi
                    protected_function: /^[^\S\n]*protected[^\S\n]+function\s?((?:&\s?)?[\w]+ *\([^\)]*\))/gmi
                    todo: /(?:\/\*|\/\/)[ ]*todo\:[ ]*(.+?)[ ]*(?:\*\/|\r\n|\n)/gmi
                    fixme: /(?:\/\*|\/\/)[ ]*fixme\:[ ]*(.+?)[ ]*(?:\*\/|\r\n|\n)/gmi
                    hack: /(?:\/\*|\/\/)[ ]*hack\:[ ]*(.+?)[ ]*(?:\*\/|\r\n|\n)/gmi
                blade:
                    regex:
                        commentaire: /^[^\S\n]*(?:{{--) ! ([^}]+) --}}(?:\r\n|\n)/gmi
                        blade_section: /^[^\S\n]*(?:@section\(['\s]*)([^'\(\)]+)/gmi
            twig:
                regex:
                    commentaire: /^[^\S\n]*(?:{#) ! ([^}]+) #}(?:\r\n|\n)/gmi
                    twig_block: /^[^\S\n]*(?:{% block ['\s]*)([^']+)[']?\s%}/gmi
                    twig_macro: /^[^\S\n]*(?:{% macro ['\s]*)([^']+)[']?\s%}/gmi
            vue:
                regex:
                    commentaire: /^[^\S\n]*\/\/ ! (.+)/gmi
                    commentaire_multi: /^[^\S\n]*\/\* ! (.+)[^\/]*\*\//gmi
                    vue_template: /^[^\S\n]*<(?:(?:template)(?:(?:[^<]*)lang="([^"]+)")|(template))/gmi
                    vue_script: /^[^\S\n]*<(?:(?:script)(?:(?:[^<]*)lang="([^"]+)")|(script))/gmi
                    vue_style: /^[^\S\n]*<(?:(?:style)(?:(?:[^<]*)lang="([^"]+)")|(style))/gmi
        tex:
            latex:
                regex:
                    latex_chapter: /^\\chapter\*?\{([^\}]+)\}/gmi
                    latex_section: /^\\section\*?\{([^\}]+)\}/gmi
                    latex_subsection: /^\\subsection\*?\{([^\}]+)\}/gmi
                    latex_subsubsection: /^\\subsubsection\*?\{([^\}]+)\}/gmi

    source:
        sass:
            regex:
                commentaire: /^[^\S\n]*\/\/ ! (.+)/gmi
                commentaire_multi: /^[^\S\n]*\/\* ! (.+)\*\//gmi
                scss_mixin: /^[^\S\n]*(?:\=([^\(]+)\()/gmi
                function: /^[^\S\n]*(?:@function\s+([^\(]+)\s*\()/gmi
        css:
            regex:
                commentaire: /^[^\S\n]*\/\/ ! (.+)/gmi
                commentaire_multi: /^[^\S\n]*\/\* ! (.+)\*\//gmi
                class: /^"([#|\.]*.+)"/gmi
            scss:
                regex:
                    scss_mixin: /^[^\S\n]*(?:@mixin\s+([^\(]+)\s*\()/gmi
                    function: /^[^\S\n]*(?:@function\s+([^\(]+)\s*\()/gmi
                    scss_tag_rule: /^([^\S\n]*[0-9a-zA-z-_]+)\s*{/gmi
                    scss_class_rule: /^([^\S\n]*\.[0-9a-zA-z-_]+)\s*{/gmi
                    scss_id_rule: /^([^\S\n]*#[0-9a-zA-z-_]+)\s*{/gmi
        js:
            regex:
                commentaire: /^[^\S\n]*\/\/ ! (.+)/gmi
                commentaire_multi: /^[^\S\n]*\/\* ! (.+)[^\/]*\*\//gmi
                class: /^[^\S\n]*class ([\w]+(?: extends [\w]+)*)/gmi
                class_expression: /[^\S\n]*([\w]+)\s*=\s*class(?: extends [\w]+)*\s*{/gmi
                class_named_expression: /[^\S\n]*[\w]+\s*=\s*class ([\w]+)(?: extends [\w]+)*\s*{/gmi
                function: /^[^\S\n]*(?:final|static|abstract|public|async|export|[^\S\n])*function\s?([\w]+ *\([^\)]*\))/gmi
                private_function: /^[^\S\n]*private[^\S\n]+function\s?([\w]+\s?\([^\)]*\))/gmi
                protected_function: /^[^\S\n]*protected[^\S\n]+function\s?([\w]+\s?\([^\)]*\))/gmi
                controller: /^[^\S\n]*\.controller\s*\(\s*["']+([\w]+)["']+[\s,]*function/gmi
                method: /^[^\S\n]*(?:.*)(\b\w+\b)\s*(?:=|:)\s*function/gmi
                es6_method: /^[^\S\n]*(?:[*][\s\n]+)?(?:(?:@\w+)[\s\n]+)*(?!foreach|if|for|while|catch)([\w]+\s?\((?:(?!function|=>|;).|\r\n|\n)*?\))\s{/gmi
                es6_async_method: /^[^\S\n]*(?:[*][\s\n]+)?(?:(?:@\w+)[\s\n]+)*(?:async[\s\n]+)(?!foreach|if|for|while|catch)([\w]+\s?\((?:.|\s)*?\))[\s\n]*{/gmi
                es6_static_method: /^[^\S\n]*(?:[*][\s\n]+)?(?:(?:@\w+)[\s\n]+)*(?:static[\s\n]+)(?!foreach|if|for|while|catch)([\w]+\s?\((?:.|\s)*?\))[\s\n]*{/gmi
                es6_field_method: /^[^\S\n]*([\w]+[^\S\n]=[^\S\n]\([^\)]*\))[^\S\n]=>[^\S\n]*{/gmi
                constant: /^[^\S\n]*\.constant\(["']+([\w]+)["']+/gmi
                filter: /^[^\S\n]*\.filter\(["']+([\w]+)["']+/gmi
                structure: /^[^\S\n]*\.(config|run)\(function/gmi
                setter: /^[ ]*set[ ]+([^ (]+\(.*\))/gmi
                getter: /^[ ]*get[ ]+([^ (]+\(.*\))/gmi
                todo: /(?:\/\*|\/\/)[ ]*todo\:?[ ]*(.+?)[ ]*(?:\*\/|\r\n|\n)/gmi
                fixme: /(?:\/\*|\/\/)[ ]*fixme\:?[ ]*(.+?)[ ]*(?:\*\/|\r\n|\n)/gmi
                hack: /(?:\/\*|\/\/)[ ]*hack\:?[ ]*(.+?)[ ]*(?:\*\/|\r\n|\n)/gmi
                mocha_describe: /describe\(['`"]([^'`"]+)['`"]\s?,\s?function\([^\)]*\)\s?{/gmi
                mocha_it: /it\(\s*?['"`]([^'"`]*)['"`],\s*?.{0,50}?{/gmi
        ts:
            regex:
                commentaire: /^[^\S\n]*\/\/ ! (.+)/gmi
                commentaire_multi: /^[^\S\n]*\/\* ! (.+)[^\/]*\*\//gmi
                class: /^[^\S\n]*class ([\w]+(?: extends [\w]+)*)/gmi
                class_expression: /^[^\S\n]*([\w]+)\s*=\s*class\s{/gmi
                function: /^[^\S\n]*(?:final|static|abstract|public|async|export|[^\S\n])*function\s?([\w]+ *\([^\)]*\))/gmi
                private_function: /^[^\S\n]*private[^\S\n]+function\s?([\w]+\s?\([^\)]*\))/gmi
                protected_function: /^[^\S\n]*protected[^\S\n]+function\s?([\w]+\s?\([^\)]*\))/gmi
                controller: /^[^\S\n]*\.controller\s*\(\s*["']+([\w]+)["']+[\s,]*function/gmi
                method: /^[^\S\n]*(?:.*)(\b\w+\b)\s*(?:=|:)\s*function/gmi
                es6_method: /^[^\S\n]*(?:[*][\s\n]+)?(?:(?:@\w+)[\s\n]+)*(?!foreach|if|for|while|catch)([\w]+\s?\((?:(?!function|=>|;).|\r\n|\n)*?\))\s{/gmi
                es6_async_method: /^[^\S\n]*(?:[*][\s\n]+)?(?:(?:@\w+)[\s\n]+)*(?:async[\s\n]+)(?!foreach|if|for|while|catch)([\w]+\s?\((?:.|\s)*?\))[\s\n]*{/gmi
                es6_static_method: /^[^\S\n]*(?:[*][\s\n]+)?(?:(?:@\w+)[\s\n]+)*(?:static[\s\n]+)(?!foreach|if|for|while|catch)([\w]+\s?\((?:.|\s)*?\))[\s\n]*{/gmi
                es6_field_method: /^[^\S\n]*([\w]+[^\S\n]=[^\S\n]\([^\)]*\))[^\S\n]=>[^\S\n]*{/gmi
                constant: /^[^\S\n]*\.constant\(["']+([\w]+)["']+/gmi
                filter: /^[^\S\n]*\.filter\(["']+([\w]+)["']+/gmi
                structure: /^[^\S\n]*\.(config|run)\(function/gmi
                setter: /^[ ]*set[ ]+([^ (]+\(.*\))/gmi
                getter: /^[ ]*get[ ]+([^ (]+\(.*\))/gmi
                todo: /(?:\/\*|\/\/)[ ]*todo\:?[ ]*(.+?)[ ]*(?:\*\/|\r\n|\n)/gmi
                fixme: /(?:\/\*|\/\/)[ ]*fixme\:?[ ]*(.+?)[ ]*(?:\*\/|\r\n|\n)/gmi
                hack: /(?:\/\*|\/\/)[ ]*hack\:?[ ]*(.+?)[ ]*(?:\*\/|\r\n|\n)/gmi
                mocha_describe: /describe\(['`"]([^'`"]+)['`"]\s?,\s?function\([^\)]*\)\s?{/gmi
                mocha_it: /it\(\s*?['"`]([^'"`]*)['"`],\s*?.{0,50}?{/gmi
        coffee:
            regex:
                function: /^[^\S\n]*([\w]+:)\s*(?:\([^\)]*\))?\s*->/gmi
                class: /^[\S\n]*class ([\w]+)/gmi
                todo: /#[ ]*todo\:[ ]*(.+?)[ ]*(?:\r\n|\n)/gmi
                fixme: /#[ ]*fixme\:[ ]*(.+?)[ ]*(?:\r\n|\n)/gmi
                hack: /#[ ]*hack\:[ ]*(.+?)[ ]*(?:\r\n|\n)/gmi
        cs:
            regex:
                class: /^[\S\n]*(?:final|static|abstract|private|protected|public|[^\S\n])*\s?class\s([\w]+(\s?:\s?[\w]*)?)/gmi
                function: /^[^\S\n]*(?:final|static|abstract|public)*\s?(?:\w+\s)+(\w+\s*\([^\)]*\))[\s\n]*{/gmi
                private_function: /^[^\S\n]*private\s?(?:\w+\s)+(\w+\s*\([^\)]*\))[\s\n]*{/gmi
                protected_function: /^[^\S\n]*protected\s?(?:\w+\s)+(\w+\s*\([^\)]*\))[\s\n]*{/gmi
        ini:
            regex:
                structure: /^\[([^\]]+)]/gmi
        python:
            regex:
                commentaire: /^[^\S\n]*# ! (.+)/gmi
                class: /^[^\S\n]*class[\W]+(.+?)(:| *\([\w\s.,]*\):)/gmi
                function: /^[^\S\n]*def +(.+? *\((?!\s*self\s*(?=(,|\))))(.|\s)*?\)):/gmi
                method: /^[^\S\n]*def +(.+? *\((?=\s*self\s*(?=(,|\))))(.|\s)*?\)):/gmi
                todo: /#[ ]*todo\:[ ]*(.+?)[ ]*(?:\r\n|\n)/gmi
                fixme: /#[ ]*fixme\:[ ]*(.+?)[ ]*(?:\r\n|\n)/gmi
                hack: /#[ ]*hack\:[ ]*(.+?)[ ]*(?:\r\n|\n)/gmi
        ruby:
            regex:
                attr: /^[ ]*(?:attr_reader|attr_writer|attr_accessor)[ ]+([^ \n\r]+)/gmi
                class: /^[ ]*class[ ]+(?:([^\s<]+)\s?<|(?:[^\s]+::)([^\r\n]+)|([^\s<]+))/gmi
                module: /^[ ]*module[ ]+(?:([^\s<]+)\s?<|(?:[^\s]+::)([^\r\n]+)|([^\s<]+))/gmi
                classmethod: /^[ ]*def[ ]+(?:self\.)([^ \n\r]+)/gmi
                instancemethod: /^[ ]*def[ ]+(?!self\.)([^ \n\r]+)/gmi
                todo: /#[ ]*todo\:[ ]*(.+?)[ ]*(?:\r\n|\n)/gmi
                fixme: /#[ ]*fixme\:[ ]*(.+?)[ ]*(?:\r\n|\n)/gmi
                hack: /#[ ]*hack\:[ ]*(.+?)[ ]*(?:\r\n|\n)/gmi
        gfm:
            regex:
                structure: /^#+[^\S\n]+(.+)/gmi
        yaml:
            regex:
                commentaire: /^[^\S\n]*# ! (.+)/gmi
                tree_level_one: /^([^:\s\/#]+):/gm
                tree_level_two: /^[^\S\n]{2}([^:\s\/#]+):/gm
                # tree_level_three: /^[^\S\n]{4}([^:\s\/#]+):/gm            # Its a bit too much.
                tree_path: /^[^\S\n]{2,4}(\/[^:\s]*):/gm
        perl:
            regex:
                package: /^[ ]*package[ ]+([^\d][^ ]+)[ ]*(?:\{|;)/gmi
                use: /^[ ]*use[ ]+([^\d].+?);/gmi
                our: /^[ ]*our[ ]+([^ \d]{2}[^\s\;\=]+)(?:[ ]*|=|;)/gmi
                subroutine: /^[ ]*sub[ ]+([^\d][^ (]+)(?:[ ]+\:[^ (]+)?(?:\(.*\))?[ ]*\{/gmi
                todo: /#[ ]*todo\:[ ]*(.+?)[ ]*(?:\r\n|\n)/gmi
                fixme: /#[ ]*fixme\:[ ]*(.+?)[ ]*(?:\r\n|\n)/gmi
                hack: /#[ ]*hack\:[ ]*(.+?)[ ]*(?:\r\n|\n)/gmi
        odin:
            regex:
                class:    /^[ ]*(.+)\s*:\s*:\s*struct\s*(?:[\{])/gmi             # struct
                anchor:   /^[ ]*(.+)\s*:\s*:\s*enum\s*(?:[\{])/gmi               # enum
                function: /^[ ]*(.+)\s*:\s*:\s*proc\s*(?:[\{\(])/gmi             # proc
                methode_statique: /^[ ]*(.+)\s*:\s*:\s*(?:[\"\'0-9])/gmi         # const
        sql:
            regex:
                commentaire: /^[^\S\n]*--[^\S\n]*(.+)/gmi
