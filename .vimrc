set nocompatible

filetype off

source $HOME/.vimrc.d/global.vim
nnoremap <silent> <leader>e1v :e $HOME/.vimrc.d/global.vim<CR>
source $HOME/.vimrc.d/commands.vim
nnoremap <silent> <leader>e2v :e $HOME/.vimrc.d/commands.vim<CR>
source $HOME/.vimrc.d/plugins.vim
nnoremap <silent> <leader>e3v :e $HOME/.vimrc.d/plugins.vim<CR>
source $HOME/.vimrc.d/plugin_commands.vim
nnoremap <silent> <leader>e4v :e $HOME/.vimrc.d/plugin_commands.vim<CR>

nnoremap <silent> <leader>e5v :CocConfig<CR>

source $HOME/.vimrc.d/absolute_import_to_relative.vim
