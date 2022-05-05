source $HOME/.vimrc
nnoremap <silent> <leader>e1v :e $HOME/.vimrc<CR>
source $HOME/.config/nvim/commands.vim
nnoremap <silent> <leader>e2v :e $HOME/.config/nvim/commands.vim<CR>
source $HOME/.config/nvim/plugins.vim
nnoremap <silent> <leader>e3v :e $HOME/.config/nvim/plugins.vim<CR>
source $HOME/.config/nvim/plugin_commands.vim
nnoremap <silent> <leader>e4v :e $HOME/.config/nvim/plugin_commands.vim<CR>

nnoremap <silent> <leader>e5v :CocConfig<CR>

" For neovide and neovim-qt
set guifont=Cascadia\ Code:h12

source $HOME/.config/nvim/absolute_import_to_relative.vim
