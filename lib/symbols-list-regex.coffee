# TO TEST REGEX
# https://regexper.com/

module.exports =
    text:
        html:
            regex:
                commentaire_html: /^[^\S\n]*<!-- ! (.+)-->/gmi
                structure: /^[^\S\n]*<(head|body|section)/gmi
                entete: /^[^\S\n]*<h[1-9][^>]*>([^<]*)<\/h[1-9]>/gmi
                anchor: /^[^\S\n]*<[^>]*id=["']+([\w]+)["'][^>]*>/gmi
            php:
                regex:
                    commentaire: /^[^\S\n]*(?:\/\/|#) ! (.+)/gmi
                    commentaire_multi: /^[^\S\n]*\/\* ! (.+)[^\/]*\*\//gmi
                    class: /^[^\S\n]*class ([\w]+)/gmi
                    methode_statique: /^(?:final|abstract|private|protected|public|[^\S\n])*static\sfunction\s?((?:&\s?)?[\w]+ *\([^\)]*\))/gmi
                    function: /^(?:final|abstract|private|protected|public|[^\S\n])*function\s?((?:&\s?)?[\w]+ *\([^\)]*\))/gmi
                    todo: /(?:\/\*|\/\/)[ ]*todo\:[ ]*(.+?)[ ]*(?:\*\/)?(?:[\r\n])/gmi
                    fixme: /(?:\/\*|\/\/)[ ]*fixme\:[ ]*(.+?)[ ]*(?:\*\/)?(?:[\r\n])/gmi
                    hack: /(?:\/\*|\/\/)[ ]*hack\:[ ]*(.+?)[ ]*(?:\*\/)?(?:[\r\n])/gmi

    source:
        css:
            regex:
                commentaire_multi: /^[^\S\n]*\/\* ! (.+)\*\//gmi
                class: /^"([#|\.]*.+)"/gmi
        js:
            regex:
                commentaire: /^[^\S\n]*\/\/ ! (.+)/gmi
                commentaire_multi: /^[^\S\n]*\/\* ! (.+)[^\/]*\*\//gmi
                class: /^[^\S\n]*class ([\w]+(?: extends [\w]+)*)/gmi
                class_expression: /^[^\S\n]*([\w]+)\s*=\s*class\s{/gmi
                function: /^[^\S\n]*(?:final|static|abstract|private|protected|public|async|export|[^\S\n])*function\s?([\w]+ *\([^\)]*\))/gmi
                controller: /^[^\S\n]*\.controller\s*\(\s*["']+([\w]+)["']+[\s,]*function/gmi
                method: /^[^\S\n]*(?:.*)(\b\w+\b)\s*(?:=|:)\s*function/gmi
                es6method: /^[^\S\n]*(?:[*][\s\n]+)?(?:async[\s\n]+)?(?!foreach|if|for|while|catch)([\w]+\(.*\))[\s\n]*{/gmi
                es6constfunction: /^[\s]*(?:export[\s]+)?const[\s]+([\w]+)[\s]+=[\s]+\(.*\)[\s]+=>/gmi
                constant: /^[^\S\n]*\.constant\(["']+([\w]+)["']+/gmi
                filter: /^[^\S\n]*\.filter\(["']+([\w]+)["']+/gmi
                structure: /^[^\S\n]*\.(config|run)\(function/gmi
                setter: /^[ ]*set[ ]+([^ (]+\(.*\))/gmi
                getter: /^[ ]*get[ ]+([^ (]+\(.*\))/gmi
                todo: /(?:\/\*|\/\/)[ ]*todo\:[ ]*(.+?)[ ]*(?:\*\/)?(?:[\r\n])/gmi
                fixme: /(?:\/\*|\/\/)[ ]*fixme\:[ ]*(.+?)[ ]*(?:\*\/)?(?:[\r\n])/gmi
                hack: /(?:\/\*|\/\/)[ ]*hack\:[ ]*(.+?)[ ]*(?:\*\/)?(?:[\r\n])/gmi
        coffee:
            regex:
                function: /^[^\S\n]*([\w]+:)\s*(?:\([^\)]*\))?\s*->/gmi
                class: /^[\S\n]*class ([\w]+)/gmi
                todo: /#[ ]*todo\:[ ]*(.+?)[ ]*(?:[\r\n])/gmi
                fixme: /#[ ]*fixme\:[ ]*(.+?)[ ]*(?:[\r\n])/gmi
                hack: /#[ ]*hack\:[ ]*(.+?)[ ]*(?:[\r\n])/gmi
        cs:
            regex:
                class: /^[\S\n]*(?:final|static|abstract|private|protected|public|[^\S\n])*\s?class\s([\w]+(\s?:\s?[\w]*)?)/gmi
                function: /^[^\S\n]*(?:final|static|abstract|private|protected|public)*\s?(?:\w+\s)+(\w+\s*\([^\)]*\))[\s\n]*{/gmi
        ini:
            regex:
                structure: /^\[([^\]]+)]/gmi
        python:
            regex:
                commentaire: /^[^\S\n]*# ! (.+)/gmi
                class: /^[^\S\n]*class[\W]+(.+?)(:| *\([\w\s.,]*\):)/gmi
                function: /^[^\S\n]*def +(.+? *\((?!\s*self\s*(?=(,|\))))(.|\s)*?\)):/gmi
                method: /^[^\S\n]*def +(.+? *\((?=\s*self\s*(?=(,|\))))(.|\s)*?\)):/gmi
                todo: /#[ ]*todo\:[ ]*(.+?)[ ]*(?:[\r\n])/gmi
                fixme: /#[ ]*fixme\:[ ]*(.+?)[ ]*(?:[\r\n])/gmi
                hack: /#[ ]*hack\:[ ]*(.+?)[ ]*(?:[\r\n])/gmi
        ruby:
            regex:
                attr: /^[ ]*(?:attr_reader|attr_writer|attr_accessor)[ ]+([^ \n\r]+)/gmi
                class: /^[ ]*class[ ]+(?:.+?::)*([^ \n\r]+)/gmi
                module: /^[ ]*module[ ]+([^ \n\r]+)/gmi
                classmethod: /^[ ]*def[ ]+(?:self\.)([^ \n\r]+)/gmi
                instancemethod: /^[ ]*def[ ]+(?!self\.)([^ \n\r]+)/gmi
                todo: /#[ ]*todo\:[ ]*(.+?)[ ]*(?:[\r\n])/gmi
                fixme: /#[ ]*fixme\:[ ]*(.+?)[ ]*(?:[\r\n])/gmi
                hack: /#[ ]*hack\:[ ]*(.+?)[ ]*(?:[\r\n])/gmi
        gfm:
            regex:
                structure: /^#+[^\S\n]+(.+)/gmi
        yaml:
            regex:
                commentaire: /^[^\S\n]*# ! (.+)/gmi
        perl:
            regex:
                package: /^[ ]*package[ ]+([^\d][^ ]+)[ ]*(?:\{|;)/gmi
                use: /^[ ]*use[ ]+([^\d].+?);/gmi
                our: /^[ ]*our[ ]+([^ \d]{2}[^\s\;\=]+)(?:[ ]*|=|;)/gmi
                subroutine: /^[ ]*sub[ ]+([^\d][^ (]+)(?:[ ]+\:[^ (]+)?(?:\(.*\))?[ ]*\{/gmi
                todo: /#[ ]*todo\:[ ]*(.+?)[ ]*(?:[\r\n])/gmi
                fixme: /#[ ]*fixme\:[ ]*(.+?)[ ]*(?:[\r\n])/gmi
                hack: /#[ ]*hack\:[ ]*(.+?)[ ]*(?:[\r\n])/gmi
        odin:
            regex:
                class:    /^[ ]*(.+)\s*:\s*:\s*struct\s*(?:[\{])/gmi             # struct
                anchor:   /^[ ]*(.+)\s*:\s*:\s*enum\s*(?:[\{])/gmi               # enum
                function: /^[ ]*(.+)\s*:\s*:\s*proc\s*(?:[\{\(])/gmi             # proc
                methode_statique: /^[ ]*(.+)\s*:\s*:\s*(?:[\"\'0-9])/gmi         # const
