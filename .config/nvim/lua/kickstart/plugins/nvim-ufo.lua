return {
  {
    'kevinhwang91/nvim-ufo', -- Improved folding
    dependencies = {
      'kevinhwang91/promise-async',
    },
    config = function()
      require('nvim-ufo').setup()

      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'NeogitStatus' },
        callback = function()
          require('ufo').detach()
          vim.opt_local.foldenable = false
          vim.opt_local.foldcolumn = '0'
        end,
      })
    end,
  },
}
