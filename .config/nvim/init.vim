colorscheme goodnight

set title
set titlestring=nvim\ %t\ %m

" Don't highlight matchpairs
let g:loaded_matchparen = 1
" Don't let vimtex do that either
let g:vimtex_matchparen_enabled = 0

" Disable autowraps and comment continuations, 
" and prevent /usr/share/nvim/runtime/ftplugins overriding them
autocmd FileType * if &filetype != "gitcommit"
    \ | set fo-=t fo-=c fo-=r fo-=o
    \ | endif

" Preferences
set mouse=a
set mousescroll=ver:1,hor:1 " Two-finger scroll on trackpad distance per scroll event (row, col)
set guicursor=a:block
set laststatus=1 " Don't show statusline unless there are 2 or more windows
set shortmess+=I " Don't display intro message (:h :intro) when opening empty buffer
set undofile
set confirm
set noswapfile
set nobackup
set number
set noruler
set nowrap
set cursorline " For LineNumber highlighting only, with my colorscheme setting (no bg highlight for line)
set gdefault " :substitute g is on by default - adding g will instead toggle it off
set noerrorbells

" This helps gx (open url in browser) to get the full url right
" See: https://vi.stackexchange.com/questions/2801/how-can-i-make-gx-recognise-full-urls-in-vim
let g:netrw_gx="<cWORD>"

" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab

" ======================== KEYMAPS ========================
" Map leader to space
nnoremap <Space> <Nop>
let mapleader=" "
" Disable keys that:
"   1. can interfere with other settings
"   2. I want to repurpose later 
"   3. are annoying
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <C-h> <Nop>
nnoremap <C-l> <Nop>
noremap + <Nop>
noremap - <Nop>
noremap <BS> <Nop>
noremap <PageDown> <Nop>
noremap <PageUp> <Nop>
noremap! <PageDown> <Nop>
noremap! <PageUp> <Nop>

" Tab to search because / sucks in Finnish layout
" Side effect: Ctrl+i is understood as Tab in terminals, so "go forward in jump list" breaks
" Map that to Ctrl+p which is free
" NOTE: NeoVim can differentiate between these, but alacritty is still implementing, follow here:
" https://github.com/alacritty/alacritty/issues/3101
" Remove the Ctrl+P map in the future
nnoremap <Tab> /
nnoremap <S-Tab> ?
nnoremap <C-p> <C-i>
" Start a substitute command without finger gymnastics:
nnoremap <leader><Tab> :%s/
" Clear lingering command msg
nnoremap <Enter> :echo ''<cr>
" Show full path of current file (home as tilde)
nnoremap <leader><Enter> :echo substitute(expand('%:p'), $HOME, '~', '')<cr>
" Experimental:
noremap  ¤ J
noremap  g¤ gJ
nnoremap <C-d> 0D
nnoremap å o<Esc>
nnoremap Å O<Esc>
" Comfortable movement keys:
noremap <C-j> <C-d>
noremap <C-k> <C-u>
noremap H ^
noremap J }
noremap K {
noremap L $
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
" Scroll window but keep cursor where it is
nnoremap <M-h> zh
nnoremap <M-j> <C-e>
nnoremap <M-k> <C-y>
nnoremap <M-l> zl
" One-handed save and quit 
nnoremap <C-s> :w<cr>
inoremap <C-s> <C-o>:w<cr>
nnoremap <C-q> :q<cr>
inoremap <C-q> <C-o>:q<cr>
" Open and hop into undotree
nnoremap <leader>u :UndotreeToggle<cr>
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_HighlightChangedWithSign = 0
" See highlight group/"capture" under cursor (requires treesitter playground plugin)
nmap <leader>e :TSHighlightCapturesUnderCursor<cr>
" Overwrite default s:
nmap s <Plug>ReplaceWithRegisterOperator
nmap ss <Plug>ReplaceWithRegisterLine
xmap s <Plug>ReplaceWithRegisterVisual
nmap S s$
" System clipboard easy:
nmap <leader>y "+y
nmap <leader>Y "+Y
xmap <leader>y "+y
nmap <leader>p "+p
nmap <leader>P "+P
xmap <leader>p "+p
nmap <leader>s "+s
nmap <leader>S "+S
xmap <leader>s "+s
nmap <leader>d "+d
nmap <leader>D "+D
xmap <leader>d "+d
nmap <leader>c "+c
nmap <leader>C "+C
xmap <leader>c "+c
" Fern maps: _ for :Explore style
nnoremap <leader>- :Fern %:h -drawer -reveal=%<cr>
nnoremap <leader>_ :Fern %:h -reveal=%<cr>
" (Key below esc) Vim-style maps (non-default) - {count}§§, §{motion}
let g:slime_no_mappings = 1
xmap § <Plug>SlimeRegionSend
nmap § <Plug>SlimeMotionSend
nmap ½ §$
nmap §§ <Plug>SlimeLineSend
nmap <leader>§ <Plug>SlimeConfig
" ==================== END OF KEYMAPS =====================

" ============== PLUGINS: junegunn/vim-plug ===============
call plug#begin('~/.config/nvim/plugged')

Plug 'jesseleite/vim-noh'

Plug 'inkarkat/vim-ReplaceWithRegister'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" Without this, vimmers can't dot-repeat keymaps that come from plugins
Plug 'tpope/vim-repeat'

" Vim-like binds to comment lines with {count}gcc, gc{motion}
Plug 'tpope/vim-commentary'

" Nonlinear undo history access
Plug 'mbbill/undotree'

" netrw replacement: project drawer/file explorer
" hijack makes fern the 'default' like when running vim dot
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'

" .tex-files - Compile: <leader>gc View pdf: <leader>gv Toggle error box: <leader>ge
Plug 'lervag/vimtex'

" Toggle live preview in browser with <leader>gp in markdown files (keymap at ftplugin/markdown.vim)
" Forked from iamcco/markdown-preview.nvim to make some small changes
Plug 'tuurep/markdown-preview.nvim', { 'do': './build-hook.sh' }

" Send lines to target window/pane to execute (like python shell)
let g:slime_target = "tmux"
Plug 'jpalardy/vim-slime'

call plug#end()
