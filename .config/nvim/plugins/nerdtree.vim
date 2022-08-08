nnoremap <silent> <leader>nt :NvimTreeToggle<CR>
nnoremap <silent> <leader>nf :NvimTreeFindFile<CR>

let g:NERDTreeShowRelativeLineNumbers=1
let g:NERDTreeQuitOnOpen=1
"
" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber

lua << NVIM_TREE
require("nvim-tree").setup({
    view = {
        adaptive_size = true,
        relativenumber = true
    },
})
NVIM_TREE
