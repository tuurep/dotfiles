-- shorthands
local o, g, opt = vim.o, vim.g, vim.opt
local autocmd = vim.api.nvim_create_autocmd
local map = vim.keymap.set

-- Should this be on or no?
-- https://github.com/neovim/neovim/commit/2257ade3dc2daab5ee12d27807c0b3bcf103cd29
vim.loader.enable()

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
o.statusline = "%t %r%m"
o.showcmd = false
o.ruler = false
o.number = true
o.wrap = false

o.undofile = true
o.confirm = true
o.swapfile = false

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

require("conf.keymaps")

-- folke/lazy.nvim
local plugins = {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("conf.treesitter")
        end,
        event = "BufReadPre"
    },

    -- Open files in last edit position
    { "farmergreg/vim-lastplace", lazy = false },

    -- netrw replacement
    {
        "justinmk/vim-dirvish",
        config = function()
            map("n", "<C-PageUp>", "<Plug>(dirvish_up)")
        end,
        lazy = false
    },

    { "tpope/vim-repeat", keys = "." },

    {
        "tpope/vim-surround",
        keys = {
            { "cs" }, { "cS" }, { "ds" }, { "ys" }, { "yS" },
            { "S", mode = "x" }, { "gS", mode = "x" },
            { "<C-g>", mode = "i" }, { "<C-s>", mode = "i" }
        }
    },

    {
        "numtostr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
        keys = {
            { "gc", mode = {"n", "x"} },
            { "gb", mode = {"n", "x"} }
        }
    },

    -- Align lines by character
    {
	"tommcdo/vim-lion",
        keys = {
            { "gl", mode = {"n", "x"} },
            { "gL", mode = {"n", "x"} }
        }
    },

    -- Exchange operator
    {
        "tuurep/vim-exchange", -- tommcdo/vim-exchange fork
        keys = {
            { "cx" },
            { "X", mode = {"x"} },
            { "cX", "cx$", remap = true },
            { "c<C-x>", "0cx$", remap = true } -- c<C-x> not dot-repeatable...
        }                                      -- but that would be extremely niche
    },

    -- 2-character f and a bit of an overhaul of fFtT,;
    -- Todo + keep an eye: remove prompt:
    --      https://github.com/justinmk/vim-sneak/issues/300
    {
	"justinmk/vim-sneak",
	keys = {
            { "s", mode = {"n", "x"} },
            { "S", mode = {"n", "x"} },
            { "z", mode = "o" },
            { "Z", mode = "o" },
            { "f", "<Plug>Sneak_f", mode = {"n", "x", "o"} },
            { "F", "<Plug>Sneak_F", mode = {"n", "x", "o"} },
            { "t", "<Plug>Sneak_t", mode = {"n", "x", "o"} },
            { "T", "<Plug>Sneak_T", mode = {"n", "x", "o"} },
            { ",", "<Plug>Sneak_;", mode = {"n", "x", "o"} },
            { ";", "<Plug>Sneak_,", mode = {"n", "x", "o"} }
	},
    },

    -- Go up/down until hitting an empty column
    {
        "haya14busa/vim-edgemotion",
        keys = {
            { "<leader>j", "<Plug>(edgemotion-j)", mode = {"n", "x", "o"} },
            { "<leader>k", "<Plug>(edgemotion-k)", mode = {"n", "x", "o"} }
        }
    },

    -- Like a delete and paste in one but doesn't mess up registers
    {
        "inkarkat/vim-ReplaceWithRegister",
        keys = {
            { "dp", "<Plug>ReplaceWithRegisterOperator" },
            { "dpp", "<Plug>ReplaceWithRegisterLine" },
            { "dP", "<Plug>ReplaceWithRegisterLine", remap=true }
        }
    },

    -- Edit registers (especially macros) with :R <register>
    { "tuurep/registereditor", cmd = "RegisterEdit" },

    -- Nonlinear undo history access
    {
        "tuurep/undotree", -- mbbill/undotree fork
        config = function()
            g.undotree_SetFocusWhenToggle = 1
            g.undotree_HighlightChangedWithSign = 0
            g.undotree_ShortIndicators = 1
            g.undotree_HelpLine = 0

            g.Undotree_CustomMap = function()
                local b = {buffer=0}
                map("n", "<C-q>", "<Plug>UndotreeClose", b)
                map("n", "U", "<Plug>UndotreeRedo", b)
                map("n", "J", "<Plug>UndotreePreviousSavedState", b)
                map("n", "K", "<Plug>UndotreeNextSavedState", b)
                map("n", "<Tab>", "/", b)
                map("n", "C", "<Nop>", b)
            end
        end,

        keys = { {"<leader>u", ":UndotreeToggle<cr>", silent=true} }
    },

    -- To be replaced with a less heavy alternative (most likely jannis-baum/vivify)
    {
        "tuurep/markdown-preview.nvim",
        build = "yarn install && yarn build && cd app && yarn install",
        ft = "markdown"
    },

    -- Compile and view TeX, atm better syntax highlighting than treesitter
    { "lervag/vimtex", ft = "tex" },
}

local lazy_config = require("conf.lazy")
require("lazy").setup(plugins, lazy_config)
