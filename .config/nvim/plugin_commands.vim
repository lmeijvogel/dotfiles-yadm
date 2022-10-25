source ~/.config/nvim/plugins/vim-grepper.vim
source ~/.config/nvim/plugins/coc.nvim.vim
source ~/.config/nvim/plugins/nerdtree.vim
source ~/.config/nvim/plugins/firenvim.vim

" ALE
let g:ale_linters = {}
let g:ale_fixers = {}

let g:ale_enabled = 0

let g:ale_lint_on_text_changed = 'never'

" Ayu (color scheme)
lua << AYU
require('ayu').setup(
{
    mirage = false, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
    overrides = {
      Comment = {
        fg = "#0ecf00"
      },
      Normal = {
        fg = "#000000",
        bg = "#ffffff"
      },
      NormalNC = {
        fg = "#444444",
        bg = "#f4f4f4"
      },
      CocMenuSel = {
        fg = "#fafafa",
        bg = "#13354a"
      },
      LineNr = {
        fg = "#a2a2a2"
      },
      -- Highlight position of error black on red
      CocErrorHighlight = {
        fg = "#000000",
        bg = "#ff0000"
      },
      TabLineFill = {
        fg = "#303137",
        bg = "#c0c0c0"
      },
      StatusLine = {
        fg = "#494b53",
        bg = "#c0c0c0"
      },
      StatusLineNC = {
        fg = "#494b53",
        bg = "#c0c0c0"
      },
      CocFloating = {
        bg = "#e0e0e0"
      },
      CursorLine = {
        bg = "#dfe0e1"
      }

    }, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
})
AYU

" Vim-sneak
let g:sneak#label = 1 " Emulate easymotion (show label for navigation). Otherwise, it would navigate with ;,

nmap <leader>f <Plug>Sneak_s
nmap <leader>F <Plug>Sneak_S

nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F

nnoremap <F5> :UndotreeToggle<CR>

" vim-sandwich
runtime macros/sandwich/keymap/surround.vim

" Yaml tools
nnoremap <silent> <leader>u :YamlGoToParent<CR>
nnoremap <leader>y :YamlGetFullPath<CR>
nnoremap <leader>Y :YamlGoToKey 

" Buffet
nnoremap <silent> <leader>bb :Bufferlist<CR>
nnoremap <silent> <leader>be :Bufferlist<CR>

" Syntastic
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': ['ruby', 'javascript'],
                           \ 'passive_filetypes': ['puppet'] }

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_javascript_checkers = ['eslint']

let g:syntastic_check_on_open=1
let g:syntastic_eruby_ruby_quiet_messages = {'regex': 'possibly useless use of .* in void context'}

let g:syntastic_cpp_compiler="g++"
let g:syntastic_cpp_compiler_options=" -std=c++11 -Wall"

nnoremap <leader>st :SyntasticToggleMode<CR>

" The order is "reversed" (j is previous, k is next) to look more like
" left <-> right
nnoremap <C-A-k> :bn<CR>
nnoremap <C-A-j> :bp<CR>

" FZF

" Disable preview window since it obscures the file basename
let g:fzf_preview_window = ''
nnoremap <silent> <C-p> :GFiles<CR>
nnoremap <silent> <leader>hh :History<CR>
nnoremap - :Buffers<CR>

" Color schemes
nnoremap <silent> <F6> :call LMBackgroundDark()<CR>
nnoremap <silent> <F7> :call LMBackgroundLight()<CR>

" Make comments actually visible
let g:molokayo#high_contrast#comments = 1

" fugitive
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gb :call GitGuiBlame()<CR>

" vim-buftabline
" Show buffer number next to buffer name
let g:buftabline_numbers = 1

lua << BUFTABLINE
require("buftabline").setup {}
BUFTABLINE
nnoremap <silent> <M-h> :BufPrev<CR>
nnoremap <silent> <M-l> :BufNext<CR>

" With shift - makes for easier buffer deletion (not having to release and press Shift every time)
nnoremap <silent> <M-S-h> :BufPrev<CR>
nnoremap <silent> <M-S-l> :BufNext<CR>

" Easy delete buffer
nnoremap <M-S-d> :BD<CR>

" Same with ctrl-tab
nnoremap <silent> <C-Tab> :BufNext<CR>
nnoremap <silent> <C-S-Tab> :BufPrev<CR>

" Open file from clipboard
nnoremap <leader>ec :call OpenClipboardFile()<CR>

" NERDCommenter - space after comment delimiters
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Use C-/ for toggling comments (for some reason <C-/> is transmitted as <C-_> in vim)
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv

" vim-indentwise
nmap <M-k> <Plug>(IndentWisePreviousLesserIndent)
nmap <M-j> <Plug>(IndentWiseNextLesserIndent)

" These aren't mapped by default
nmap <silent> [- <Plug>(IndentWisePreviousLesserIndent)
nmap <silent> ]- <Plug>(IndentWiseNextLesserIndent)

" vim-matchup
let g:matchup_matchparen_offscreen = {}

if has('nvim')
  " NeoTerm
  let g:neoterm_default_mod = 'horizontal'
  let g:neoterm_automap_keys = '<leader>tt'

  let test#strategy = "neoterm"
  let test#ruby#rspec#executable = 'rspec'
  let test#javascript#jest#executable = 'npm run test'

  nnoremap <silent> <leader>sa :TestSuite<CR>
  nnoremap <silent> <leader>sf :w<CR>:TestFile<CR>
  nnoremap <silent> <leader>sl :w<CR>:TestNearest<CR>
  nnoremap <silent> <leader>S  :w<CR>:TestLast<CR>
  nnoremap <silent> <leader>s <Nop>

  " Automatically enter insert mode in the terminal
  autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufLeave term://* stopinsert

  set inccommand=nosplit
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k

  nnoremap <silent> <leader>sr :call SwitchTestRunner()<CR>
else
  let g:no_turbux_mappings = 1
  let g:turbux_command_rspec  = "$HOME/bin/sp"
  nmap <leader>sf <Plug>SendTestToTmux
  nmap <leader>sl <Plug>SendFocusedTestToTmux
end

nmap <leader><C-s> <Plug>SetTmuxVars

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

function! AckCurrentFile()
  let name = expand('%:t')
  let withoutUnderscore = substitute(name, "^_", "", "")
  let withoutExtension = substitute(withoutUnderscore, "\\..*$", "", "")

  exec "Ack \"". withoutExtension ."\""
endfunction

function! OpenClipboardFile()
  let path=system("xsel -bo")

  let stripped_path = substitute(path, '\n\+$', '', '')

  if filereadable(stripped_path)
    exec("e ". stripped_path)
  else
    echo "File"
    echo "  ". stripped_path
    echo "does not exist!"
  endif
endfunction

let g:prettier#exec_cmd_path = getcwd() . "/node_modules/.bin/prettier-eslint"

function! LMBackgroundLight()
  set background=light

  colorscheme ayu
endfunction

function! LMBackgroundDark()
  colorscheme one

  set background=dark

  if (has("termguicolors"))
    set termguicolors
  endif
endfunction

if !exists('g:config_already_loaded')
  " Do not reset color scheme when reloading the configuration
  let g:config_already_loaded = 1

  call LMBackgroundLight()
endif

" Completion: Used by nvim-typescript
let g:deoplete#enable_at_startup = 1

let g:nvim_typescript#signature_complete = 1
let g:nvim_typescript#max_completion_detail = 25
let g:nvim_typescript#tsimport#template = 'import { %s } from "%s";'

let g:prettier#config#print_width = 120
let g:prettier#config#tab_width = 4
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#single_quote = 'false'
let g:prettier#config#trailing_comma = 'none'

let g:prettier#quickfix_enabled = 0

" Run prettier on all specified files at save.
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue PrettierAsync

nnoremap <leader>si :SortImport<CR>

nnoremap <leader>gg :LazyGit<CR>

nunmap s
nunmap S

lua << LEAP
  require('leap').add_default_mappings()
LEAP
