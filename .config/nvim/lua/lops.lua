-- Line operators (lops)
-- =====================
--
-- Text editing commands that started out as simple keymaps but made sense to extend with
-- support for counts, mode-specific behaviors and dot-repeatability.
--
-- Though these would be easy to extend to take a motion, I find more comfortable to use
-- for the current line similarly to how builtin `J` works.

-- Helpers
-- =======

local function get_line_range()
    local from = vim.api.nvim_buf_get_mark(0, '[')
    local to = vim.api.nvim_buf_get_mark(0, ']')

    local start_line = from[1] - 1
    local end_line = to[1]

    -- Edge case: operator used on a blank line
    if start_line == end_line then
        end_line = end_line + 1
    end

    return start_line, end_line
end

-- Opfunc arguments workaround (?)
-- Store function arguments and read them back in opfuncs
local opts = {}

-- Operators
-- =========

local M = {}

-- Reduce all consecutive whitespace sections to 1 space
-- Ignoring leading whitespace (indent) and stripping trailing whitespaces
function M.squeeze_spaces(type)
    if type == nil then
        vim.o.operatorfunc = "v:lua.require'lops'.squeeze_spaces"
        return "g@_"
    end

    local start_line, end_line = get_line_range()
    local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)

    for i, line in ipairs(lines) do
        lines[i] = line:gsub("(%S)%s+", "%1 "):gsub("%s+$", "")
    end
    vim.api.nvim_buf_set_lines(0, start_line, end_line, false, lines)

    return ""
end

-- Like dd but leave a blank line
-- For visual selection, delete lines and leave one blank line
function M.wipe_line(type)
    if type == nil then
        vim.o.operatorfunc = "v:lua.require'lops'.wipe_line"
        return "g@_"
    end

    local start_line, end_line = get_line_range()
    local deleted_lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)
    vim.fn.setreg(vim.v.register, deleted_lines)

    vim.api.nvim_buf_set_lines(0, start_line, end_line, false, {""})
    vim.fn.cursor(start_line + 1, 0)

    return ""
end

-- Append register to line as a oneliner
-- In visual mode, append to all lines in selection
-- Count to duplicate the append (per line in visual selection)
--
-- The argument handling is weird
-- When called as (?) the opfunc, what we actually get is the "type" arg, which is one of:
--     - "line"
--     - "char"
--     - "block"
--
-- This goes for all functions here but in this one I also pass options with the arg
--
-- see :h :map-operator
function M.append_paste(arg)
    if type(arg) == "table" then
        opts = { join_by_space = arg.join_by_space }
        vim.o.operatorfunc = "v:lua.require'lops'.append_paste"
        return "g@l"
    end

    local start_line, end_line = get_line_range()
    local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)

    local reg = vim.fn.getreg(vim.v.register)

    if reg ~= "" then
        local reg_joined = reg:gsub("\n$", ""):gsub("^%s*", "")
                              :gsub("%s*$", ""):gsub("%s+", " ")

        for i = 1, #lines do
            local line = lines[i]
            for _ = 1, vim.v.count1 do

                local space
                if opts.join_by_space and not line:match("^%s*$") then
                    -- Trim any existing trailing whitespace: having one space there fresh
                    -- out of insert mode is surprisingly common
                    line = line:gsub("%s*$", "")
                    space = " "
                else
                    space = ""
                end
                line = line .. space .. reg_joined
            end
            lines[i] = line
        end

        vim.api.nvim_buf_set_lines(0, start_line, end_line, false, lines)
    end

    -- Normal `p` places cursor to the end of the pasted text (if charwise)
    -- Mimic this here (note: not on $ but on the last column)
    vim.fn.cursor(end_line, #vim.fn.getline(end_line))

    return ""
end

-- Delete last character in line (or all selected lines)
-- With count, deletes [count] last characters in line(s)
function M.delete_last_char(type)
    if type == nil then
        vim.o.operatorfunc = "v:lua.require'lops'.delete_last_char"
        return "g@l"
    end

    local start_line, end_line = get_line_range()
    local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)

    for i = 1, #lines do
        local line = lines[i]
        for _ = 1, vim.v.count1 do
            local char_count = vim.fn.strchars(line) -- account for multibyte chars
            if char_count > 0 then
                line = vim.fn.strcharpart(line, 0, char_count - 1)
            end
        end
        lines[i] = line
    end

    vim.api.nvim_buf_set_lines(0, start_line, end_line, false, lines)

    return ""
end

-- Add a blank newline above and below current line or selection
-- With count, adds more blanklines
function M.surround_with_blanklines(type)
    if type == nil then
        vim.o.operatorfunc = "v:lua.require'lops'.surround_with_blanklines"
        return "g@l"
    end

    local start_line, end_line = get_line_range()

    local blanklines = {}
    for _ = 1, vim.v.count1 do
        table.insert(blanklines, "")
    end

    vim.api.nvim_buf_set_lines(0, end_line, end_line, false, blanklines)
    vim.api.nvim_buf_set_lines(0, start_line, start_line, false, blanklines)

    return ""
end

return M
