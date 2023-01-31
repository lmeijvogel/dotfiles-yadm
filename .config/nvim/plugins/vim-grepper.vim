" vim-grepper
nnoremap <leader>A :Grepper -tool rg -cword -noprompt<cr>
nnoremap <leader>a :Grepper -tool rg<cr>

runtime plugin/grepper.vim
let g:grepper.ack.grepprg .= ' --smart-case'

" Ack visual selection
vmap <leader>a "vy:Ack! "<C-r>v"
vmap <leader>A "vy:Ack! "<C-r>v"<CR>
