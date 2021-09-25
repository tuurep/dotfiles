set nocompatible " No backward compatibility with Vi
filetype indent plugin on " To allow filetype-specific indenting / plugins
syntax on

set title
set titlestring=vim\ %t\ %m

" Extended built-in support for %
packadd! matchit

" Don't highlight matchpairs
let g:loaded_matchparen = 1
" Don't let vimtex do that either
let g:vimtex_matchparen_enabled = 0

" Don't autowrap on textwidth. See this if there's issues: https://vi.stackexchange.com/questions/9366/set-formatoptions-in-vimrc-is-being-ignored
" (Some builtin ftplugins will go on to set formatoptions again, one is dot vim)
" (see :set fo?)
set formatoptions-=tc

" The typical indenting settings and 'normal' backspace behavior (insert mode)
set autoindent
set backspace=indent,eol,start

colorscheme goodnight

" Most important: scrolling and resizing splits by mouse
set mouse=a

" Mouse support setup:
" Fix mouse for Alacritty:
set ttymouse=sgr
" Fix mouse inside tmux session:
if &term =~ "tmux*"
    set ttymouse=xterm2
endif

" TODO: Issues with auto reload (on BufEnter,FocusGained)
" To update manually when file was modified elsewhere, do :checkt[ime]
set autoread

" Preferences
set shortmess+=I " Don't display intro message (:h :intro) when opening empty buffer
set shortmess-=S " Show count of search results while searching (remove S from default, see :h shortmess)
set hidden
set confirm
set noswapfile
set nobackup
set showcmd
set number
set noruler
set nowrap
set sidescroll=1
set wildmenu " Tab completion menu
set cursorline " For LineNumber highlighting only, with my colorscheme setting (no bg highlight for line)
set hlsearch
set incsearch
set ignorecase
set smartcase " No ignorecase if Uppercase char present in search
set nrformats-=octal " For Ctrl+a and Ctrl+x increment/decrement, octal format can lead to some confusion
set noerrorbells

" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab

" Undo persistence: buffer can be closed and previous undotree can be used on reopen
set undodir=~/.vim/undofiles
set undofile

" ======================== KEYMAPS ========================
" Map leader to space
nnoremap <Space> <Nop>
let mapleader=" "
" Disable keys that can interfere with other settings OR that I later want to repurpose
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <C-h> <Nop>
nnoremap <C-l> <Nop>
noremap + <Nop>
noremap - <Nop>
noremap <BS> <Nop>
" Unify with behavior of C and D, the reason this is not default is said to be a bug in Vi editor
map Y y$
" Quicksource vimrc
nnoremap <leader>R :source ~/.vimrc<cr>
" Clear lingering command msg
nnoremap <Enter> :echo ''<cr>
" Show full path of current file (home as tilde)
nnoremap <leader><Enter> :echo substitute(expand('%:p'), $HOME, '~', '')<cr>
" Experimental:
noremap  ¤ J
noremap  g¤ gJ
nnoremap <C-d> 0D
nnoremap <C-c> 0C
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
" Open and hop into undotree
nnoremap <leader>u :UndotreeToggle<cr>
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_HighlightChangedWithSign = 0
" System clipboard easy:
nmap <leader>y "+y
nmap <leader>Y "+Y
xmap <leader>y "+y
nmap <leader>p "+p
nmap <leader>P "+P
xmap <leader>p "+p
" Window resizing using arrow keys in normal mode
" Windows can grow from either side depending on their position
" <Right> extends window to the right (or left), <Left> extends window to down (or up)
" ...with Shift to shrink
" TODO: these are a mess, be on the lookout for better, directional window resizing maps
nnoremap <Right> <C-W>>
nnoremap <Left> <C-W>+
nnoremap <S-Right> <C-W><
nnoremap <S-Left> <C-W>-
" Fzf maps
nnoremap <leader>gf :FZF<cr>
nnoremap <leader>gF :FZF ~<cr>
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
call plug#begin('~/.vim/plugged')

" Saner search highlight: clear highlight on movement
Plug 'romainl/vim-cool'

" Without this, vimmers can't dot-repeat keymaps that come from plugins
Plug 'tpope/vim-repeat'

" Vim-like binds to comment lines with {count}gcc, gc{motion}
Plug 'tpope/vim-commentary'

" Get commands to surround text with {new}
" replace: cs{old}{new} - delete: cs{old} - add: y{motion}{new}
Plug 'tpope/vim-surround'

" Nonlinear undo history access
Plug 'mbbill/undotree'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" netrw replacement: project drawer/file explorer
" hijack makes fern the 'default' like when running vim dot
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'

" 'frecency'-directory switching with :Z <substring-of-path>
Plug 'nanotee/zoxide.vim'

" .tex-files - Compile: <leader>gc View pdf: <leader>gv Toggle error box: <leader>ge
Plug 'lervag/vimtex'

" Toggle live preview in browser with <leader>p in markdown files (keymap at ftplugin/markdown.vim)
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Send lines to target window/pane to execute (like IPython shell)
let g:slime_target = "tmux"
let g:slime_python_ipython = 1
Plug 'jpalardy/vim-slime'

call plug#end()
