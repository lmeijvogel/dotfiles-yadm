-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration

      -- Only one of these is needed, not both.
      'nvim-telescope/telescope.nvim', -- optional
      'ibhagwan/fzf-lua', -- optional
    },
    config = function()
      require('neogit').setup {}

      vim.keymap.set('n', '<leader>gs', '<cmd>Neogit<CR>', { desc = 'Status' })
    end,
  },
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>ga', '<cmd>Git add %<CR>', { desc = 'Add current file' })
      vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<CR>', { desc = 'Git blame' })
    end,
  },

  'numToStr/Comment.nvim',
  {
    'neomake/neomake',
    config = function()
      vim.cmd [[
        augroup strdr4605
          autocmd FileType typescript,typescriptreact compiler tsc | setlocal makeprg=npx\ tsc
        augroup END
      ]]

      vim.cmd [[
        autocmd User NeomakeFinished :Trouble quickfix
        autocmd User NeomakeJobInit :wall
      ]]

      vim.keymap.set('n', '<leader>ww', '<cmd>Trouble quickfix<CR>', { desc = 'Project diagnostics (after build)' })
      vim.keymap.set('n', '<leader>wb', '<cmd>NeomakeProject<CR>', { desc = '[B]uild project' })
    end,
  },
  {
    'folke/trouble.nvim',
    opts = {},
  },
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup {}
    end,
  },
  {
    'stevearc/overseer.nvim',
    config = function()
      require('overseer').setup()

      vim.api.nvim_create_user_command('Make', function(params)
        -- Insert args at the '$*' in the makeprg
        local cmd, num_subs = vim.o.makeprg:gsub('%$%*', params.args)
        if num_subs == 0 then
          cmd = cmd .. ' ' .. params.args
        end
        local task = require('overseer').new_task {
          cmd = vim.fn.expandcmd(cmd),
          components = {
            { 'on_output_quickfix', open = not params.bang, open_height = 8 },
            'default',
          },
        }
        task:start()
      end, {
        desc = 'Run your makeprg as an Overseer task',
        nargs = '*',
        bang = true,
      })
    end,
  }, -- Task runner (e.g. VSCode tasks)
  {
    'Shatur/neovim-session-manager',
    config = function()
      local config = require 'session_manager.config'

      require('session_manager').setup {
        autoload_mode = { config.AutoloadMode.CurrentDir },
      }
    end,
  },
  {
    'famiu/bufdelete.nvim', -- Allow deleting buffers while keeping splits (which :bd doesn't do)
    config = function()
      -- Easy delete buffer
      vim.keymap.set('n', '<M-S-d>', '<cmd>Bdelete<CR>', {})
    end,
  },
}
