" 'Features in Vim that no user should have to live without'
set nocompatible
filetype indent plugin on " To allow filetype-specific indenting / plugins
syntax on

" Extended built-in support for %
runtime macros/matchit.vim

" The typical indenting settings and 'normal' backspace behavior (insert mode)
set autoindent
set backspace=indent,eol,start

colorscheme base16-tomorrow-night-mod

" Most important: scrolling and resizing splits by mouse
set mouse=a
" Fix mouse inside tmux session:
if &term =~ "tmux*"
    set ttymouse=xterm2
endif

" Preferences
set shortmess+=I " Don't display intro message (:h :intro) when opening empty buffer
set shortmess-=S " Show count of search results while searching (remove S from default, see :h shortmess)
set hidden
set confirm
set noswapfile
set nobackup
set autoread " Be in sync if file is open in multiple buffers (no prompting, just update)
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

"--- KEYMAPS ---
" Unify with behavior of C and D, this is even recommended in the :h manual
map Y y$
" No help message when pressing ctrl+C
nnoremap <C-c> <silent><C-c>
" Map leader to space
nnoremap <SPACE> <Nop>
let mapleader=" "
" Window resizing using arrow keys in normal mode
" Windows can grow from either side depending on their position
" <Right> extends window to the right (or left), <Left> extends window to down (or up)
" ...with Shift to shrink
nnoremap <Right> <C-W>>
nnoremap <Left> <C-W>+
nnoremap <S-Right> <C-W><
nnoremap <S-Left> <C-W>-
" Disable other arrowkeys in normal mode
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
" Setting working directory mappings
" Set cwd to dir of current file
nnoremap <leader>cd :cd %:h<cr>
" Fzf maps
nnoremap <leader>f :FZF<cr>
nnoremap <leader>F :FZF ~<cr>
" Fern maps: e for :Explore style, -/_ :Lex style from current parent or cwd
nnoremap <leader>e :Fern %:h -reveal=%<cr>
nnoremap <leader>- :Fern %:h -drawer -reveal=%<cr>
nnoremap <leader>_ :Fern . -drawer -reveal=%<cr>
" Vim-style maps (non-default) - {count}<leader>ss, <leader>s{motion}
let g:slime_no_mappings = 1
nmap <C-s> <Plug>SlimeConfig
xmap <leader>s <Plug>SlimeRegionSend
nmap <leader>s <Plug>SlimeMotionSend
nmap <leader>S <leader>s$
nmap <leader>ss <Plug>SlimeLineSend
" --- END OF KEYMAPS ---

" Plugins using 'junegunn/vim-plug'
call plug#begin('~/.vim/plugged')

" Vim-like binds to comment lines with {count}gcc, gc{motion}
Plug 'tpope/vim-commentary'

" Get commands to surround text with {new}
" Replace: cs{old}{new} - Delete: cs{old} - Add: y{motion}{new}
Plug 'tpope/vim-surround'

" Without this, vimmers cannot dot-repeat keymaps that come from plugins
Plug 'tpope/vim-repeat'

" .tex-files - Compile: \ll View pdf: \lv Toggle error box: \le
Plug 'lervag/vimtex'

" Toggle live preview in browser with <leader>p in markdown files (keymap at ftplugin/markdown.vim)
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" netrw replacement: project drawer/file explorer
" hijack makes fern the 'default' like when running vim dot
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'

" Saner search highlight: clear highlight on movement
Plug 'romainl/vim-cool'

" Send lines to target window/pane to execute (like IPython shell)
let g:slime_target = "tmux"
Plug 'jpalardy/vim-slime'

call plug#end()
