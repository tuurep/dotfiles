vim.diagnostic.enable(false)

-- List of configs in nvim-lspconfig:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

-- List of LSPs on Arch:
-- https://wiki.archlinux.org/title/Language_Server_Protocol

vim.lsp.enable({
    "basedpyright",  -- AUR:    basedpyright
    "clangd",        -- pacman: clang
    "lua_ls",        -- pacman: lua_language_server
    "rust_analyzer", -- pacman: rust-analyzer
    "ts_ls"          -- pacman: typescript_language_server
})
