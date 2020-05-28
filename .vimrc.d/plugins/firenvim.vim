let g:firenvim_config = {
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'never',
        \ },
    \ }
\ }

let fc = g:firenvim_config['localSettings']
let fc['.*'] = {
\   'selector': 'textarea',
\   'takeover': 'never'
\ }

if exists('g:started_by_firenvim')
  set laststatus=0
  let g:buftabline_show=0
  startinsert

  au TextChanged * ++nested write
  au TextChangedI * ++nested write
endif
