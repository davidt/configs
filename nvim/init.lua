vim.cmd([[
set nojoinspaces
set number
set ruler
set showtabline=2
set signcolumn=yes
set smartindent
set smarttab
set textwidth=79
set title
set whichwrap=bs<>hl[]

" Mark trailing whitespace as an error.
autocmd BufNewFile,BufReadPost,WinEnter * highlight WhitespaceEOL guibg=#874864
autocmd BufNewFile,BufReadPost,WinEnter * match WhitespaceEOL /\s\+$/
]])

-- Basic tab keymappings
vim.api.nvim_set_keymap('n', '<C-N>', '<cmd>:tabnext<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-P>', '<cmd>:tabprev<CR>', { noremap = true, silent = true})

-- Set up cute icons for labeling diagnostic results in the gutter.
local signs = {
    Error = "",
    Warn = "",
    Hint = "",
    Info = "",
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end


require('lazy').setup('plugins')
