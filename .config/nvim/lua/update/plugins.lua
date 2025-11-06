-- nvim -l plugins.lua

local paq = require("paq") {
    "savq/paq-nvim", -- Updates self

    -- Syntax highlighting
    "nvim-treesitter/nvim-treesitter",

    -- Essential:
    "tpope/vim-repeat",
    "farmergreg/vim-lastplace", -- remember last cursor position
    "Darazaki/indent-o-matic",  -- change tab width when working on other peoples' files

    -- Operators:
    "tuurep/mini.operators",      -- nvim-mini/mini.operators fork
    "tuurep/mini.tpopesurround",  -- nvim-mini/mini.surround fork
    "numtostr/Comment.nvim",
    "nvim-mini/mini.splitjoin",
    "tuurep/vim-lion",            -- tommcdo/vim-lion fork
    "nvim-mini/mini.move",
    "haya14busa/vim-edgemotion",
    -- { "tuurep/vim-sneak", branch = "dev" }, -- justinmk/vim-sneak fork

    -- Textobjects stuff
    "nvim-treesitter/nvim-treesitter-textobjects",
    -- "chaoren/vim-wordmotion", -- rework word delimiters for w b e ge iw aw
    -- "tuurep/mini.ai",         -- nvim-mini/mini.ai fork

    -- Visual block insert preview workaround until it's added in core
    -- https://github.com/neovim/neovim/issues/20329
    "phanen/vbi.nvim",

    -- Nonlinear undo history access
    "tuurep/undotree", -- mbbill/undotree fork

    -- Edit/view register contents in a buffer
    -- "tuurep/registereditor",

    -- Filetypes:
    "jannis-baum/vivify.vim", -- markdown preview
    "lervag/vimtex",
    "justinmk/vim-dirvish",   -- netrw replacement
}

vim.api.nvim_create_autocmd("User", {
    pattern = "PaqDoneSync",
    callback = function()
        io.write("\n")
        os.exit()
    end
})

paq:sync()

-- Wait indefinitely, allowing async paq.sync to finish
vim.fn.wait(-1, false)
