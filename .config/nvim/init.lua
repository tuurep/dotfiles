-- shorthands
local o, g, opt = vim.o, vim.g, vim.opt
local autocmd = vim.api.nvim_create_autocmd

-- WIP
-- autocmd({"BufEnter"}, {
--     callback = function()
--         local bufname = vim.fn.expand("%")
--         if vim.fn.isdirectory(bufname) == 1 then
--             vim.cmd.bwipeout()
--             print(bufname .. " is a directory")
--         end
--     end
-- })

vim.cmd.colorscheme("goodnight")

-- Disable autowraps and comment continuations,
-- and prevent /usr/share/nvim/runtime/ftplugins overriding them
autocmd({"FileType"}, {
    callback = function()
        if vim.bo.filetype  ~= "gitcommit" then
            opt.formatoptions:remove({"f", "c", "r", "o"})
        end
    end
})

opt.shortmess:prepend("Ia")

o.clipboard = "unnamedplus"
o.guicursor = "a:block"
o.mousescroll = "ver:1,hor:1"

o.laststatus = 1
o.statusline = "%f  %r%m"
o.showcmd = false
o.ruler = false
o.number = true
o.wrap = false

o.undofile = true
o.confirm = true
o.swapfile = true

-- Search and substitute
o.ignorecase = true -- Warning: unwanted in :substitute, but can be disabled with I flag
o.smartcase = true
o.gdefault = true -- substitute g is on by default - adding g will instead toggle it off

-- :vsplit and :split
o.splitright = true
o.splitbelow = true

-- Global indent settings (see ~/.config/nvim/ftplugin for filetype-specific)
o.shiftwidth = 4
o.softtabstop = 4
o.expandtab = true

-- <leader> is <Space>
vim.keymap.set({"n", "x", "o"}, "<Space>", "<Nop>")
g.mapleader = " "

-- folke/lazy.nvim
local lazy_config = require("lazy-config")

local plugins = {
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

    -- Open files in last edit position
    "farmergreg/vim-lastplace",

    -- Pope
    "tpope/vim-repeat",
    "tpope/vim-surround",

    {
        "numtostr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end
    },

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
        "tuurep/undotree", -- mbbill/undotree fork
        config = function()
            vim.g.undotree_SetFocusWhenToggle = 1
            vim.g.undotree_HighlightChangedWithSign = 0
            vim.g.undotree_ShortIndicators = 1
            vim.g.undotree_HelpLine = 0
        end
    },

    -- To be replaced with a less heavy alternative (most likely jannis-baum/vivify)
    {
        "tuurep/markdown-preview.nvim",
        build = "yarn install && yarn build && cd app && yarn install"
    },

    -- Compile and view TeX, atm better syntax highlighting than treesitter
    "lervag/vimtex",
}

require("lazy").setup(plugins, lazy_config)
