-- Options
-- =======

vim.bo.keywordprg=":help"

-- Pairs / surroundings / textobjs
-- ===============================

vim.keymap.set("!", "<M-f>", "function()end<Left><Left><Left>")

-- Todo: rename to minitpopesurround_config
-- This is *my* plugin bro
vim.b.minisurround_config = {
    custom_surroundings = {
        ["F"] = {
            input = { "function%(.-%)%s*().-()%s*end" },

            -- Todo: spaces are terrible in linewise surround
            -- But it's a larger problem, and why we have distinct `)` and `(`,
            -- or `d` and `D` for example.
            output = { left = "function() ", right = " end" }
        }
    }
}

vim.b.miniai_config = {
    custom_textobjects = {
        ["F"] = { "function%(.-%)%s*().-()%s*end" }
    }
}

-- Todo: require "end" to be a whole word and not match: "send", "prepend", "pending" ...
