local map = vim.api.nvim_set_keymap

return {
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
  {
    "kyazdani42/nvim-tree.lua",
    lazy = false,
    dependencies = {
      "kyazdani42/nvim-web-devicons", -- optional, for file icons
    }
  },
  "rbgrouleff/bclose.vim",   -- Close buffers while keeping windows open
  {
    "kevinhwang91/nvim-ufo", -- Improved folding
    dependencies = {
      "kevinhwang91/promise-async"
    }
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      -- The default sections, except mentioned below
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'filetype' }, -- Removed 'encoding' and 'fileformat' here
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
    },
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
  {
    "justinmk/vim-sneak",
    init = function()
      vim.g["sneak#label"] = 1 -- Emulate easymotion (show label for navigation). Otherwise, it would navigate with ;,

      map('n', 'f', '<Plug>Sneak_f', {})
      map('n', 'F', '<Plug>Sneak_F', {})
    end
  },
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

  "jeetsukumaran/vim-indentwise", -- Easy navigation based on indent level
  "leafgarland/typescript-vim",   -- Syntax files for typescript
  "ruanyl/vim-sort-imports",      -- Sort typescript imports

  "wellle/targets.vim",           -- New text objects, like cI,

  "machakann/vim-sandwich",       -- alternative to surround.vim

  "kdheepak/lazygit.nvim",
  "azabiong/vim-highlighter",
  { "iamcco/markdown-preview.nvim", build = "cd app && yarn install" },
  "echasnovski/mini.align", -- Align statements
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- this can also be a list of languages
      ensure_installed = { "c", "javascript", "typescript", "tsx", "lua", "ruby" },
      auto_install = true,
      highlight = { enable = true },
    }
  },

  -- Context.vim => Show context at top of window
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      enable = true,   -- Enable this plugin (Can be enabled/disabled later via commands)
      mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = "-",
    }
  },
  "stevearc/dressing.nvim",                -- Nicer select and input behavior
  {
    "lukas-reineke/indent-blankline.nvim", -- Show indentation guides
    opts = {
      space_char_blankline = " ",
      show_current_context = true,
      show_current_context_start = false, -- The start marker resembles an LSP diagnostic too much
    }
  },
  "nvchad/nvim-colorizer.lua", -- Show colors visually
  'folke/trouble.nvim',
  "stevearc/overseer.nvim",    -- Task runner (e.g. VSCode tasks)
}