let g:snippets_dir="~/.vim/snippets"

set mouse=a

" Hide menubar and toolbar in gvim
let mapleader=" "

" No beeps or flashes on errors
set noerrorbells
set novisualbell
set t_vb=

set nowrap

set expandtab
set tabstop=2
set shiftwidth=2
set smarttab " Insert tabs at start of a line according to shiftwidth instead of tabstop

set backspace=indent,eol,start " Allow backspace over anything

set ignorecase " Ignore case when searching
set smartcase " Except when uppercase characters are given

set showmode " Show in which mode (command/insert/... vim is operating)

set foldenable
set fdm=indent
set foldlevelstart=99 " Start with all files unfolded

syntax on
" Syntax coloring lines that are too long just slows down the world
set synmaxcol=600

set listchars=trail:·,nbsp:_,extends:❯,precedes:❮,tab:▸\ 
set list

set scrolloff=3 " Always show 3 lines above and below cursor

set sidescrolloff=20
set sidescroll=1 " Sidescroll per single column

" Add WildMenu for easier tab completion of filenames
set wildmenu

set incsearch " Incremental search
set hlsearch " Highlight search terms

set showmatch " Show matching parentheses

set autoindent " Always enable autoindent
set copyindent " Copy the previous indentation on autoindenting

" Disable error bells
set t_vb=
set noerrorbells " don't beep

set wildignore=*.swp,*.bak,*.orig
set wildignore+=*.pyc,*.class,*.scssc
set wildignore+=tmp/**,*/cache/*,coverage/**
set wildignore+=tags,gems.tags
set wildignore+=*.gif,*.png,*.jpg,*.jpeg

set history=1000
set undolevels=1000

set nobackup
set noswapfile
set hidden " Allow hidden unsaved buffers

filetype plugin indent on

set cursorline
set ruler
set relativenumber " Relative line numbers for easier navigation
set number " Still show the current line number instead of '0'

" Disallow window resizing
set winfixwidth

" Save all files when Vim loses focus
au FocusLost * silent! :wa

" Statusline
set laststatus=2 " Always show status line
set statusline=[%n]\ %f\ %m\ %y%=%l,%c\ %P

" Add tab number to tab
set guitablabel=%N)\ %t\ %M

" Highlight whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Work only: use 4 spaces when opening ts and tsx files
autocmd BufEnter *.ts,*.tsx set ts=4 sw=4

set encoding=utf-8

" Don't ask to reload the file when it changes on disk
set autoread

" Use the system clipboard by default
set clipboard=unnamedplus

" For neovide and neovim-qt
set guifont=Cascadia\ Code:h12

" For neovide

" let g:neovide_cursor_vfx_mode = "torpedo"
let g:neovide_cursor_animation_length=0
