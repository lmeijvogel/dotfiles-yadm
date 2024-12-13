return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = false },
      words = { enabled = true },
    },
    keys = {
      {
        '<M-S-d>',
        function()
          Snacks.bufdelete()
        end,
        desc = 'Delete Buffer',
      },
    },
  },
}
