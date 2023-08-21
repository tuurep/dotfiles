" Identify highlight group under cursor
" Shows as
"   (syngroup) -> (what it links to)
" Useful for troubleshooting

function! SynGroup()                                                            
    let l:s = synID(line('.'), col('.'), 1)                                       
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
