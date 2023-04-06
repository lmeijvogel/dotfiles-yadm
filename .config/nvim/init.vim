source $HOME/.vimrc
nnoremap <silent> <leader>e1 :e $HOME/.vimrc<CR>
source $HOME/.config/nvim/commands.vim
nnoremap <silent> <leader>e2 :e $HOME/.config/nvim/commands.vim<CR>
source $HOME/.config/nvim/plugins.vim
nnoremap <silent> <leader>e3 :e $HOME/.config/nvim/plugins.vim<CR>
source $HOME/.config/nvim/plugin_commands.vim
nnoremap <silent> <leader>e4 :e $HOME/.config/nvim/plugin_commands.vim<CR>
source $HOME/.config/nvim/lua/plugin_commands.lua
nnoremap <silent> <leader>e5 :e $HOME/.config/nvim/lua/plugin_commands.lua<CR>

" For neovide and neovim-qt
set guifont=Cascadia\ Code:h12

lua << NEOVIDE
if vim.g.neovide then
  vim.g.neovide_scroll_animation_length = 0.1
  vim.g.neovide_cursor_animation_length = 0.02
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
end
NEOVIDE
