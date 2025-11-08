-- Textcmds
-- ========
--
-- Text editing commands that started out as simple keymaps but made sense to extend with
-- support for counts, mode-specific behaviors and dot-repeatability (todo)

-- Helpers
-- =======

local function is_visual_mode(mode)
    -- Accept any type of visual mode
    return mode == "v" or mode == "V" or mode == "\22"
end

local function get_line_range(mode, n_count_extend)
    local end_line = vim.fn.getpos(".")[2]
    local start_line = end_line - 1

    if is_visual_mode(mode) then
        local cursor_line = vim.fn.getpos(".")[2]
        local other_line = vim.fn.getpos("v")[2]

        -- Need to be ordered by lowest number first
        start_line = math.min(cursor_line, other_line) - 1
        end_line = math.max(cursor_line, other_line)

    elseif n_count_extend then
        local count = vim.v.count1
        end_line = start_line + count
    end

    return start_line, end_line
end

local function esc()
    local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
    vim.api.nvim_feedkeys(esc, "n", true)
end

-- Commands
-- ========

local M = {}

-- Reduce all consecutive whitespace sections to 1 space
-- Ignoring leading whitespace (indent) and stripping trailing whitespaces
function M.squeeze_spaces()
    local mode = vim.api.nvim_get_mode().mode
    local start_line, end_line = get_line_range(mode, true)
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
    local start_line, end_line = get_line_range(mode, true)

    local deleted_lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)
    vim.fn.setreg(vim.v.register, deleted_lines)

    vim.api.nvim_buf_set_lines(0, start_line, end_line, false, {""})
    vim.fn.cursor(start_line + 1, 0)

    if is_visual_mode(mode) then
        esc()
    end
end

-- Append register to line as a oneliner
-- In visual mode, append to all lines in selection
-- Count to duplicate the append (per line in visual selection)
function M.append_paste(join_by_space)
    local mode = vim.api.nvim_get_mode().mode
    local start_line, end_line = get_line_range(mode, false)
    local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)

    local reg = vim.fn.getreg(vim.v.register)

    if reg ~= "" then
        local reg_joined = reg:gsub("\n$", ""):gsub("^%s*", "")
                              :gsub("%s*$", ""):gsub("%s+", " ")

        for i = 1, #lines do
            local line = lines[i]
            for _ = 1, vim.v.count1 do
                -- First trim any existing trailing whitespace
                -- Having one space there fresh out of insert mode is surprisingly common
                line = line:gsub("%s*$", "")

                local space
                if join_by_space and line ~= "" then
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

    vim.fn.cursor(end_line, 0)
    vim.cmd("normal! $")

    if is_visual_mode(mode) then
        esc()
    end
end

-- Delete last character in line (or all selected lines)
-- With count, deletes [count] last characters in line(s)
function M.delete_last_char()
    local mode = vim.api.nvim_get_mode().mode
    local start_line, end_line = get_line_range(mode, false)
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

    if is_visual_mode(mode) then
        esc()
    end
end

-- Add a blank newline above and below current line or selection
-- With count, adds more blanklines
function M.surround_with_blanklines()
    local mode = vim.api.nvim_get_mode().mode
    local start_line, end_line = get_line_range(mode, false)

    local blanklines = {}
    for _ = 1, vim.v.count1 do
        table.insert(blanklines, "")
    end

    vim.api.nvim_buf_set_lines(0, end_line, end_line, false, blanklines)
    vim.api.nvim_buf_set_lines(0, start_line, start_line, false, blanklines)

    if is_visual_mode(mode) then
        esc()
    end
end

return M
