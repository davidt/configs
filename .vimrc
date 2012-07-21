set nocompatible

call pathogen#infect()
call pathogen#helptags()

" Interface tweaks
set backspace=indent,eol,start
set whichwrap=bs<>hl[]
set incsearch
set hlsearch
set ruler
set title
set mouse=a
set wildmenu
set smarttab
runtime macros/matchit.vim
syntax on
filetype plugin indent on

" Basic formatting
set shiftwidth=8
set smartindent
set textwidth=80
set nojoinspaces

" Hotkeys and settings for tabs
set showtabline=2
map <C-N> <ESC>:tabnext <CR>
map <C-P> <ESC>:tabprev <CR>

" Hotkeys for taglist & alternate
nnoremap <silent> <F2> :TlistToggle <CR>
nnoremap <silent> <F3> :AV <CR>

" NERD commenter config
let g:NERDShutUp = 1

" tSkeleton config
let g:tskelDontSetup = 1
let g:tskelUserName = 'David Trowbridge'
let g:tskelUserEmail = 'davidt@vmware.com'

" Highlight trailing whitespace
autocmd BufNewFile,BufReadPost,WinEnter * highlight WhitespaceEOL ctermbg=red guibg=red
autocmd BufNewFile,BufReadPost,WinEnter * match WhitespaceEOL /\s\+$/
