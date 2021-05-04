set nocompatible " No backward compatibility with Vi
filetype indent plugin on " To allow filetype-specific indenting / plugins
syntax on

" Extended built-in support for %
packadd! matchit

" Don't highlight matchpairs
let loaded_matchparen = 1

" Don't autowrap on textwidth. See this if there's issues: https://vi.stackexchange.com/questions/9366/set-formatoptions-in-vimrc-is-being-ignored
" (Some builtin ftplugins will go on to set formatoptions again, one is dot vim)
" (see :set fo?)
set formatoptions-=tc

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
" Disable keys that can interfere with other settings
nnoremap <C-c> <Nop>
nnoremap <Space> <Nop>
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
xnoremap s <Nop>
xnoremap S <Nop>
nnoremap K <Nop>
" Map leader to space
let mapleader=" "
" Unify with behavior of C and D, the reason this is not default is said to be a bug in Vi editor
map Y y$
" Comfortable insert mode navigation
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
" Comfortable half-page movement
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>
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
nnoremap <leader>f :FZF<cr>
nnoremap <leader>F :FZF ~<cr>
" Fern maps: _ for :Explore style
nnoremap <leader>- :Fern %:h -drawer -reveal=%<cr>
nnoremap <leader>_ :Fern %:h -reveal=%<cr>
" Open and hop into undotree
nnoremap <leader>u :UndotreeToggle<cr>
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_HighlightChangedWithSign = 0
" Replace regular s with this more useful 'replace with default register content' -operation
" s can be overriden because s = cl and S = cc
nmap s <Plug>(SubversiveSubstitute)
nmap ss <Plug>(SubversiveSubstituteLine)
nmap S <Plug>(SubversiveSubstituteToEndOfLine)
" (Scandinavian layout) Vim-style maps (non-default) - {count}åå, å{motion}
let g:slime_no_mappings = 1
nmap <C-å> <Plug>SlimeConfig
xmap å <Plug>SlimeRegionSend
nmap å <Plug>SlimeMotionSend
nmap Å å$
nmap åå <Plug>SlimeLineSend
" --- END OF KEYMAPS ---

" Plugins using 'junegunn/vim-plug'
call plug#begin('~/.vim/plugged')

" Vim-like binds to comment lines with {count}gcc, gc{motion}
Plug 'tpope/vim-commentary'

" Get commands to surround text with {new}
" Replace: cs{old}{new} - Delete: cs{old} - Add: y{motion}{new}
Plug 'tpope/vim-surround'

" Remove text and put default register content in its place
Plug 'svermeulen/vim-subversive'

" Without this, vimmers can't dot-repeat keymaps that come from plugins
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

" Nonlinear undo history access
Plug 'mbbill/undotree'

" Send lines to target window/pane to execute (like IPython shell)
let g:slime_target = "tmux"
Plug 'jpalardy/vim-slime'

call plug#end()
