-- Use treesitter for highlighting and indentation instead of regex.
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    'andymass/vim-matchup',
  },
  config = function()
    local configs = require('nvim-treesitter.configs')

    configs.setup({
      ensure_installed = {
        'gitcommit',
        'html',
        'htmldjango',
        'javascript',
        'json',
        'lua',
        'python',
        'typescript',
      },
      highlight = { enable = true },
      indent = { enable = true },
      matchup = { enable = true },
    })
  end
}
