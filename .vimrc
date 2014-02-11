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
set textwidth=79
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

" taglist-plus config
let g:Tlist_Ctags_Cmd = '/usr/local/bin/ctags'

" tSkeleton config
let g:tskelDontSetup = 1
let g:tskelUserName = 'David Trowbridge'
let g:tskelUserEmail = 'davidt@vmware.com'

" Syntastic configuration
let g:syntastic_check_on_open = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': ['python'],
			   \ 'passive_filetypes': [] }

" Highlight trailing whitespace
autocmd BufNewFile,BufReadPost,WinEnter * highlight WhitespaceEOL ctermbg=red guibg=red
autocmd BufNewFile,BufReadPost,WinEnter * match WhitespaceEOL /\s\+$/
