colorscheme goodnight

" Disable autowraps and comment continuations,
" and prevent /usr/share/nvim/runtime/ftplugins overriding them
autocmd FileType * if &filetype != "gitcommit"
    \ | set fo-=t fo-=c fo-=r fo-=o
    \ | endif

" Preferences
set clipboard=unnamedplus
set guicursor=a:block
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

" <leader> is <Space>
map <Space> <Nop>
let g:mapleader=" "

" folke/lazy.nvim
lua <<EOF
local lazy_config = require("lazy-config")

local plugins = {
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

    -- Open files in last edit position
    "farmergreg/vim-lastplace",

    -- Pope
    "tpope/vim-repeat",
    "tpope/vim-commentary",
    "tpope/vim-surround",

    -- Align lines by character
    "tommcdo/vim-lion",

    -- Exchange operator
    "tuurep/vim-exchange", -- tommcdo/vim-exchange fork

    -- 2-character f and a bit of an overhaul of fFtT,;
    -- Todo + keep an eye: remove prompt:
    --      https://github.com/justinmk/vim-sneak/issues/300
    "justinmk/vim-sneak",

    -- Like a delete and paste in one but doesn't mess up registers
    "inkarkat/vim-ReplaceWithRegister",

    -- Edit registers (especially macros) with :R <register>
    "tuurep/registereditor",

    -- Nonlinear undo history access
    {
        "mbbill/undotree",
        config = function()
            vim.g.undotree_SetFocusWhenToggle = 1
            vim.g.undotree_HighlightChangedWithSign = 0
        end
    },

    -- To be replaced with a less heavy alternative (most likely jannis-baum/vivify)
    {
        "tuurep/markdown-preview.nvim",
        build = "yarn install && yarn build && cd app && yarn install"
    },

    -- Compile and view TeX, atm better syntax highlighting than treesitter
    "lervag/vimtex",

    -- Send lines to target window/pane to execute (like python shell)
    {
        "jpalardy/vim-slime",
        config = function()
            vim.g.slime_target = "tmux"
            vim.g.slime_no_mappings = 1 -- disable default mappings
        end
    },

    -- I don't even use this but it's nicer than netrw
    "lambdalisue/fern.vim",
    "lambdalisue/fern-hijack.vim"
}

require("lazy").setup(plugins, lazy_config)
EOF
