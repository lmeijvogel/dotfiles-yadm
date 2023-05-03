source ~/.config/nvim/plugins/nerdtree.vim

call yankstack#setup()

nnoremap <F5> :UndotreeToggle<CR>

" vim-sandwich
runtime macros/sandwich/keymap/surround.vim

" Buffet
nnoremap <silent> <leader>bb :Bufferlist<CR>
nnoremap <silent> <leader>be :Bufferlist<CR>

" The order is "reversed" (j is previous, k is next) to look more like
" left <-> right
nnoremap <C-A-k> :bn<CR>
nnoremap <C-A-j> :bp<CR>

" fugitive
nnoremap <leader>gs :Git<CR>
nnoremap <leader>ga :Git add %<CR>
nnoremap <leader>gb :call GitGuiBlame()<CR>

nnoremap <silent> <M-h> :bp<CR>
nnoremap <silent> <M-l> :bn<CR>

" With shift - makes for easier buffer deletion (not having to release and press Shift every time)
nnoremap <silent> <M-S-h> :bp<CR>
nnoremap <silent> <M-S-l> :bn<CR>

" Easy delete buffer
nnoremap <M-S-d> :BD<CR>

" Same with ctrl-tab
nnoremap <silent> <C-Tab> :bn<CR>
nnoremap <silent> <C-S-Tab> :bp<CR>

" NERDCommenter - space after comment delimiters
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Use C-/ for toggling comments (for some reason <C-/> is transmitted as <C-_> in vim)
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv

" vim-indentwise

" These aren't mapped by default
nmap <silent> [- <Plug>(IndentWisePreviousLesserIndent)
nmap <silent> ]- <Plug>(IndentWiseNextLesserIndent)

if has('nvim')
  " NeoTerm
  let g:neoterm_default_mod = 'horizontal'
  let g:neoterm_automap_keys = '<leader>tt'

  let test#strategy = "asyncrun_background"
  let test#ruby#rspec#executable = 'rspec'
  let test#javascript#jest#executable = 'npm run test'
  "
  " Do not build by default since it's slow
  let test#csharp#dotnettest#executable = 'dotnet test --no-build -l "console;verbosity=normal"'

  nnoremap <silent> <leader>sa :TestSuite<CR>
  nnoremap <silent> <leader>sf :w<CR>:TestFile<CR>
  nnoremap <silent> <leader>sl :w<CR>:TestNearest<CR>
  nnoremap <silent> <leader>st :w<CR>:TestLast<CR>
  nnoremap <silent> <leader>sr :call SwitchTestRunner()<CR>
  nnoremap <silent> <leader>si <Plug>SetTmuxVars

  nnoremap <silent> <leader>sd :Trouble document_diagnostics<CR>
  nnoremap <silent> <leader>sw :Trouble quickfix<CR>
  nnoremap <silent> <leader>sb :make<CR>

  " Automatically enter insert mode in the terminal
  autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufLeave term://* stopinsert

  set inccommand=nosplit
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k

  lua << LUA
  vim.cmd [[
    augroup strdr4605
      autocmd FileType typescript,typescriptreact compiler tsc | setlocal makeprg=npx\ tsc
    augroup END
  ]]
LUA
end

function! SwitchTestRunner()
  if g:test#strategy  == "neoterm"
    let g:test#strategy = "tslime"
    echo "Sending tests to tslime"
  else
    let g:test#strategy = "neoterm"
    echo "Sending tests to neoterm"
  endif
endfunction

function! GitGuiBlame()
  exec("!git gui blame --line=". line('.') ." \"%\"")
endfunction

let g:prettier#exec_cmd_path = getcwd() . "/node_modules/.bin/prettier-eslint"

let g:nvim_typescript#signature_complete = 1
let g:nvim_typescript#max_completion_detail = 25
let g:nvim_typescript#tsimport#template = 'import { %s } from "%s";'

let g:prettier#config#print_width = 120
let g:prettier#config#tab_width = 4
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#single_quote = 'false'
let g:prettier#config#trailing_comma = 'none'

let g:prettier#quickfix_enabled = 0

nnoremap <leader>gg :LazyGit<CR>
