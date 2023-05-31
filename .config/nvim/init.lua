local map = vim.api.nvim_set_keymap

vim.g.mapleader = ' '

-- Quickly edit/reload the vimrc file
map('n', '<leader>ev', ':e $MYVIMRC<CR>', {})
map('n', '<leader>lv', ':so $MYVIMRC<CR>', {})

-- Easily open most config files
vim.cmd([[source $HOME/.vimrc]])
map('n', '<leader>e1', ':e $HOME/.vimrc<CR>', {})

require("commands")
map('n', '<leader>e2', ':e $HOME/.config/nvim/lua/commands.lua<CR>', {})

require("plugins")
map('n', '<leader>e3', ':e $HOME/.config/nvim/lua/plugins.lua<CR>', {})

require("plugin_commands")
map('n', '<leader>e4', ':e $HOME/.config/nvim/lua/plugin_commands.lua<CR>', {})

map('n', '<leader>e5', ':e $HOME/.config/nvim/lua/plugins/init.lua<CR>', {})

map('n', '<leader>ee',
  ':lua require("telescope.builtin").find_files({ cwd = "/home/lennaert/.config/nvim/lua" })<CR>',
  { desc = "Fuzzy find config file" })


-- For neovide and neovim-qt
vim.opt.guifont = "Cascadia Code:h12"

if vim.g.neovide then
  vim.g.neovide_scroll_animation_length = 0.1
  vim.g.neovide_cursor_animation_length = 0.02
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
end
