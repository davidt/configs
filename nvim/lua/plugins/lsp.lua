-- LSP integrations
local lspconfig = {
  'neovim/nvim-lspconfig',
  main = 'lspconfig',
  config = function()
    local lspconfig = require('lspconfig')
    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    local capabilities = vim.tbl_deep_extend(
      'force',
      lspconfig.util.default_config.capabilities,
      cmp_nvim_lsp.default_capabilities())

    local on_attach = function()
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.buf.inlay_hint(bufnr, true)
      end
    end

    lspconfig.biome.setup({
      capabilities=capabilities,
      on_attach=on_attach,
    })
    lspconfig.cssls.setup({
      capabilities=capabilities,
      on_attach=on_attach,
    })
    lspconfig.eslint.setup({
      capabilities=capabilities,
      on_attach=on_attach,
    })
    lspconfig.html.setup({
      capabilities=capabilities,
      on_attach=on_attach,
    })
    lspconfig.pylsp.setup({
      capabilities=capabilities,
      on_attach=on_attach,
      settings = {
        pylsp = {
          plugins = {
            pycodestyle = {
              enabled = false
            },
            flake8 = {
              enabled = true
            },
            ruff =  {
              enabled = true,
              extendSelect = {
                'ANN',
                'COM',
                'C4',
                'D',
                'DJ',
                'E4',
                'E7',
                'E9',
                'F',
                'FLY',
                'G',
                'FA',
                'LOG',
                'PIE',
                'UP',
              },
              extendIgnore = {
                'ANN002',
                'ANN003',
                'ANN101',
                'ANN102',
                'COM819',
                'D200',
                'D205',
                'D400',
                'D405',
                'D406',
                'D407',
                'D413',
                'D415',
                'DJ007', -- Do not use __all__ for ModelForm.Meta.fields
                'UP007', -- Use X|Y for type annotations - soon?
                'UP012', -- Unnecessary "utf-8" argument for encode
              },
              severities = {
                ['ANN'] = 'I',
                ['D'] = 'I',
                ['FLY'] = 'I',
                ['UP'] = 'I',
              },
            },
          }
        }
      }
    })

    -- pyright reports a bunch of things as "hints" in order to let the editor do
    -- things like grey out unused attributes to methods. Unfortunately the pyright
    -- client here takes those hints and actually displays them, which is super
    -- annoying. This blob turns that off while keeping actual warnings and errors.
    --[[
    local pyright_caps = vim.tbl_deep_extend(
      'force',
      capabilities,
      {
        textDocument = {
          publishDiagnostics = {
            tagSupport = {
              valueSet = { 2 }
            }
          }
        }
      })
    lspconfig.pyright.setup {
      capabilities=pyright_caps,
    }
    ]]--
    lspconfig.basedpyright.setup {
      capabilities=capabilities,
      on_attach=on_attach,
    }

    lspconfig.tsserver.setup({
      capabilities=capabilities,
      on_attach=on_attach,
      init_options = {
        preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
          importModuleSpecifierPreference = 'non-relative'
        },
      },
    })
    lspconfig.typos_lsp.setup({
      cmd = { '/Users/david/.config/nvim/lsp/bin/typos-lsp' },
      capabilities=capabilities,
      on_attach=on_attach,
    })

    vim.diagnostic.config({
      virtual_text = false
    })

    -- Show line diagnostics automatically in hover window
    vim.o.updatetime = 250
    vim.api.nvim_create_autocmd('CursorHold', {
      buffer = bufnr,
      callback = function()
        local opts = {
          focusable = false,
          close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
          border = 'rounded',
          source = 'always',
          prefix = ' ',
          scope = 'cursor',
        }

        vim.diagnostic.open_float(nil, opts)
      end
    })

    -- This is from the lspconfig "recommended setup" but I don't know what it all
    -- does yet.
    --[[
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
          vim.lsp.buf.format { async = true }
        end, opts)
      end,
    })
    ]]--

    -- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
    vim.keymap.set(
      'n', '<leader>aj',
      function()
        vim.diagnostic.goto_next({ float = false })
      end
    )
    vim.keymap.set(
      'n', '<leader>ak',
      function()
        vim.diagnostic.goto_prev({ float = false })
      end
    )

    vim.api.nvim_set_keymap('n', '<leader>v', '<cmd>:vsplit | lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
  end
}

local lspupdate = {
  'alexaandru/nvim-lspupdate',
}

local lightbulb = {
  'kosayoda/nvim-lightbulb',
  config = function()
    require("nvim-lightbulb").setup({
      autocmd = { enabled = true },
    })
  end
}

local actions_preview = {
  'aznhe21/actions-preview.nvim',
  config = function()
    vim.keymap.set({ 'v', 'n' }, '<leader>ca', require('actions-preview').code_actions)

    require('actions-preview').setup({
      telescope = {
        sorting_strategy = 'ascending',
        layout_strategy = 'vertical',
        layout_config = {
          width = 0.8,
          height = 0.9,
          prompt_position = "top",
          preview_cutoff = 20,
          preview_height = function(_, _, max_lines)
            return max_lines - 15
          end,
        },
      }
    })
  end
}

local lsplines = {
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  config = function()
    local lsp_lines = require('lsp_lines')

    --[[
    lsp_lines.setup()
    vim.diagnostic.config({
      virtual_text = false,
      virtual_lines = { only_current_line = true },
    })
    ]]--

    vim.keymap.set('', "<leader>l", lsp_lines.toggle, { desc = "Toggle lsp_lines" })
  end
}

local inlayhints = {
  'lvimuser/lsp-inlayhints.nvim',
  config = function()
    require('lsp-inlayhints').setup()
  end
}

return {
  lspconfig,
  lspupdate,
  -- lightbulb,
  actions_preview,
  -- lsplines,
}
