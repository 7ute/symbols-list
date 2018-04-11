<?php
class Classe
{
    public static function methode_statique(){ }
    private function methode(){ }
    protected function methode(){ }
    public function methode(){ }
}

function &statique() {...}
function & autre_statique() {...}

// ! commentaire
/* ! Commentaire multiligne */


// TODO: a todo
// FIXME: a fixme
// HACK: a hack

// /!\ custom_rule


/* –––– Custom rules

    To see the custom rule, create a 'symbols-list-custom.cson'
    file in your config folder (usually '~/.atom/') and put
    the complete path inside the 'extensions file' field.

text:
    html:
        php:
            regex:
                todo: false
                fixme: false
                hack: /^[^\S\n]*(?:\/\/) \/!\\ (.+)/gmi

–––– */
