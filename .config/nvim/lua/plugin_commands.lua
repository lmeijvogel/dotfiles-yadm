require('colors')
require('language_server')

local map = vim.api.nvim_set_keymap

map('n', 'f', '<Plug>Sneak_f', {})
map('n', 'F', '<Plug>Sneak_F', {})

require('mini.align').setup()
require('lualine').setup({})
require('dressing').setup({})
