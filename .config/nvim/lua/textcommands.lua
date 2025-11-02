-- Collection of text-editing commands similar to builtin J:
--
--     In normal mode, operate on current line
--         (or [count] lines)
--
--     In visual mode, operate on selected lines
--         (regardless of visual mode type)

-- Todo:
--     - Dot repeat doesn't work (what would that require?)
--     - Rethink count for:
--         - X:     delete last [count] characters in line(s)
--         - <C-p>: paste [count] times on line(s)
--         - (keep the others like they currently are)

-- Helpers

local function is_visual_mode(mode)
    -- Accept any type of visual mode
    return mode == "v" or mode == "V" or mode == "\22"
end

local function get_line_range(mode)
    local start_line, end_line

    if is_visual_mode(mode) then
        local cursor_line = vim.fn.getpos(".")[2]
        local other_line = vim.fn.getpos("v")[2]

        -- Need to be ordered by lowest number first
        start_line = math.min(cursor_line, other_line) - 1
        end_line = math.max(cursor_line, other_line)

    elseif mode == "n" then
        local count = vim.v.count1
        start_line = vim.api.nvim_win_get_cursor(0)[1] - 1
        end_line = start_line + count
    end

    return start_line, end_line
end

local function esc()
    local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
    vim.api.nvim_feedkeys(esc, "n", false)
end


-- Commands

local M = {}

-- Append register to line as a oneliner
-- In visual mode, append to all lines in selection
function M.append_paste(join_by_space)
    local mode = vim.api.nvim_get_mode().mode
    local start_line, end_line = get_line_range(mode)
    local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)

    local reg = vim.fn.getreg(vim.v.register)

    if reg ~= "" then
        local reg_joined = reg:gsub("\n$", ""):gsub("^%s*", "")
                              :gsub("%s*$", ""):gsub("%s+", " ")

        for i, line in ipairs(lines) do
            -- First trim any existing trailing whitespace
            -- Having one space there fresh out of insert mode is surprisingly common
            line = line:gsub("%s*$", "")

            local space
            if join_by_space and line ~= "" then
                space = " "
            else
                space = ""
            end
            lines[i] = line .. space .. reg_joined
        end

        vim.api.nvim_buf_set_lines(0, start_line, end_line, false, lines)
    end

    vim.fn.cursor(end_line, 0)
    vim.cmd("normal! $")

    if is_visual_mode(mode) then
        esc()
    end
end

-- Reduce all consecutive whitespace sections to 1 space
-- Ignoring leading whitespace (indent) and stripping trailing whitespaces
function M.squeeze_spaces()
    local mode = vim.api.nvim_get_mode().mode
    local start_line, end_line = get_line_range(mode)
    local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)

    for i, line in ipairs(lines) do
        lines[i] = line:gsub("(%S)%s+", "%1 "):gsub("%s+$", "")
    end
    vim.api.nvim_buf_set_lines(0, start_line, end_line, false, lines)

    if is_visual_mode(mode) then
        esc()
    end
end

-- Like dd but leave a blank line
-- For visual selection, delete lines and leave one blank line
function M.wipe_line()
    local mode = vim.api.nvim_get_mode().mode
    local start_line, end_line = get_line_range(mode)

    local deleted_lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)
    vim.fn.setreg(vim.v.register, deleted_lines)

    vim.api.nvim_buf_set_lines(0, start_line, end_line, false, {""})
    vim.fn.cursor(start_line + 1, 0)

    if is_visual_mode(mode) then
        esc()
    end
end

-- Delete last character in line (or all selected lines)
function M.delete_last_char()
    local mode = vim.api.nvim_get_mode().mode
    local start_line, end_line = get_line_range(mode)
    local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)

    for i, line in ipairs(lines) do
        local char_count = vim.fn.strchars(line) -- account for multibyte chars
        if char_count > 0 then
            lines[i] = vim.fn.strcharpart(line, 0, char_count - 1)
        end
    end

    vim.api.nvim_buf_set_lines(0, start_line, end_line, false, lines)

    if is_visual_mode(mode) then
        esc()
    end
end

return M
