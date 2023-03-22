require('colors')
require('language_server')

local map = vim.api.nvim_set_keymap

map('n', 'f', '<Plug>Sneak_f', {})
map('n', 'F', '<Plug>Sneak_F', {})

require('mini.align').setup()
require('lualine').setup({})
require('dressing').setup({})


-- Treesitter
require("nvim-treesitter.configs").setup({
  -- this can also be a list of languages
  ensure_installed = all,
  auto_install = true,
  highlight = { enable = true },
})

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}

require('colorizer').setup()