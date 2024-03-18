local lsp_progress = {
  'linrongbin16/lsp-progress.nvim',
  config = function()
    require('lsp-progress').setup()
  end
}

local lualine = {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local min_width = function(width)
      return function()
        return vim.fn.winwidth(0) > width
      end
    end

    require('lualine').setup({
      sections = {
        lualine_a = {
          { 'mode', cond = min_width(100) },
        },
        lualine_b = {
          { 'branch', cond = min_width(80) },
          { 'diff', cond = min_width(120) },
          { 'diagnostics', cond = min_width(80) },
        },
        lualine_c = {
          { 'filename', path = 1, },
        },
        lualine_x = {
          { require('lsp-progress').progress, cond = min_width(120) },
        },
        lualine_y = {},
        lualine_z = { 'location' },
      }
    })
  end
}

return {
  lsp_progress,
  lualine,
}
