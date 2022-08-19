" Better display for messages
set cmdheight=2

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#confirm() :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Use <c-space> to trigger refresh.
inoremap <silent><expr> <c-space> coc#refresh()

" DISABLED: Autocomplete the first item in the suggestions.
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
"
" It was disabled because it also autocompleted on whole word match, causing
" it to "swallow" an enter press.

" It conflicts with the endwise plugin, so it is disabled.

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
"
" This is a rewritten "default" that I got from this vim-endwise issue
"
"   https://github.com/tpope/vim-endwise/issues/125#issuecomment-1076678001
"
" (the CoC API changed since that comment was written)
" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                             " \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>\<c-r>=EndwiseDiscretionary()\<CR>"

" Keys from the coc.nvim github example config
"
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> <leader>cd :CocList diagnostics<CR>

" GoTo code navigation.

" This triggers the tagstack navigation instead of the regular coc-definition
nmap gd <C-]>
nmap <silent> gy <Plug>(coc-type-definition)

" do not use the "expected" gi shortcut, since that would replace the "continue
" last insert" command.
nmap <silent> gm <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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
nmap <leader>. <Plug>(coc-codeaction-selected)
vmap <leader>. <Plug>(coc-codeaction-selected)

nnoremap <silent> <leader>cr :CocRestart<CR>
nnoremap <silent> <leader>lr :CocListResume<CR>
nnoremap <silent> <leader>, :CocListResume<CR>

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

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Tell vim to use CoC as a tag source. This allows navigating to definitions
" and back through the regular vim tag stack.
set tagfunc=CocTagFunc
