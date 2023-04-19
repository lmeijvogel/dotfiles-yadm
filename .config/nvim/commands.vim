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

" Remap Q to 'run last macro'
nmap Q @@

" Disable K (man lookup)
nmap K <Nop>

" Add "large" jumps to the jump list
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" Center cursor after page up/down
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz

" Navigate through git conflict markers a bit more easily
nmap <leader>m /^<<<<<<<\\|^=======\\|^>>>>>>>/<CR>
vmap <leader>m /^<<<<<<<\\|^=======\\|^>>>>>>>/<CR>

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
