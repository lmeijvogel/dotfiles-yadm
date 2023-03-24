require('colors')
require('language_server')

local map = vim.api.nvim_set_keymap

map('n', 'f', '<Plug>Sneak_f', {})
map('n', 'F', '<Plug>Sneak_F', {})

require('mini.align').setup()
require('lualine').setup({
  -- The default sections, except mentioned below
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'filetype'}, -- Removed 'encoding' and 'fileformat' here
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
})
require('dressing').setup({})


-- Treesitter
require("nvim-treesitter.configs").setup({
  -- this can also be a list of languages
  ensure_installed = all,
  auto_install = true,
  highlight = { enable = true },
})

vim.opt.list = true

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = false, -- The start marker resembles an LSP diagnostic
}

require('colorizer').setup({})
