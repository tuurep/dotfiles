" Overwrite regular s
" New use: use s, ss and S similarly as c and d
" to replace motion target with default register contents
" The text that was replaced will go to default register ("")
" the same way as to how c, d and x work.

nnoremap <silent> s :set opfunc=SwapRegisterSubstitute<CR>g@
vnoremap <silent> s p
nmap ss s_
nmap S s$

function! SwapRegisterSubstitute(type, ...)
    if a:0
        silent exe "normal! `<" . a:type . "`>p"
    elseif a:type == 'line'
        silent exe "normal! '[V']p"
    elseif a:type == 'block'
        silent exe "normal! `[\<C-V>`]p"
    else
        silent exe "normal! `[v`]p"
    endif
endfunction

" TODO: fix system clipboard variants:
" Do I need a new function, or tweaks to above?
" nmap <leader>s "+s
" nmap <leader>S "+S
" xmap <leader>s "+s
