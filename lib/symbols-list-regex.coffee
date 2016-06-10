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

    source:
        css:
            regex:
                commentaire_multi: /^[^\S\n]*\/\* ! (.+)\*\//gmi
        js:
            regex:
                commentaire: /^[^\S\n]*\/\/ ! (.+)/gmi
                commentaire_multi: /^[^\S\n]*\/\* ! (.+)[^\/]*\*\//gmi
                class: /^[^\S\n]*class ([\w]+(?: extends [\w]+)*)/gmi
                class_expression: /^[^\S\n]*([\w]+)\s*=\s*class\s{/gmi
                function: /^[^\S\n]*(?:final|static|abstract|private|protected|public|[^\S\n])*function\s?([\w]+ *\([^\)]*\))/gmi
                controller: /^[^\S\n]*\.controller\s*\(\s*["']+([\w]+)["']+[\s,]*function/gmi
                method: /^[^\S\n]*(?:.*)(\b\w+\b)\s*(?:=|:)\s*function/gmi
                es6method: /^[^\S\n]*(?!foreach|if|for|while|catch)([\w]+\(.*\))[\s\n]*{/gmi
                constant: /^[^\S\n]*\.constant\(["']+([\w]+)["']+/gmi
                filter: /^[^\S\n]*\.filter\(["']+([\w]+)["']+/gmi
                structure: /^[^\S\n]*\.(config|run)\(function/gmi
        coffee:
            regex:
                function: /^[^\S\n]*([\w]+:)\s*\([^\)]*\)\s*->/gmi
                class: /^[\S\n]*class ([\w]+)/gmi
        ini:
            regex:
                structure: /^\[([^\]]+)]/gmi
        python:
            regex:
                commentaire: /^[^\S\n]*# ! (.+)/gmi
                class: /^[^\S\n]*class ([\w]+):/gmi
                function: /^[^\S\n]*def ([\w]+ *\(.*\)):/gmi
        ruby:
            regex:
                attr: /^[^\S\n]*(?:attr_reader|attr_writer|attr_accessor) ([\w:]+)/gmi
                class: /^[^\S\n]*class ([\w:]+)/gmi
                module: /^[^\S\n]*module ([\w:]+)/gmi
                method: /^[^\S\n]*def ([\w]+ *(\(.*\))?)/gmi
