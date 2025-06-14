-- nvim -l ts-parsers.lua

require("nvim-treesitter.configs").setup({
    ensure_installed = "all",
    sync_install = true,
    ignore_install = {
        "comment", -- too complicated comment parsing
        "luadoc",  -- very broken and inconsistent, looks best as just comment
        "luap",    -- too complicated regex parsing in lua

        -- With this parser, opening a .tex file takes ~500ms
        -- Favoring vimtex's highlight groups for that reason alone
        "latex"
    }
})

-- Force-load treesitter so that user commands are available
vim.cmd.runtime({"plugin/nvim-treesitter.lua", bang=true})

vim.cmd.TSUpdateSync()
