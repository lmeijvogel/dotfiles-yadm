local map = vim.api.nvim_set_keymap

-- Sneak
map('n', '<leader>f', '<Plug>Sneak_s', {})
map('n', '<leader>F', '<Plug>Sneak_S', {})

map('n', 'f', '<Plug>Sneak_f', {})
map('n', 'F', '<Plug>Sneak_F', {})

-- Color schemes
require('ayu').setup(
{
    mirage = false, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
    overrides = {
      Comment = {
        fg = "#0ecf00"
      },
      Normal = {
        fg = "#000000",
        bg = "#ffffff"
      },
      NormalNC = {
        fg = "#444444",
        bg = "#f4f4f4"
      },
      CocMenuSel = {
        fg = "#fafafa",
        bg = "#13354a"
      },
      LineNr = {
        fg = "#a2a2a2"
      },
      -- Highlight position of error black on red
      CocErrorHighlight = {
        fg = "#000000",
        bg = "#ff0000"
      },
      TabLineFill = {
        fg = "#303137",
        bg = "#c0c0c0"
      },
      StatusLine = {
        fg = "#494b53",
        bg = "#c0c0c0"
      },
      StatusLineNC = {
        fg = "#494b53",
        bg = "#c0c0c0"
      },
      CocFloating = {
        bg = "#e0e0e0"
      },
      CursorLine = {
        bg = "#dfe0e1"
      }

    }, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
})

function LMBackgroundLight()
  vim.o.background = 'light'

  vim.cmd.colorscheme('ayu')
end

function LMBackgroundDark()
  vim.cmd.colorscheme('one')

  vim.o.background = 'dark'
end

if not vim.g['config_already_loaded'] then
  vim.g['config_already_loaded'] = true

  LMBackgroundLight()
end

-- map('n', '<F6>', ':lua LMBackgroundDark()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<F6>', ':lua LMBackgroundDark()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<F7>', ':lua LMBackgroundLight()<CR>', { noremap = true, silent = true })

require('mason').setup()

require('mason-lspconfig').setup {
  ensure_installed = { 'tsserver', 'eslint', 'lua_ls', 'cssls' }
}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'gm', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rr', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>la', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('v', '<space>la', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<space>lf', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local eslint_on_attach = function(client, bufnr)
    on_attach(client, bufnr)

    vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
    })
end

require'lspconfig'.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  on_attach = on_attach
}
require('lspconfig')['tsserver'].setup({ on_attach = on_attach })
require('lspconfig')['cssls'].setup({ on_attach = on_attach })
require('lspconfig')['eslint'].setup({ on_attach = eslint_on_attach })

-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = cmp.mapping(function(fallback)
      -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
      if cmp.visible() then
        local entry = cmp.get_selected_entry()
        if not entry then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          cmp.confirm()
        end
      else
        fallback()
      end
    end, {"i","s","c",}),

  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
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

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

cmp.setup({
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
      if cmp.visible() then
        local entry = cmp.get_selected_entry()

        if entry then
          cmp.confirm()
        else
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        end
      else
        fallback()
      end
    end, {"i","s","c",}),
  }
})
vim.api.nvim_set_keymap('i', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {})

require('mini.align').setup()
require('lualine').setup({})
require'treesitter-context'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
}

