" Removes the grey first column, maybe it was set somewhere in fern plugin?
hi clear SignColumn

setlocal nonumber

" Swap these default mappings (maybe change mark later)
nmap <buffer> - <Plug>(fern-action-leave)
nmap <buffer> <BS> <Plug>(fern-action-mark)
