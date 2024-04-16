-- Use treesitter for highlighting and indentation instead of regex.
local treesitter = {
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


local treesitter_context = {
  'nvim-treesitter/nvim-treesitter-context',
}


return {
  treesitter,

  -- This doesn't seem to be working quite right, at least with Python
  -- treesitter_context,
}
