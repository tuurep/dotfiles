-- Experimental
-- ============

-- I don't know what's going to happen here
--
-- Depends on tpope/vim-repeat

local M = {}

-- Helpers
-- =======

local function save_pos(mark_ns)
    local pos = vim.api.nvim_win_get_cursor(0)
    local line, col = pos[1] - 1, pos[2]

    local mark_id = vim.api.nvim_buf_set_extmark(0, mark_ns, line, col, {})
    return mark_id
end

local function restore_pos(mark_id, mark_ns)
    local mark = vim.api.nvim_buf_get_extmark_by_id(0, mark_ns, mark_id, {})
    vim.api.nvim_win_set_cursor(0, { mark[1] + 1 , mark[2] })
    vim.api.nvim_buf_del_extmark(0, mark_ns, mark_id)
end

local function set_dot_repeat()
    -- Abuse vim-repeat to make insert_and_jump_back dot-repeat in a way that *feels*
    -- natural and expected
    vim.fn["repeat#set"](vim.api.nvim_replace_termcodes("<Plug>dot_repeat_and_jump_back", true, true, true))
end

-- Commands
-- ========

-- A or I but return cursor to the location before A/I
-- Could also use any command that enters insert mode like ci)
function M.insert_and_jump_back(insert_cmd)
    mark_ns = vim.api.nvim_create_namespace("insert_and_jump_back")
    local mark_id = save_pos(mark_ns)

    vim.api.nvim_create_autocmd("InsertLeave", {
        once = true,
        callback = function()
            restore_pos(mark_id, mark_ns)
            set_dot_repeat()
        end
    })
    -- Enter insert mode
    local keys = vim.v.count1 .. insert_cmd
    vim.api.nvim_feedkeys(keys, "m", false)
end

vim.keymap.set("n", "<Plug>dot_repeat_and_jump_back", function()
    mark_ns = vim.api.nvim_create_namespace("insert_and_jump_back")
    local mark_id = save_pos(mark_ns)
    vim.cmd("normal! .")
    restore_pos(mark_id, mark_ns)
    set_dot_repeat()
end)

return M
