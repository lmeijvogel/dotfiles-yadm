call plug#begin()

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
Plug 'tpope/vim-endwise', { 'for': 'ruby' } " Automatically close begin/end statements
Plug 'tpope/vim-unimpaired' " Bracket commands: ]b, etc.
Plug 'tpope/vim-rsi' " Readline style insertions
Plug 'tpope/vim-fugitive'
Plug 'editorconfig/editorconfig-vim'
Plug 'ntpeters/vim-better-whitespace' " Better whitespace highlighting
Plug 'jgdavey/tslime.vim'
Plug 'jgdavey/vim-turbux'
Plug 'buztard/vim-rel-jump' " Store relative jumps (5j, 3k) in the jump list
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
Plug 'elixir-editors/vim-elixir'

Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons' " optional, for file icons

Plug 'jeetsukumaran/vim-indentwise' " Easy navigation based on indent level
Plug 'rakr/vim-one' " Light color scheme
" Plug 'neoclide/coc.nvim', {'branch': 'release'} " Language Server Protocol client
Plug 'rbgrouleff/bclose.vim' " Close buffers while keeping windows open
Plug 'leafgarland/typescript-vim' " Syntax files for typescript
Plug 'jose-elias-alvarez/typescript.nvim' " More complete typescript LSP functionality
Plug 'ruanyl/vim-sort-imports' " Sort typescript imports

Plug 'wellle/targets.vim' " New text objects, like cI,

Plug 'machakann/vim-sandwich' " alternative to surround.vim

Plug 'Shatur/neovim-ayu' " Color scheme

Plug 'kdheepak/lazygit.nvim'
Plug 'azabiong/vim-highlighter'
"
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'ray-x/aurora' " Color scheme
Plug 'liuchengxu/vim-which-key'
Plug 'AckslD/nvim-whichkey-setup.lua'
Plug 'kevinhwang91/nvim-ufo' " Improved folding
Plug 'kevinhwang91/promise-async' " Required by nvim-ufo

Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'kyazdani42/nvim-web-devicons'

Plug 'echasnovski/mini.align' " Align statements
" Context.vim => Show context at top of window
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-context'
" Plug 'wellle/context.vim'

Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
" Plug 'hrsh7th/cmp-cmdline' -- I can't find a way to get completion in the cmdline without having to confirm with <CR>
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'

Plug 'stevearc/dressing.nvim' " Nicer select and input behavior
Plug 'lukas-reineke/indent-blankline.nvim' " Show indentation guides

Plug 'nvchad/nvim-colorizer.lua' " Show colors visually

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim' " Required by telescope
Plug 'BurntSushi/ripgrep' " Optional for telescope.nvim

Plug 'nvim-telescope/telescope-smart-history.nvim'
Plug 'kkharji/sqlite.lua' " Required by telescope-smart-history

Plug 'nvim-telescope/telescope-project.nvim'
Plug 'dcampos/nvim-snippy' " Snippet engine to hopefully make cmp not crash
Plug 'dcampos/cmp-snippy'

" Faster sorting of results in Telescope
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

Plug 'folke/trouble.nvim'

call plug#end()

call yankstack#setup()

filetype off
filetype plugin indent on
