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

-- require("bar-plugin").setup()


--
