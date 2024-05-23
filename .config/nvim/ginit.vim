" This font doesn't have ligatures.
GuiFont Cascadia Mono:h12

" This disables Gui tabs that prevent buffer tabs to be shown.
GuiTabline 0

set guifont=Cascadia\ Mono:h12

let s:fontsize = 12

function! AdjustFontSize(amount)
  let s:fontsize = s:fontsize+a:amount
  :execute "GuiFont! Cascadia Mono:h" . s:fontsize
endfunction

function! ResetFontSize()
  let s:fontsize = 12
  :execute "GuiFont! Cascadia Mono:h" . s:fontsize
endfunction

noremap <C-=> :call AdjustFontSize(1)<CR>
noremap <C--> :call AdjustFontSize(-1)<CR>
noremap <C-0> :call ResetFontSize()<CR>

inoremap <C-=> <C-o>:call AdjustFontSize(1)<CR>
inoremap <C--> <C-o>:call AdjustFontSize(-1)<CR>
inoremap <C-0> <C-o>:call ResetFontSize()<CR>

noremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
noremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
inoremap <C-ScrollWheelUp> <C-o>:call AdjustFontSize(1)<CR>
inoremap <C-ScrollWheelDown> <C-o>:call AdjustFontSize(-1)<CR>
