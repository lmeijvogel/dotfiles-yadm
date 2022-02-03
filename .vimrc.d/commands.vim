" Quickly edit/reload the vimrc file
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>lv :so $MYVIMRC<CR>

" Quickly clear search history
nnoremap <silent> <leader>/ :nohlsearch<CR>

" Quickly select next and previous search results
nnoremap <silent> <C-A-n> :cn<CR>
nnoremap <silent> <C-A-p> :cp<CR>

" Add aliases to catch typos
command! W w
command! Wq wq
command! WQ wq
command! Q q

command! Qa qa
command! Wqa wqa
command! -bang Qa qa<bang>
command! -bang QA qa<bang>
command! -bang Wqa wqa<bang>

" Sudo write current file
cmap w!! w !sudo tee % >/dev/null

" Make S-y consistent with S-d etc.
nmap <silent> Y y$

" Mistyping F1 instead of ESC is annoying
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Easier movements: C-hjkl to move between splits
nmap <silent> <C-h> <C-w>h
nmap <silent> <C-j> <C-w>j
nmap <silent> <C-k> <C-w>k
nmap <silent> <C-l> <C-w>l

" Copy filename:line_number to clipboard
nnoremap <silent> <leader>fl :let @+ = expand("%:p").':'.line('.')<CR>
nnoremap <silent> <leader>ff :let @+ = expand("%:p")<CR>

" Easily create splits
nmap <silent> <leader>ss <C-w>s
nmap <silent> <leader>vv <C-w>v

" Easily resize splits
nmap <silent> <M-S-Up> <C-w>+
nmap <silent> <M-S-Down> <C-w>-
nmap <silent> <M-S-Left> <C-w><
nmap <silent> <M-S-Right> <C-w>>
nmap <silent> <M-Up> <C-w>8+
nmap <silent> <M-Down> <C-w>8-
nmap <silent> <M-Left> <C-w>8<
nmap <silent> <M-Right> <C-w>8>

nnoremap <silent> <leader>gb :!git gui blame %

" Replace Ruby rocket syntax with keyvalue syntax
command! LMRewriteRockets %s/:\([a-z3-9_]\{1,\}[!?]\?\) \?=>/\1:/g

" Delete trailing whitespace
command! LMDeleteTrailing %s/\s*$//<CR>;noh

" Easy toggling of word wrap
command! LMToggleWrap set wrap!

" Remap Q to 'run last macro'
nmap Q @@

" Disable K (man lookup)
nmap K <Nop>

" Easier next/prev buffer
nnoremap <silent> <M-h> :bp<CR>
nnoremap <silent> <M-l> :bn<CR>

" These work well in combination with 'delete buffer' <M-S-d>:
" I don't have to press/lift Shift every time.
nnoremap <silent> <M-S-h> :bp<CR>
nnoremap <silent> <M-S-l> :bn<CR>

" Same with ctrl-tab
nnoremap <silent> <C-Tab> :bn<CR>
nnoremap <silent> <C-S-Tab> :bp<CR>

" Easy delete buffer
nnoremap <M-S-d> :BD<CR>

if has('nvim')
  set inccommand=nosplit
endif

" Add "large" jumps to the jump list
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" Navigate through git conflict markers a bit more easily
nmap <leader>m /^<<<<<<<\\|^=======\\|^>>>>>>>/<CR>
vmap <leader>m /^<<<<<<<\\|^=======\\|^>>>>>>>/<CR>

nnoremap <leader>si :call SortImports()<CR>

" Only redraw screen _after_ a macro is finished
set lazyredraw

function! FormatXML()
    execute '%s/\\"/"/g'
    execute '%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"'
endfunction

function! UnformatXML()
    execute '%s/"/\\"/g'
    execute '%s/^\s*//g'
    execute '%join!'
endfunction

function! SortImports()
  let l:path = expand("%:p")
  let l:path = fnameescape(path)

  let l:winview=winsaveview()

  call system('npx import-sort --write ' . l:path)
  silent exec "e"

  call winrestview(l:winview)
endfunction
