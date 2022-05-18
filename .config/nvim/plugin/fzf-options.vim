" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
    \ { 'fg':      ['fg', 'Comment'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Normal'],
      \ 'fg+':     ['fg', 'Normal'],
      \ 'bg+':     ['bg', 'Normal'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'Label'],
      \ 'prompt':  ['fg', 'Keyword'],
      \ 'pointer': ['fg', 'Statement'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }
