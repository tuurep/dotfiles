-- shorthands
local o, g, opt = vim.o, vim.g, vim.opt
local autocmd = vim.api.nvim_create_autocmd

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
opt.fillchars:prepend("eob:󰧟")

o.clipboard = "unnamedplus"
o.guicursor = "a:block"
o.mousescroll = "ver:1,hor:1"

o.laststatus = 1
o.statusline = "%t %r%m"

o.timeout = false
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

-- Globals for plugins
g.lion_prompt = "Pattern: "
g.lion_squeeze_spaces = 1

g.undotree_SetFocusWhenToggle = 1
g.undotree_HighlightChangedWithSign = 0
g.undotree_ShortIndicators = 1
g.undotree_HelpLine = 0

-- Plugins
require("paq") {
    "savq/paq-nvim", -- Updates self

    -- Syntax highlighting
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

    -- Essential:
    "farmergreg/vim-lastplace", -- Open files in last edit position
    "tpope/vim-repeat",         -- Dot-repeat mappings from plugins too

    -- Word delimiters rework:
    "chrisgrieser/nvim-spider",           -- w, b, e, ge
    "chrisgrieser/nvim-various-textobjs", -- iw, aw
                                          -- (and more stuff, see keymaps)
    -- Operators:
    "tpope/vim-surround",
    "numtostr/Comment.nvim",
    "justinmk/vim-sneak",
    "tuurep/vim-lion",          -- tommcdo/vim-lion fork
    "tuurep/vim-exchange",      -- tommcdo/vim-exchange fork
    "haya14busa/vim-edgemotion",
    "inkarkat/vim-ReplaceWithRegister",

    -- Nonlinear undo history access
    "tuurep/undotree", -- mbbill/undotree fork

    -- Edit registers (especially macros) with :R[egisterEdit] <register>
    "tuurep/registereditor",

    -- Filetypes:
    "jannis-baum/vivify.vim", -- markdown preview
    "lervag/vimtex",
    "justinmk/vim-dirvish",   -- netrw replacement
}

-- Larger plugin configurations:
require("conf.treesitter")
require("various-textobjs").setup({notifyNotFound = false})
require("Comment").setup()

-- Disable builtin plugins
g.loaded_netrwPlugin = 0
-- g.loaded_matchparen = 0 -- Disabling matchparen breaks vim-sneak highlight, see:
                           -- https://github.com/justinmk/vim-sneak/issues/305
