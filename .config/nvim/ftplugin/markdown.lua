-- Options
-- =======

vim.opt_local.wrap = true
vim.opt_local.linebreak = true

-- Markdown editing operators (experimental)
-- =========================================

-- Todo:
--   - dot repeat only repeats the `gw`
--   - if end is at lower indent than start, inserts "> " in the middle of text
--      - (note: this may be an unreasonable use case)

_G.format_into_blockquote = function(type)
    if type == nil then
        vim.o.operatorfunc = "v:lua.format_into_blockquote"
        return "g@"
    end

    -- Put an extmark on motion end so after format we can still grab all lines when the
    -- number of lines increases
    local motion_start = vim.api.nvim_buf_get_mark(0, '[')
    local motion_end = vim.api.nvim_buf_get_mark(0, ']')
    local mark_ns = vim.api.nvim_create_namespace("format_into_blockquote")
    local mark_id = vim.api.nvim_buf_set_extmark(0, mark_ns, motion_end[1], -1, {})

    -- Reduce tw for format so that we don't have to format *again* after inserting "> "
    local save_tw = vim.o.textwidth
    vim.o.textwidth = save_tw - 2
    vim.cmd("normal! '[gw']")
    vim.o.textwidth = save_tw

    -- Alternative idea using GNU fmt:
    -- vim.cmd("'[,']!fmt -w " .. vim.o.textwidth - 1)
    -- Could be then piped to sed to prepend "> " to lines, making all of this a oneliner
    -- Problem: in some subtle ways, it doesn't quite reflow the same way as `gw`

    local formatted_text_end = vim.api.nvim_buf_get_extmark_by_id(0, mark_ns, mark_id, {})
    local lines = vim.api.nvim_buf_get_lines(0, motion_start[1] - 1, formatted_text_end[1], false)

    -- Find the correct col to put the ">" when nested in lists
    local indent_or_list_part = lines[1]:match("^%s*[%-%*%+]%s") -- Bullet - * +
                             or lines[1]:match("^%s*%d+%.%s")    -- Number 1. 2. 3. 10. 11. 12.
                             or lines[1]:match("^%s*")           -- Indent only
                             or ""

    local offset = #indent_or_list_part

    for i = 1, #lines do
        local line = lines[i]
        if line:match("^%s*$") then
            lines[i] = string.rep(" ", offset) .. ">"
        else
            lines[i] = line:sub(1, offset) .. "> " .. line:sub(offset + 1)
        end
    end

    vim.api.nvim_buf_set_lines(0, motion_start[1] - 1, formatted_text_end[1], false, lines)
    vim.api.nvim_buf_del_extmark(0, mark_ns, mark_id)

    return ""
end

-- Keymaps
-- =======

vim.keymap.set({"n", "x"}, "<leader><", function()
    return format_into_blockquote()
end, { expr = true, buffer = 0 })

vim.cmd([[
    nnoremap <buffer> <expr> <leader><< "<cmd>set opfunc=v:lua.format_into_blockquote<cr>" .. v:count1 .. "g@_"
]])

-- Preview file in browser
-- Save file to avoid the case where you've just started editing a new file,
-- haven't yet saved and may be left thinking that Vivify is hanging
vim.keymap.set("n", "§", "<cmd>w<cr><cmd>Vivify<cr>", { buffer = 0 })
