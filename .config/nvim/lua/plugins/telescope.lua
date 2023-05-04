local map = vim.api.nvim_set_keymap

return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        file_ignore_patterns = { "node_modules" },
        path_display = { "truncate" },
        mappings = {
          i = {
            ["<C-u>"] = false,     -- Clear input
            ["<C-Down>"] = require('telescope.actions').cycle_history_next,
            ["<C-Up>"] = require('telescope.actions').cycle_history_prev,
          }
        },
        history = {
          path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
          limit = 100,
        }
      }
    },
    init = function()
      map('n', '<leader>a', ':Telescope live_grep<CR>', { desc = "Find" })
      map('n', '<leader>A', ':Telescope grep_string initial_mode=normal<CR>', { desc = "Find word under cursor" })
      map('n', '<C-p>', '<cmd>Telescope find_files<CR>', {})
      map('n', '-', '<cmd>Telescope buffers sort_mru=true ignore_current_buffer=true<CR>', {})

      map('n', '<leader>tf', '<cmd>Telescope find_files<CR>', { desc = "Find files <C-p>" })
      map('n', '<leader>tp', '<cmd>Telescope project<CR>', { desc = "Projects" })
      map('n', '<leader>tr', '<cmd>Telescope resume<CR>', { desc = "Resume previous" })
      map('n', '<leader>th', '<cmd>Telescope oldfiles<CR>', { desc = "History" })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "BurntSushi/ripgrep", -- Optional
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-smart-history.nvim",
    }
  },
  {
    "nvim-telescope/telescope-project.nvim",
    config = function()
      require 'telescope'.load_extension('project')
    end
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build =
    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    config = function()
      require('telescope').load_extension('fzf')
    end
  },

  -- Faster sorting of results in Telescope
  {
    "nvim-telescope/telescope-smart-history.nvim",
    init = function()
      require('telescope').load_extension('smart_history')
    end,
    dependencies = {
      "kkharji/sqlite.lua"
    }
  },
}
