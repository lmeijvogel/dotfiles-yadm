let g:firenvim_config = {
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'always',
        \ },
    \ }
\ }

let fc = g:firenvim_config['localSettings']
let fc['.*'] = { 'selector': 'textarea' }
let fc['.*'] = { 'takeover': 'empty' }
if exists('g:started_by_firenvim')
  set laststatus=0
  let g:buftabline_show=0
endif
