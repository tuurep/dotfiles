" tommcdo/nowchangethat but hamfisted directly to my configs
" Also I hate the name Now Change That (Sorry About That)

" Would be nice if opfunc could be set to a lua anonymous func, follow:
" https://github.com/neovim/neovim/issues/14157

" Todo: might add count to linewise:
"       replace each line with last inserted
"       (what happens if multiline insertion?)

function! s:repeat_insert(type)
    if a:type ==# "line"
        execute "normal! '[V']c\<C-A>\<Esc>"
    else
        execute "normal! `[v`]c\<C-A>\<Esc>"
    endif
endfun

nnoremap <silent> c.  :set<Space>opfunc=<SID>repeat_insert<CR>g@
nnoremap <silent> c.. :set<Space>opfunc=<SID>repeat_insert<CR>g@_
nmap c: c.$
