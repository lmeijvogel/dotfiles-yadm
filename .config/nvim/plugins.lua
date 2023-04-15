-- Bootstrap Lazy if it's not installed yet
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Editor-wide (not buffer-bound)
  "sandeepcr529/Buffet.vim", -- Buffer explorer
  "mbbill/undotree",         -- Undo history visualisation
  "duff/vim-scratch",        -- Scratch buffer
  "mileszs/ack.vim",
  "tpope/vim-fugitive",
  "jgdavey/tslime.vim",
  "jgdavey/vim-turbux",
  "kassio/neoterm",
  "junegunn/fzf",
  "junegunn/fzf.vim",
  "mhinz/vim-grepper",
  "kyazdani42/nvim-tree.lua",
  "kyazdani42/nvim-web-devicons", -- optional, for file icons
  "rbgrouleff/bclose.vim",        -- Close buffers while keeping windows open
  {
    "liuchengxu/vim-which-key",
    dependencies = {
      "AckslD/nvim-whichkey-setup.lua",
    }
  },
  {
    "kevinhwang91/nvim-ufo", -- Improved folding
    dependencies = {
      "kevinhwang91/promise-async"
    }
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      -- If you want to have icons in your statusline choose one of these
      "kyazdani42/nvim-web-devicons",
    }
  },
  "vim-scripts/bufkill.vim", -- Commands for deleting the current buffer
  "andymass/vim-matchup",    -- Enhances the "%" key to match more patterns.

  -- Color schemes
  "ray-x/aurora",               -- Color scheme
  "Shatur/neovim-ayu",          -- Color scheme

  "fmoralesc/molokayo",         -- Dark color scheme
  "rakr/vim-one",               -- Light color scheme

  "NLKNguyen/papercolor-theme", -- Light color scheme (and dark, but I only use light)
  "bogado/file-line",           -- Copy file/line to clipboard
  "preservim/nerdcommenter",
  "tpope/vim-repeat",
  {
    "maxbrunsfeld/vim-yankstack",
    config = function()
      vim.cmd([[call yankstack#setup()]])
    end
  },
  "vim-ruby/vim-ruby",
  { "tpope/vim-endwise",            ft = "ruby" }, -- Automatically close begin/end statements
  "tpope/vim-unimpaired",                          -- Bracket commands: ]b, etc.
  "tpope/vim-rsi",                                 -- Readline style insertions
  "editorconfig/editorconfig-vim",
  "ntpeters/vim-better-whitespace",                -- Better whitespace highlighting
  "buztard/vim-rel-jump",                          -- Store relative jumps (5j, 3k) in the jump list
  -- "jose-elias-alvarez/buftabline.nvim",  {"branch": "main"} ",Buffer list at top of screen
  "justinmk/vim-sneak",
  "janko-m/vim-test",
  "AndrewRadev/splitjoin.vim",
  "jelera/vim-javascript-syntax",
  "MaxMEllon/vim-jsx-pretty", -- Syntax highlighting jsx/tsx
  "prettier/vim-prettier",
  {
    "jceb/vim-orgmode",
    dependencies = {
      "vim-scripts/utl.vim", -- Universal Text Linking -- Needed for orgmode links between files
      "mattn/calendar-vim",
    }
  },
  "elixir-editors/vim-elixir",



  "jeetsukumaran/vim-indentwise",       -- Easy navigation based on indent level
  "leafgarland/typescript-vim",         -- Syntax files for typescript
  "jose-elias-alvarez/typescript.nvim", -- More complete typescript LSP functionality
  "ruanyl/vim-sort-imports",            -- Sort typescript imports

  "wellle/targets.vim",                 -- New text objects, like cI,

  "machakann/vim-sandwich",             -- alternative to surround.vim

  "kdheepak/lazygit.nvim",
  "azabiong/vim-highlighter",
  --
  { "iamcco/markdown-preview.nvim", build = "cd app && yarn install" },

  "echasnovski/mini.align", -- Align statements

  "nvim-treesitter/nvim-treesitter",
  -- Context.vim => Show context at top of window
  "nvim-treesitter/nvim-treesitter-context",

  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    }
  },

  "neovim/nvim-lspconfig",
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      -- "hrsh7th/cmp-cmdline",-- I can"t find a way to get completion in the cmdline without having to confirm with <CR>
      "hrsh7th/cmp-nvim-lsp-signature-help",
    }
  },

  "stevearc/dressing.nvim",              -- Nicer select and input behavior
  "lukas-reineke/indent-blankline.nvim", -- Show indentation guides

  "nvchad/nvim-colorizer.lua",           -- Show colors visually

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "BurntSushi/ripgrep", -- Optional
    }
  },

  {
    "nvim-telescope/telescope-smart-history.nvim",
    dependencies = {
      "kkharji/sqlite.lua"
    }
  },

  -- Faster sorting of results in Telescope
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build =
    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
  },
});
