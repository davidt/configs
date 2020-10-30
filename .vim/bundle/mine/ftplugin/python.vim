set shiftwidth=4
set tabstop=8
set expandtab
set sta

syntax sync minlines=500


function! InsertComment(file, backlines)
    execute "normal I#\<ESC>"
    execute "$read !cat " . a:file . " | sed 's,^,\\#,'"
    execute "normal o#\<ESC>" . a:backlines . "k"
endfunction
