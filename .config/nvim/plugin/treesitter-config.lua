require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    sync_install = false,
    auto_install = false,
    ignore_install = { "comment" },

    highlight = {
        enable = true,
        disable = { "latex" },
        additional_vim_regex_highlighting = { "python" }
    },

    indent = {
        enable = false
    }
}
