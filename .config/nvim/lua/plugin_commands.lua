require('colors')
require('language_server')

local map = vim.api.nvim_set_keymap

map('n', 'f', '<Plug>Sneak_f', {})
map('n', 'F', '<Plug>Sneak_F', {})

require('mini.align').setup()
require('lualine').setup({
  -- The default sections, except mentioned below
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'filetype' }, -- Removed 'encoding' and 'fileformat' here
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
})
require('dressing').setup({})

local actions = require('telescope.actions')

-- Telescope
require('telescope').setup({
  defaults = {
    file_ignore_patterns = { "node_modules" },
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-Down>"] = actions.cycle_history_next,
        ["<C-Up>"] = actions.cycle_history_prev,
      }
    },
    layout_config = {
      vertical = { width = 0.5 }
    },
  },
  history = {
    path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
    limit = 100,
  }
})

require('telescope').load_extension('smart_history')
require('telescope').load_extension('fzf')

map('n', '<leader>a', ':Telescope live_grep<CR>', {})
map('n', '<leader>A', ':Telescope grep_string initial_mode=normal<CR>', {})
map('n', '<C-p>', '<cmd>Telescope find_files<CR>', {})
map('n', '<leader>hh', '<cmd>Telescope oldfiles<CR>', {})
map('n', '-', '<cmd>Telescope buffers sort_mru=true ignore_current_buffer=true<CR>', {})

map('n', '<leader>tp', '<cmd>Telescope project<CR>', {})
map('n', '<leader>tr', '<cmd>Telescope resume<CR>', {})

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

require 'telescope'.load_extension('project')

require('snippy').setup({})
