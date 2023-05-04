require('colors')

vim.opt.list = true
local map = vim.api.nvim_set_keymap

-- The order is "reversed" (j is previous, k is next) to look more like
-- left <-> right
map('n', '<C-A-k>', '<cmd>bn<CR>', {})
map('n', '<C-A-j>', '<cmd>bp<CR>', {})

map('n', '<M-h>', '<cmd>bp<CR>', {})
map('n', '<M-l>', '<cmd>bn<CR>', {})

-- With shift - makes for easier buffer deletion (not having to release and press Shift every time)
map('n', '<M-S-h>', '<cmd>bp<CR>', {})
map('n', '<M-S-l>', '<cmd>bn<CR>', {})

-- Easy delete buffer
map('n', '<M-S-d>', '<cmd>BD<CR>', {})

-- Same with ctrl-tab
map('n', '<C-Tab>', '<cmd>bn<CR>', {})
map('n', '<C-S-Tab>', '<cmd>bp<CR>', {})

vim.g["neoterm_default_mod"] = 'horizontal'
vim.g["neoterm_automap_keys"] = '<leader>tt'

vim.cmd [[let test#strategy = "asyncrun_background"]]
vim.cmd [[let test#ruby#rspec#executable = 'rspec']]
vim.cmd [[let test#javascript#jest#executable = 'npm run test']]

-- Do not build by default since it's slow
vim.cmd [[let test#csharp#dotnettest#executable = 'dotnet test --no-build -l "console;verbosity=normal"']]

map('n', '<leader>sa', '<cmd>TestSuite<CR>', { desc = "Test - all" })
map('n', '<leader>sf', '<cmd>w<CR><cmd>TestFile<CR>', { desc = "Test - file" })
map('n', '<leader>sn', '<cmd>w<CR><cmd>TestNearest<CR>', { desc = "Test - nearest" })
map('n', '<leader>sl', '<cmd>w<CR><cmd>TestLast<CR>', { desc = "Test - last" })
map('n', '<leader>sr', '<cmd>call SwitchTestRunner()<CR>', { desc = "Switch test runner" })
map('n', '<leader>si', '<Plug>SetTmuxVars', { desc = "Reset tmux vars" })

map('n', '<leader>sd', '<cmd>Trouble document_diagnostics<CR>', { desc = "Document diagnostics" })
map('n', '<leader>sw', '<cmd>Trouble quickfix<CR>', { desc = "Project diagnostics (after build)" })
map('n', '<leader>sb', '<cmd>make<CR>', { desc = "Build project" })

vim.cmd [[
  augroup strdr4605
    autocmd FileType typescript,typescriptreact compiler tsc | setlocal makeprg=npx\ tsc
  augroup END
]]

function SwitchTestRunner()
  if vim.g["test#strategy"] == "neoterm" then
    vim.g["test#strategy"] = "tslime"
    print "Sending tests to tslime"
  else
    vim.g["test#strategy"] = "neoterm"
    print "Sending tests to neoterm"
  end
end

function GitGuiBlame()
  vim.exec("!git gui blame --line=" .. vim.fn.line('.') .. " \"%\"")
end

vim.g["prettier#exec_cmd_path"] = vim.fn.getcwd() .. "/node_modules/.bin/prettier-eslint"

vim.g["nvim_typescript#signature_complete"] = 1
vim.g["nvim_typescript#max_completion_detail"] = 25
vim.g["nvim_typescript#tsimport#template"] = 'import { %s } from "%s";'

vim.g["prettier#config#print_width"] = 120
vim.g["prettier#config#tab_width"] = 4
vim.g["prettier#config#bracket_spacing"] = 'true'
vim.g["prettier#config#single_quote"] = 'false'
vim.g["prettier#config#trailing_comma"] = 'none'

vim.g["prettier#quickfix_enabled"] = 0

map('n', '<leader>gg', '<cmd>LazyGit<CR>', { desc = "LazyGit" })
