-- Add test integrations
local neotest = {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-python',
  },
  config = function()
    require('neotest').setup({
      adapters = {
        require('neotest-python'),
      }
    })
  end
}
local neotest_python = {
  'nvim-neotest/neotest-python',
}

return {
  -- neotest,
  -- neotest_python,
}
