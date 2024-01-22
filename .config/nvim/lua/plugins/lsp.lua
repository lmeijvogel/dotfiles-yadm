local map = vim.api.nvim_set_keymap

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Format on save
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format { async = false }
    end
  })


  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local telescope = require('telescope.builtin')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', telescope.lsp_definitions, bufopts)
  vim.keymap.set('n', 'gr', telescope.lsp_references, bufopts)
  vim.keymap.set('n', 'gm', telescope.lsp_implementations, bufopts)
  vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rr', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('v', '<leader>la', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end, bufopts)
  vim.keymap.set('n', '<leader>lr', '<cmd>LspRestart<CR>', bufopts)

  vim.keymap.set('n', '<leader>.', vim.lsp.buf.signature_help, bufopts)

  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, bufopts)
  vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set('n', ']g', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, bufopts)
end

local eslint_on_attach = function(client, bufnr)
  on_attach(client, bufnr)
  client.server_capabilities.documentFormattingProvider = true
end

vim.api.nvim_set_keymap('i', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {})

return {
  {
    {
      "neovim/nvim-lspconfig",
      config = function()
        require('lspconfig')['vtsls'].setup({ on_attach = on_attach })
        require('lspconfig')['cssls'].setup({ on_attach = on_attach })
        require('lspconfig')['eslint'].setup({ on_attach = eslint_on_attach })
        require('lspconfig')['lua_ls'].setup({
          on_attach = eslint_on_attach,
          settings = {
            Lua = {
              diagnostics = { globals = { 'vim' } }
            }
          }
        })
      end,
      dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/nvim-cmp",
      },
    },
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        ensure_installed = { 'tsserver', 'eslint', 'cssls', 'lua_ls' }
      },
      dependencies = {
        "williamboman/mason.nvim",
      },
    },
    {
      "williamboman/mason.nvim",
      opts = {
        disable_commands = false, -- prevent the plugin from creating Vim commands
        debug = false,            -- enable debug logging for commands
        go_to_source_definition = {
          fallback = true,        -- fall back to standard LSP definition on failure
        },
        server = {                -- pass options to lspconfig's setup method
          on_attach = on_attach,
        },
      },
      dependencies = {
        "jose-elias-alvarez/typescript.nvim", -- More complete typescript LSP functionality
      },
    },
    {
      "hrsh7th/nvim-cmp",
      config = function()
        -- Set up nvim-cmp.
        local cmp = require 'cmp'

        cmp.setup({
          snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
              require('snippy').expand_snippet(args.body)
            end,
          },
          window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },
          -- behaviors: `SelectBehavior`: Highlights the entry, but don't put it in the buffer yet
          --            `InsertBehavior`: Highlight the entry and put it in the buffer.
          mapping = cmp.mapping.preset.insert({
            ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.SelectBehavior }),
            ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.SelectBehavior }),
            -- By default, <Up> and <Down> have { behavior = types.cmp.SelectBehavior.SelectBehavior },
            -- which highlights the items but does not put the text in the buffer.
            -- I don't know how to select the highlighted items in that case, so here without the `SelectBehavior`
            -- ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.InsertBehavior }),
            -- ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.InsertBehavior }),
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<PageUp>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.SelectBehavior, count = 12 }),
            ['<PageDown>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.SelectBehavior, count = 12 }),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
              elseif has_words_before() then
                cmp.complete()
              else
                fallback()
              end
            end, { 'i', 's' }),
          }),
          sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'buffer' },
            { name = 'nvim_lsp_signature_help' }
          })
        })

        -- Set configuration for specific filetype.
        cmp.setup.filetype('gitcommit', {
          sources = cmp.config.sources({
            { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
          }, {
            { name = 'buffer' },
          })
        })
      end,
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        -- "hrsh7th/cmp-cmdline",-- I can't find a way to get completion in the cmdline without having to confirm with <CR>
        "hrsh7th/cmp-nvim-lsp-signature-help",
        {
          "dcampos/cmp-snippy",
          dependencies = {
            "dcampos/nvim-snippy", -- Snippet engine to hopefully make cmp not crash
          }
        }
      },
    },
  }
};
