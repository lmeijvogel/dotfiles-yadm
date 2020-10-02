" Better display for messages
set cmdheight=2

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" DISABLED: Autocomplete the first item in the suggestions.
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
"
" It was disabled because it also autocompleted on whole word match, causing
" it to "swallow" an enter press.

" Note: This used to clash with endwise.vim, causing the string to be
" written to the buffer. I uninstalled endwise.
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" Keys from the coc.nvim github example config
"
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)"

" Remap keys for gotos
nmap <silent> <F12> <Plug>(coc-definition)

nmap <silent> <C-F12> <Plug>(coc-implementation)

" For neovim-qt
nmap <silent> <S-F12> <Plug>(coc-references)
nmap <silent> gr <Plug>(coc-references)

" For console usage
nmap <silent> <F24> <Plug>(coc-references)

" Perform the first quick fix
nmap <silent> <leader>qf <Plug>(coc-fix-current)

nmap <leader>n <Plug>(coc-diagnostic-next-error)
nmap <leader>p <Plug>(coc-diagnostic-prev-error)

nmap <leader>rr <Plug>(coc-rename)
nmap <leader>ra <Plug>(coc-codeaction-selected)
vmap <leader>ra <Plug>(coc-codeaction-selected)

nmap <silent> <leader>cr :CocRestart<CR>
nmap <silent> <leader>lr :CocListResume<CR>

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> gh :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight position of error black on red
highlight CocErrorHighlight ctermbg=Red ctermfg=Black guifg=#000000 guibg=#ff0000

