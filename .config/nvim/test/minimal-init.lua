-- Minimal config for reproducing problems
--
-- Run as:
--     nvim --clean -nu ~/.config/nvim/test/minimal-init.lua
--
-- Adapted from:
--     https://github.com/neovim/neovim/blob/master/contrib/minimal.lua
--

vim.opt.runtimepath:prepend("~/.config/nvim/test")

-- vim.g.foo = true


--

for _, plugin in ipairs({
    "nvim-treesitter/nvim-treesitter",
    -- "foo-author/bar-plugin",


    --
}) do
    local install_path = vim.fn.fnamemodify(
        "~/.config/nvim/test/plugins" .. plugin:match("/%S+$"), ":p"
    )
    if vim.fn.isdirectory(install_path) == 0 then
        vim.fn.system({
            "git", "clone", "--depth=1",
            "https://github.com/" .. plugin, install_path
        })
    end
    vim.opt.runtimepath:append(install_path)
end

-- Opening certain filetypes causes errors on startup, fixed by having a treesitter parser
-- installed (I don't know why and it's unfortunate to add this in the "minimal config")
require("nvim-treesitter.configs").setup({
    ensure_installed = { "lua", "vimdoc" }
})

-- require("bar-plugin").setup()


--
