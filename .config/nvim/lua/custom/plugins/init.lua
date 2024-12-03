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
      local overseer = require 'overseer'

      overseer.setup()

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

      -- open = true: Open quickfix if there are diagnostics
      -- close = true: Close quickfix if there are no diagnostics
      overseer.add_template_hook({ module = 'vscode', name = '^Typescript watch' }, function(task_defn, util)
        util.add_component(task_defn, { 'on_result_diagnostics_quickfix', open = true, close = true })
        util.add_component(task_defn, { 'on_complete_notify', statuses = { 'SUCCESS' } })
      end)

      vim.keymap.set('n', '<leader>tr', '<cmd>OverseerRun<CR>', { desc = 'Run task' })
      vim.keymap.set('n', '<leader>tt', '<cmd>OverseerToggle<CR>', { desc = 'Toggle tasks window' })
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
  {
    'zk-org/zk-nvim',
    config = function()
      require('zk').setup {
        -- can be "telescope", "fzf", "fzf_lua", "minipick", or "select" (`vim.ui.select`)
        -- it's recommended to use "telescope", "fzf", "fzf_lua", or "minipick"
        picker = 'telescope',

        lsp = {
          -- `config` is passed to `vim.lsp.start_client(config)`
          config = {
            cmd = { 'zk', 'lsp' },
            name = 'zk',
            -- on_attach = ...
            -- etc, see `:h vim.lsp.start_client()`
          },

          -- automatically attach buffers in a zk notebook that match the given filetypes
          auto_attach = {
            enabled = true,
            filetypes = { 'markdown' },
          },
        },
      }

      vim.keymap.set('n', '<leader>kn', '<cmd>ZkNew<CR>', {})
      vim.keymap.set('v', '<leader>knt', "<cmd>'<,'>ZkNewFromTitleSelection<CR>", {})
      vim.keymap.set('v', '<leader>knc', "<cmd>'<,'>ZkNewFromContentSelection<CR>", {})

      vim.keymap.set('n', '<leader>kl', '<cmd>ZkNotes<CR>', {})
      vim.keymap.set('n', '<leader>kt', "<cmd>'<,'>ZkTags<CR>", {})

      vim.keymap.set('n', '<leader>kd', "<cmd>ZkNew { dir = 'journal/daily' }<CR>", {})
    end,
  },
  {
    'kevinhwang91/nvim-ufo', -- Improved folding
    dependencies = {
      'kevinhwang91/promise-async',
    },
    config = function()
      vim.opt.foldlevelstart = 99
      vim.opt.foldenable = true

      require('ufo').setup {
        provider_selector = function()
          return { 'treesitter', 'indent' }
        end,
      }
      --
    end,
  },
}
