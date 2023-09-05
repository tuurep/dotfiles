colorscheme goodnight

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
set mousescroll=ver:1,hor:1 " Two-finger scroll on trackpad distance per scroll event (row, col)
set laststatus=1 " Don't show statusline unless there are 2 or more windows
set statusline=%f\ %r%m
set shortmess+=Ia " I: no intro, a: all sorts of abbreviations
set noshowcmd
set undofile
set confirm
set noswapfile
set number
set noruler
set nowrap

" Search and substitute
set ignorecase " Warning: unwanted in :substitute, but can be disabled with I flag
set smartcase
set gdefault " :substitute g is on by default - adding g will instead toggle it off

" This helps gx (open url in browser) to get the full url right
" See: https://vi.stackexchange.com/questions/2801/how-can-i-make-gx-recognise-full-urls-in-vim
let g:netrw_gx="<cWORD>"

" :vsplit and :split
set splitright
set splitbelow

" Global indent settings (see ~/.config/nvim/ftplugin for filetype-specific)
set shiftwidth=4
set softtabstop=4
set expandtab

" junegunn/vim-plug
call plug#begin('~/.config/nvim/vim-plug')

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Pope
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" Open files in last edit position
Plug 'farmergreg/vim-lastplace'

" For mappings "dp" "dpp" and "dP"
Plug 'inkarkat/vim-ReplaceWithRegister'

" Edit registers (especially macros) with :Re <register>
Plug 'tuurep/registereditor'

" Nonlinear undo history access
Plug 'mbbill/undotree'
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_HighlightChangedWithSign = 0

" Toggle live preview in browser with <leader>gp in markdown files (keymap at ftplugin/markdown.vim)
" Forked from iamcco/markdown-preview.nvim to make some small changes
" To be replaced with a less heavy alternative (most likely jannis-baum/vivify)
Plug 'tuurep/markdown-preview.nvim', { 'do': './build-hook.sh' }

" .tex-files - Compile: <leader>gc View pdf: <leader>gv Toggle error box: <leader>ge
Plug 'lervag/vimtex'

" Send lines to target window/pane to execute (like python shell)
Plug 'jpalardy/vim-slime'
let g:slime_target = "tmux"
let g:slime_no_mappings = 1 " disable default mappings

" I don't even use this but it's nicer than netrw
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'

call plug#end()
