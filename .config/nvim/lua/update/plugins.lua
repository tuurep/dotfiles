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
    "tuurep/mini.operators",      -- echasnovski/mini.operators fork
    "tuurep/mini.tpopesurround",  -- echasnovski/mini.surround fork
    "numtostr/Comment.nvim",
    "echasnovski/mini.splitjoin",
    "tuurep/vim-lion",            -- tommcdo/vim-lion fork
    "echasnovski/mini.move",
    "justinmk/vim-sneak",
    "haya14busa/vim-edgemotion",

    -- Textobjects stuff
    "chaoren/vim-wordmotion", -- rework word delimiters for w b e ge iw aw
    "echasnovski/mini.ai",
    "nvim-treesitter/nvim-treesitter-textobjects",

    -- Nonlinear undo history access
    "tuurep/undotree", -- mbbill/undotree fork

    -- Edit registers (especially macros) with :R[egisterEdit] <register>
    "tuurep/registereditor",

    -- Filetypes:
    "jannis-baum/vivify.vim", -- markdown preview
    "lervag/vimtex",
    "justinmk/vim-dirvish"    -- netrw replacement
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
