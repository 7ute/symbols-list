module.exports =
    text:
        html:
            regex:
                commentaire_html: /^[^\S\n]*<!-- !(.+)-->/gmi
                structure: /^[^\S\n]*<(head|body|section)/gmi
                entete: /^[^\S\n]*<h[1-9][^>]*>([^<]*)<\/h[1-9]>/gmi
            php:
                regex:
                    commentaire: /^[^\S\n]*\/\/ !(.+)/gmi
                    commentaire_multi: /^[^\S\n]*\/\* !(.+)\*\//gmi
                    class: /^[^\S\n]*class ([\w]+)/gmi
                    function: /^[^\S\n]*(?:final|static|abstract|private|public)*\s*function ([\w]+\(.*\))/gmi

    source:
        css:
            regex:
                commentaire_multi: /^[^\S\n]*\/\* !(.+)\*\//gmi
        js:
            regex:
                commentaire: /^\h*\/\/ !(.+)/gmi
                commentaire_multi: /^[^\S\n]*\/\* !(.+)\*\//gmi
                class: /^[^\S\n]*class ([\w]+)/gmi
                function: /^[^\S\n]*(?:final|static|abstract|private|public)*\s*function ([\w]+\(.*\))/gmi
                controller: /^[^\S\n]*\.controller\s*\(\s*["']+([\w]+)["']+[\s,]*function/gmi
                method: /^[^\S\n]*[^\s]*\.([\w]*)\s*=\s*function/gmi
                constant: /^[^\S\n]*\.constant\(["']+([\w]+)["']+/gmi
                filter: /^[^\S\n]*\.filter\(["']+([\w]+)["']+/gmi
                structure: /^[^\S\n]*\.(config|run)\(function/gmi
        coffee:
            regex:
                function: /^[^\S\n]*([\w]+:)\s*\([^\)]*\)\s*->/gmi
                class: /^[\S\n]*class ([\w]+)/gmi
