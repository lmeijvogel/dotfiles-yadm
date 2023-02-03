source $HOME/.vimrc
source $HOME/.config/nvim/commands.vim
source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/plugin_commands.vim

" For neovide and neovim-qt
set guifont=Cascadia\ Code:h12

" GUIs don't start nvim with the "regular" $PATH,
" Causing coc to fail.
let g:coc_node_path = "/home/lennaert/.volta/bin/node"

source $HOME/.config/nvim/absolute_import_to_relative.vim
