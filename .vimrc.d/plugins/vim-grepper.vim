" vim-grepper
nnoremap <leader>A :Grepper -tool ack -cword -noprompt<cr>
nnoremap <leader>a :Grepper -tool ack<cr>
let g:grepper.ack.grepprg .= ' --smart-case'

" Ack visual selection
vmap <leader>a "vy;Ack! "<C-r>v"
vmap <leader>A "vy;Ack! "<C-r>v"<CR>
