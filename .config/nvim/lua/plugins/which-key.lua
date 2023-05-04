return {
  "folke/which-key.nvim",
  opts = {
    defaults = {
      mode = { "n", "v" },
      a = "Find",
      A = "Find word under cursor",
      b = { name = "Buffers" },
      c = { name = "Comments" },
      m = "Find merge markers",
      f = {
        name = "Filename",
      },
      g = { name = "git" },
      e = { name = "Neovim config" },
      n = { name = "Nvim-tree" },
      r = "Rename",
      s = { name = "Tasks", },
      t = { name = "Telescope" },
    },
  },
  config = function(_, opts)
    vim.o.timeout = true
    vim.o.timeoutlen = 500

    local wk = require('which-key')

    wk.setup(opts)

    wk.register(opts.defaults, { prefix = "<leader>" })
  end
}
