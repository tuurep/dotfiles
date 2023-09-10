require'nvim-treesitter.configs'.setup({
    ensure_installed = "all",
    sync_install = false,
    auto_install = false,
    ignore_install = { "comment" },

    highlight = {
        enable = true,
        disable = {
            "latex", -- vimtex better atm
            "diff"   -- doesn't work in undotree
        },
        additional_vim_regex_highlighting = { "python" }
    },

    indent = {
        enable = false
    }
})
