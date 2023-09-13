-- vim.g.foo = true


--

for _, plugin in ipairs({
    -- "foo-author/bar-plugin",


    --
}) do
    local install_path = vim.fn.fnamemodify("plugins" .. plugin:match("/%S+$"), ":p")
    if vim.fn.isdirectory(install_path) == 0 then
        vim.fn.system({
            "git", "clone", "--depth=1",
            "https://github.com/" .. plugin, install_path
        })
    end
    vim.opt.runtimepath:append(install_path)
end

-- nvim --clean -u ~/.config/nvim/test/minrc.lua
