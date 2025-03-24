" Soft wrap long lines
setlocal wrap linebreak

" Preview file in browser
" Save file to avoid the case where you've just started editing a new file,
" haven't yet saved and may be left thinking that Vivify is hanging
nnoremap <buffer> § <cmd>w<cr><cmd>Vivify<cr>
