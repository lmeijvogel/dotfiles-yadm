local map = vim.api.nvim_set_keymap

return {
  -- Editor-wide (not buffer-bound)
  {
    "sandeepcr529/Buffet.vim", -- Buffer explorer
    config = function()
      map('n', '<leader>bb', '<cmd>Bufferlist<CR>', { desc = "Open Bufferlist" })
      map('n', '<leader>be', '<cmd>Bufferlist<CR>', { desc = "Open Bufferlist" })
    end
  },
  {
    "mbbill/undotree", -- Undo history visualisation
    config = function()
      map('n', '<F5>', '<cmd>UndotreeToggle<CR>', { desc = "UndoTree" })
    end
  },
  "duff/vim-scratch", -- Scratch buffer
  "mileszs/ack.vim",
  {
    "tpope/vim-fugitive",
    config = function()
      map('n', '<leader>ga', '<cmd>Git add %<CR>', { desc = "Add current file" })
      vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<CR>', { desc = "Git blame" })
    end
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    config = function()
      require('neogit').setup()

      map('n', '<leader>gs', '<cmd>Neogit<CR>', { desc = "Status" })
    end
  },
  "junegunn/fzf",
  "junegunn/fzf.vim",
  "mhinz/vim-grepper",
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        adaptive_size = true,
        relativenumber = true
      },
      renderer = {
        group_empty = true
      }
    },
    config = function(_, opts)
      require('nvim-tree').setup(opts)

      map('n', '<leader>nt', '<cmd>NvimTreeToggle<CR>', { desc = "Toggle tree" })
      map('n', '<leader>nf', '<cmd>NvimTreeFindFile<CR>', { desc = "Open tree at current file" })
    end,
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
    },
    config = true
  },
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup({
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true
      })
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = 'material'
      },
      -- The default sections, except mentioned below
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'diagnostics' },
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
  "ray-x/aurora",            -- Color scheme
  "Shatur/neovim-ayu",       -- Color scheme

  "fmoralesc/molokayo",      -- Dark color scheme
  "rakr/vim-one",            -- Light color scheme
  {
    "folke/tokyonight.nvim", -- Color scheme
    lazy = false,
    priority = 1000,
    opts = {},
  },
  "NLKNguyen/papercolor-theme", -- Light color scheme (and dark, but I only use light)
  "bogado/file-line",           -- Copy file/line to clipboard
  {
    "preservim/nerdcommenter",
    config = function()
      -- Space after comment delimiters
      vim.g["NERDSpaceDelims"] = 1

      -- Use compact syntax for prettified multi-line comments
      vim.g["NERDCompactSexyComs"] = 1

      -- Use C-/ for toggling comments (for some reason <C-/> is transmitted as <C-_> in vim)
      map('n', '<C-_>', '  <Plug>NERDCommenterToggle', { desc = "" })
      map('v', '<C-_>', '  <Plug>NERDCommenterToggle<CR>gv', { desc = "" })
    end
  },
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

  {
    "jeetsukumaran/vim-indentwise", -- Easy navigation based on indent level
    config = function()
      -- These aren't mapped by default
      map('n', '<silent>', '[- <Plug>(IndentWisePreviousLesserIndent)', { desc = "" })
      map('n', '<silent>', ']- <Plug>(IndentWiseNextLesserIndent)', { desc = "" })
    end
  },
  "leafgarland/typescript-vim", -- Syntax files for typescript
  "ruanyl/vim-sort-imports",    -- Sort typescript imports

  "wellle/targets.vim",         -- New text objects, like cI,

  {
    "machakann/vim-sandwich", -- alternative to surround.vim
    config = function()
      vim.cmd [[runtime macros/sandwich/keymap/surround.vim]]
    end
  },

  "kdheepak/lazygit.nvim",
  "azabiong/vim-highlighter",
  { "iamcco/markdown-preview.nvim", build = "cd app && yarn install" },
  "echasnovski/mini.align", -- Align statements
  {
    "echasnovski/mini.ai",  -- Extra text objects
    config = function()
      require('mini.ai').setup({})
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- this can also be a list of languages
      ensure_installed = { "c", "javascript", "typescript", "tsx", "lua", "ruby" },
      auto_install = true,
      highlight = { enable = true },
    }
  },

  -- "stevearc/dressing.nvim",                -- Nicer select and input behavior
  {
    "lukas-reineke/indent-blankline.nvim", -- Show indentation guides
    main = "ibl",
  },
  "nvchad/nvim-colorizer.lua", -- Show colors visually
  {
    'folke/trouble.nvim',
    opts = {}
  },
  'folke/neodev.nvim',      -- dev configuration for lua scripting in nvim
  "stevearc/overseer.nvim", -- Task runner (e.g. VSCode tasks)
  {
    "sindrets/diffview.nvim",
    config = function()
      require('diffview').setup({
        view = {
          layout = "diff4_mixed"
        }
      })
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup({
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 500,
          ignore_whitespace = false,
          virt_text_priority = 100,
        },

        on_attach = function()
          local gs = package.loaded.gitsigns
          vim.keymap.set('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          vim.keymap.set('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          vim.keymap.set('n', '<leader>gd', gs.toggle_deleted, { desc = "Show deleted hunks" })
          vim.keymap.set('n', '<leader>g=', gs.stage_hunk, { desc = "Stage hunk" })
          vim.keymap.set('n', '<leader>g-', gs.undo_stage_hunk, { desc = "Undo stage hunk" })
          vim.keymap.set('v', '<leader>g=', function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end,
            { desc = "Stage hunk" })
          vim.keymap.set('v', '<leader>g-',
            function() gs.undo_stage_hunk { vim.fn.line("."), vim.fn.line("v") } end,
            { desc = "Undo stage hunk" })

          -- Use a nicer color
          vim.cmd [[hi! link GitSignsCurrentLineBlame Conceal]]
        end,
        yadm = {
          enable = true
        },
      })
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
  },
  {
    "cbochs/portal.nvim",
    config = function()
      require("portal").setup({
        ---The raw window options used for the portal window
        window_options = {
          height = 8,
        },
      })

      vim.keymap.set("n", "<leader>o", "<cmd>Portal jumplist backward<cr>")
      vim.keymap.set("n", "<leader>i", "<cmd>Portal jumplist forward<cr>")
    end
  }
}
