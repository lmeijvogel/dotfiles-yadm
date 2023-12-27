local map = vim.api.nvim_set_keymap

-- Quickly clear search history
map('n', '<leader>/', ':nohlsearch<CR>', { desc = "Clear search highlight" })

-- Quickly select next and previous search results
map('n', '<C-A-n>', ':cn<CR>', {})
map('n', '<C-A-p>', ':cp<CR>', {})

-- Add aliases to catch typos
vim.cmd [[command! W w]]
vim.cmd [[command! Wq wq]]
vim.cmd [[command! WQ wq]]
vim.cmd [[command! Q q]]

vim.cmd [[command! Qa qa]]
vim.cmd [[command! Wqa wqa]]
vim.cmd [[command! -bang Qa qa<bang>]]
vim.cmd [[command! -bang QA qa<bang>]]
vim.cmd [[command! -bang Wqa wqa<bang>]]

-- Sudo write current file
map('c', 'w!!', 'w !sudo tee % >/dev/null', {})

-- Make S-y consistent with S-d etc.
map('n', 'Y', 'y$', {})

-- Mistyping F1 instead of ESC is annoying
map('i', '<F1>', '<ESC>', {})
map('n', '<F1>', '<ESC>', {})
map('x', '<F1>', '<ESC>', {})

-- Easier movements: C-hjkl to move between splits
map('n', '<C-h>', '<C-w>h', {})
map('n', '<C-j>', '<C-w>j', {})
map('n', '<C-k>', '<C-w>k', {})
map('n', '<C-l>', '<C-w>l', {})

-- Copy filename:line_number to clipboard
map('n', '<leader>fl', ':let @+ = expand("%:p").\':\'.line(\'.\')<CR>', { desc = "Copy file+line to clipboard" })
map('n', '<leader>ff', ':let @+ = expand("%:p")<CR>', { desc = "Copy file to clipboard" })

-- Easily create splits
map('n', '<leader>ss', '<C-w>s', { desc = "Split window" })
map('n', '<leader>vv', '<C-w>v', { desc = "Split window vertically" })
map('n', '<leader>vv', '<C-w>v', { desc = "Split window vertically" })

-- Easily resize splits
map('n', '<M-S-Up>', '<C-w>+', {})
map('n', '<M-S-Down>', '<C-w>-', {})
map('n', '<M-S-Left>', '<C-w><', {})
map('n', '<M-S-Right>', '<C-w>>', {})
map('n', '<M-Up>', '<C-w>8+', {})
map('n', '<M-Down>', '<C-w>8-', {})
map('n', '<M-Left>', '<C-w>8<', {})
map('n', '<M-Right>', '<C-w>8>', {})

map('n', '<leader>gb', ':!git gui blame %', { desc = "Blame" })

-- Remap Q to 'run last macro'
map('n', 'Q', '@@', {})

-- Disable K (man lookup)
map('n', 'K', '<Nop>', {})

-- Add "large" jumps to the jump list
map('n', '<expr>', 'k (v:count > 1 ? "m\'" . v:count : \'\') . \'k\'', {})
map('n', '<expr>', 'j (v:count > 1 ? "m\'" . v:count : \'\') . \'j\'', {})

-- Center cursor after page up/down
map('n', '<C-u>', '<C-u>zz', {})
map('n', '<C-d>', '<C-d>zz', {})

-- Navigate through git conflict markers a bit more easily
map('n', '<leader>m', '/^<<<<<<<\\|^|||||||\\|^=======\\|^>>>>>>>/<CR>', { desc = "Find conflict markers" })
map('x', '<leader>m', '/^<<<<<<<\\|^|||||||\\|^=======\\|^>>>>>>>/<CR>', { desc = "Find conflict markers" })
