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
            opt.formatoptions:remove({"t", "f", "c", "r", "o"})
        end
    end
})

opt.shortmess:prepend("Ia")
opt.fillchars:prepend("eob:󰧟")

o.clipboard = "unnamedplus"
o.guicursor = "a:block"
o.mouse = ""

o.laststatus = 1
o.statusline = "%t %r%m"

o.timeout = false
o.showcmd = false
o.ruler = false
o.number = true

opt.scrolloff = 6

o.textwidth = 80
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

g["sneak#s_next"] = true     -- f/t/s repeat same key to go forward
g["sneak#use_ic_scs"] = true -- f/t/s ignorecase and smartcase

g.undotree_SetFocusWhenToggle = 1
g.undotree_HighlightChangedWithSign = 0
g.undotree_ShortIndicators = 1
g.undotree_HelpLine = 0

g.miniindentscope_disable = true -- Only care about the textobjects and motions (no visuals)

-- Plugins
require("paq") {
    "savq/paq-nvim", -- Updates self

    -- Syntax highlighting
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

    -- Essential:
    "farmergreg/vim-lastplace", -- Open files in last edit position
    "tpope/vim-repeat",         -- Dot-repeat mappings from plugins too

    -- Operators:
    "echasnovski/mini.operators", -- exchange, replacewithregister, sort, duplicate
    "echasnovski/mini.surround",
    "numtostr/Comment.nvim",
    "echasnovski/mini.splitjoin",
    "tuurep/vim-lion",            -- tommcdo/vim-lion fork
    "echasnovski/mini.move",
    "justinmk/vim-sneak",
    "haya14busa/vim-edgemotion",

    -- Textobjects stuff
    "chaoren/vim-wordmotion",       -- Rework word delimiters for w b e ge iw aw
    "echasnovski/mini.ai",          -- Anybracket, anyquote, function, argument
    "echasnovski/mini.indentscope", -- Indent textobject and motions

    -- Nonlinear undo history access
    "tuurep/undotree", -- mbbill/undotree fork

    -- Edit registers (especially macros) with :R[egisterEdit] <register>
    "tuurep/registereditor",

    -- Filetypes:
    "jannis-baum/vivify.vim", -- markdown preview
    "lervag/vimtex",
    "justinmk/vim-dirvish"    -- netrw replacement
}
require("Comment").setup()
require("mini.splitjoin").setup()
require("mini.indentscope").setup({
    options = { indent_at_cursor = false }
})

-- Larger plugin configurations:
require("conf.treesitter")

-- Disable builtin plugins
g.loaded_netrwPlugin = 0
-- g.loaded_matchparen = 0 -- Disabling matchparen breaks vim-sneak highlight, see:
                           -- https://github.com/justinmk/vim-sneak/issues/305
