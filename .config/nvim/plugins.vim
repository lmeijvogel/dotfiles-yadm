call plug#begin('~/.vim/plugged')

" Load all plugins
Plug 'sandeepcr529/Buffet.vim' " Buffer explorer
Plug 'andymass/vim-matchup' " Enhances the '%' key to match more patterns.
Plug 'bogado/file-line' " Copy file/line to clipboard
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-repeat'
Plug 'duff/vim-scratch' " Scratch buffer
Plug 'mbbill/undotree' " Undo history visualisation
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'mileszs/ack.vim'
Plug 'vim-scripts/bufkill.vim' " Commands for deleting the current buffer
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-endwise' " Automatically close begin/end statements
Plug 'tpope/vim-unimpaired' " Bracket commands: ]b, etc.
Plug 'tpope/vim-rsi' " Readline style insertions
Plug 'tpope/vim-fugitive'
Plug 'editorconfig/editorconfig-vim'
Plug 'ntpeters/vim-better-whitespace' " Better whitespace highlighting
Plug 'jgdavey/tslime.vim'
Plug 'jgdavey/vim-turbux'
Plug 'buztard/vim-rel-jump' " Store relative jumps (5j, 3k) in the jump list
Plug 'jose-elias-alvarez/buftabline.nvim',  {'branch': 'main'} " Buffer list at top of screen
Plug 'justinmk/vim-sneak'
Plug 'kassio/neoterm'
Plug 'janko-m/vim-test'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'jelera/vim-javascript-syntax'
Plug 'MaxMEllon/vim-jsx-pretty' " Syntax highlighting jsx/tsx
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'prettier/vim-prettier'
Plug 'fmoralesc/molokayo' " Dark color scheme
Plug 'mhinz/vim-grepper'
Plug 'jceb/vim-orgmode'
Plug 'vim-scripts/utl.vim' " Universal Text Linking -- Needed for orgmode links between files
Plug 'mattn/calendar-vim'
Plug 'w0rp/ale'
Plug 'elixir-editors/vim-elixir'

Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons' " optional, for file icons

Plug 'jeetsukumaran/vim-indentwise' " Easy navigation based on indent level
Plug 'rakr/vim-one' " Light color scheme
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Language Server Protocol client
Plug 'rbgrouleff/bclose.vim' " Close buffers while keeping windows open
Plug 'leafgarland/typescript-vim' " Syntax files for typescript
Plug 'ruanyl/vim-sort-imports' " Sort typescript imports
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

Plug 'wellle/targets.vim' " New text objects, like cI,

Plug 'machakann/vim-sandwich' " alternative to surround.vim

Plug 'Shatur/neovim-ayu' " Color scheme

Plug 'kdheepak/lazygit.nvim'
Plug 'azabiong/vim-highlighter'

Plug 'ggandor/leap.nvim'
"
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
" Context.vim => Show context at top of window
" Plug 'nvim-treesitter/nvim-treesitter'
" Plug 'nvim-treesitter/nvim-treesitter-context'
" Plug 'wellle/context.vim'
call plug#end()

call yankstack#setup()

filetype off
filetype plugin indent on
