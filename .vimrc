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

" Preferences
set shortmess+=I " Don't display intro message (:h :intro) when opening empty buffer
set hidden
set confirm
set noswapfile
set showcmd
set number
set noruler
set nowrap
set sidescroll=1
set wildmenu " Tab completion menu
set cursorline " For LineNumber highlighting only, with my colorscheme setting (no bg highlight for line)
set hlsearch
set incsearch
set mouse=a " Purpose: be able to scroll with mouse

" Indentation settings for using 4 spaces instead of tabs.  
" Do not change 'tabstop' from its default value of 8 with this setup.  
set shiftwidth=4 
set softtabstop=4 
set expandtab

" Undo persistence: buffer can be closed and previous undotree can be used on reopen
set undodir=~/.vim/undofiles
set undofile

" Use netrw as a filetree viewer on the left side (Using :Lex)
let g:netrw_banner=0
let g:netrw_winsize=18 " Percentage
let g:netrw_liststyle=3 " Tree-view option
let ghregex='\(^\|\s\s\)\zs\.\S\+' " netrw gh works by appending and removing this regex to list_hide
let g:netrw_list_hide=ghregex " Purpose: by default hide dotfiles, gh to toggle

"--- KEYMAPS ---
" Unify with behavior of C and D, this is even recommended in the :h manual
:map Y y$
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
" Netrw maps
" TOGGLE :Lex
nnoremap <leader><TAB> :Lex<cr>
" --- END OF KEYMAPS ---

" Plugins using vim-plug
call plug#begin('~/.vim/plugged')

" .tex-files - Compile: \ll View pdf: \lv Toggle error box: \le
Plug 'lervag/vimtex'

" Toggle live preview in browser with <leader>p in markdown files (keymap at ftplugin/markdown.vim)
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Saner search highlight: clear highlight on movement
Plug 'haya14busa/is.vim'

call plug#end()
