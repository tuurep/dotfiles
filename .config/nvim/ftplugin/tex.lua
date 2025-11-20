-- Options
-- =======

vim.opt_local.wrap = true
vim.opt_local.linebreak = true

-- Vimtex keymaps
-- ==============

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

-- Pairs / surroundings / textobjs
-- ===============================

-- Todo:
--     - input envname similar to surround/ai builtin f
--     - ft-agnostic f needs that in insert mode too

vim.keymap.set("!", "<M-f>", "\\begin{}\\end{}<Left><Left><Left><Left><Left><Left>")

vim.b.minisurround_config = {
    custom_surroundings = {
        ["f"] = {
            input = { "\\begin{%a*}%s*().-()%s*\\end{%a*}" },
            output = { left = "\\begin{}", right = "\\end{}" }
        }
    }
}

-- Todo:
--     - charwise awkwardness
--         - I see a pattern for things I want to delete linewise but not "collapse" the
--           delimiters like:
--
--           {}
--
--           vs.
--
--           {
--           }
--
--         - have to come up with a spec about how it should be, then hack on mini.ai
--
--     - doesn't match current when nested?
--     - require envnames to be the same string

vim.b.miniai_config = {
    custom_textobjects = {
        ["f"] = { "\\begin{%a*}%s*().-()%s*\\end{%a*}" }
    }
}
