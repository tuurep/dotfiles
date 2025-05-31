-- Should this be on or no?
-- https://github.com/neovim/neovim/commit/2257ade3dc2daab5ee12d27807c0b3bcf103cd29
vim.loader.enable()

vim.cmd.colorscheme("goodnight")
require("keymaps")

if vim.env.TEXTERN == "1" then
    vim.o.title = true
    vim.o.titlestring = "[Textern] %m"
else
    require("dynamic-titlestring")
end

-- Disable autowraps and comment continuations,
-- and prevent /usr/share/nvim/runtime/ftplugins overriding them
vim.api.nvim_create_autocmd({"FileType"}, {
    callback = function()
        if vim.bo.filetype  ~= "gitcommit" then
            vim.opt.formatoptions:remove({"t", "f", "c", "r", "o"})
        end
    end
})

vim.opt.shortmess:append("Ia")
vim.opt.fillchars:append("eob:󰧟") -- nf-md-circle_small

vim.o.clipboard = "unnamedplus"
vim.o.guicursor = "a:block"
vim.o.mouse = ""

vim.opt.jumpoptions:append("view")

vim.o.laststatus = 1
vim.o.statusline = "%t %r%m"

vim.o.timeout = false
vim.o.showcmd = false
vim.o.ruler = false
vim.o.number = true

vim.opt.scrolloff = 6

vim.o.textwidth = 90
vim.o.wrap = false

vim.o.undofile = true
vim.o.confirm = true
vim.o.swapfile = false

-- Search and substitute
vim.o.ignorecase = true -- Warning: unwanted in :substitute, but can be disabled with I flag
vim.o.smartcase = true
vim.o.gdefault = true -- substitute g is on by default - adding g will instead toggle it off

-- :vsplit and :split
vim.o.splitright = true
vim.o.splitbelow = true

-- Indent settings for new files (otherwise guessed by 'indent-o-matic')
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

-- Globals for plugins
vim.g.lion_prompt = "Pattern: "
vim.g.lion_squeeze_spaces = 1

vim.g["sneak#s_next"] = true     -- f/t/s repeat same key to go forward
vim.g["sneak#use_ic_scs"] = true -- f/t/s ignorecase and smartcase

vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_HighlightChangedWithSign = 0
vim.g.undotree_ShortIndicators = 1
vim.g.undotree_HelpLine = 0

-- Bloat
vim.g.vimtex_syntax_conceal_disable = 1
vim.g.vimtex_mappings_enabled = 0
vim.g.vimtex_imaps_enabled = 0
vim.g.vimtex_matchparen_enabled = 0
vim.g.vimtex_complete_enabled = 0
vim.g.vimtex_doc_enabled = 0
vim.g.vimtex_include_search_enabled = 0
vim.g.vimtex_motion_enabled = 0
vim.g.vimtex_text_obj_enabled = 0
vim.g.vimtex_toc_enabled = 0

-- Plugin setups that aren't related to keymaps
-- (others are in ./lua/keymaps.lua)
require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
        disable = {
            "diff" -- doesn't work in undotree
        },
    },
})
-- Use bash parser for filetype PKGBUILD
vim.treesitter.language.register("bash", "PKGBUILD")

-- Disable builtin plugins
vim.g.loaded_netrwPlugin = 0
-- g.loaded_matchparen = 0 -- Disabling matchparen breaks vim-sneak highlight, see:
                           -- https://github.com/justinmk/vim-sneak/issues/305

-- Where plugins?
-- See ./lua/update/plugins.lua
-- Plugins are only updated with a shell script
