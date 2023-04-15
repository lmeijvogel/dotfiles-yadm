local map = vim.api.nvim_set_keymap

require('mason').setup()

require('mason-lspconfig').setup {
    ensure_installed = { 'tsserver', 'eslint', 'cssls', 'lua-language-server' }
}

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local hello = function()
    local pos = vim.api.nvim_win_get_cursor(0)[2]
    local line = vim.api.nvim_get_current_line()
    local nline = line:sub(0, pos) .. 'hello' .. line:sub(pos + 1)
    vim.api.nvim_set_current_line(nline)
end

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format { async = false }
        end
    })


    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>')
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>')
    vim.keymap.set('n', 'gm', '<cmd>Telescope lsp_implementations<CR>')
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rr', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>la', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('v', '<space>la', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<space>lf', function() vim.lsp.buf.format { async = true } end, bufopts)

    vim.keymap.set('n', '<leader>.', vim.lsp.buf.signature_help, bufopts)
end

local eslint_on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true
end

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

local tsserver_on_attach = function(client, bufnr)
    on_attach(client, bufnr)

    map('n', '<leader>li', ":TypescriptAddMissingImports<CR>", {})
end

-- use typescript.nvim to initialize tsserver to add extra options.
require("typescript").setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false,          -- enable debug logging for commands
    go_to_source_definition = {
        fallback = true,    -- fall back to standard LSP definition on failure
    },
    server = {              -- pass options to lspconfig's setup method
        on_attach = tsserver_on_attach,
    },
})

-- Set up nvim-cmp.
local cmp = require 'cmp'

cmp.setup({
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
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() and cmp.get_selected_entry() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = false })
                else
                    fallback()
                end
            end,
            s = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
            c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        }),
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

vim.api.nvim_set_keymap('i', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {})
