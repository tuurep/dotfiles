-- Helper
local function get_line_indent(line)
    local prev_nonblank = vim.fn.prevnonblank(line)
    local res = vim.fn.indent(prev_nonblank)

    -- Compute indent of blank line
    if line ~= prev_nonblank then
        local next_indent = vim.fn.indent(vim.fn.nextnonblank(line))
        res = math.max(res, next_indent)
    end

    return res
end

local M = {}

function M.indent(ai_type)
    local res = {}

    local target_indent = math.max(
        get_line_indent(vim.fn.line(".")),
        1 -- If cursor is at an unindented part, target all top-level indents
    )

    local from_line, to_line
    local scoping = false
    local eob = vim.fn.line("$")

    for i = 1, eob, 1 do

        -- Find region end
        if scoping then
            local line = vim.fn.getline(i)

            if not line:match("^%s*$") and vim.fn.indent(i) < target_indent then

                to_line = i

                if ai_type == "a" then
                    from_line = math.max(from_line - 1, 1)
                else
                    to_line = to_line - 1
                end

                local region = {
                    from = { line = from_line, col = 1 },
                    to = { line = to_line, col = vim.fn.col({ to_line, "$" }) },
                    vis_mode = "V"
                }
                table.insert(res, region)
                scoping = false
            end

        -- Find region start
        else
            if get_line_indent(i) >= target_indent then
                from_line = i 
                scoping = true
            end
        end

        -- Last buffer line edge case
        if i == eob and scoping then
            if ai_type == "a" then
                from_line = math.max(from_line - 1, 1)
            end
            local region = {
                from = { line = from_line, col = 1 },
                to = { line = eob, col = vim.fn.col({ eob, "$" }) },
                vis_mode = "V"
            }
            table.insert(res, region)
        end

    end

    return res
end

-- mini.extra whole buffer textobject with slight modification
function M.entire_buffer(ai_type)
    local start_line = 1
    local end_line = vim.fn.line("$")

    if ai_type == "i" then
        -- Skip first and last blank lines for `i` textobject
        local first_nonblank = vim.fn.nextnonblank(start_line)
        local last_nonblank = vim.fn.prevnonblank(end_line)
        -- Do nothing for buffer with all blanks
        if first_nonblank == 0 or last_nonblank == 0 then
            return { from = { line = start_line, col = 1 } }
        end
        start_line = first_nonblank
        end_line = last_nonblank
    end

    local to_col = math.max(vim.fn.getline(end_line):len(), 1)
    return {
        from = { line = start_line, col = 1 },
        to = { line = end_line, col = to_col },
        vis_mode = "V"
    }
end

function M.md_codeblock(ai_type)
    local res = {}
    local from_line, from_col, to_line, to_col
    local inside_block = false

    for i = 1, vim.fn.line("$"), 1 do
        local line = vim.fn.getline(i)
        local fence_start, fence_end = line:find("```")

        if not inside_block then
            if fence_start then
                from_line = ai_type == "a" and i or i + 1
                from_col = ai_type == "a" and fence_start or 1
                inside_block = true
            end
        else
            if fence_end then
                to_line = ai_type == "a" and i or i - 1
                to_col = ai_type == "a" and fence_end or vim.fn.col({ to_line, "$" })
                inside_block = false

                local linewise = ai_type == "i" or from_col == 1

                table.insert(res, {
                    from = { line = from_line, col = from_col },
                    to = { line = to_line, col = to_col },
                    vis_mode = linewise and "V" or "v"
                })
            end
        end
    end

    return res
end

return M
