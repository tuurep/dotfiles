-- Soft wrap
vim.opt_local.wrap = true
vim.opt_local.linebreak = true

-- Vimtex keymaps

-- If continuous compilation is already in process, just open the pdf
-- Otherwise start continuous compilation
-- todo: would be nice if there's already an open pdf, it wouldn't open a duplicate
--       (possibly complicated, WM related)
vim.keymap.set("n", "§", function()
    local is_compiling = vim.fn.eval("b:vimtex.compiler.is_running()")
    if is_compiling == 1 then
        vim.cmd.VimtexView()
    else
        vim.cmd.VimtexCompile()
    end
end, {buffer=0, silent =true})

vim.keymap.set("n", "<C-§>", "<Plug>(vimtex-errors)", {buffer=0, silent =true})
