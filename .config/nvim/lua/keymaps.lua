-- <leader> is <Space>
vim.keymap.set({"n", "x", "o"}, "<Space>", "<Nop>")
vim.g.mapleader = " "

-- Free keys:
vim.keymap.set({"n", "x", "o"}, "<Up>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<Down>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<Left>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<Right>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "+", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<C-u>", "<Nop>")  -- <C-d> is remapped, and <C-j> <C-k> preferred for scrolling
vim.keymap.set({"n", "x", "o"}, "/", "<Nop>")      -- Tab/S-Tab as search, ? is now :help
vim.keymap.set("n", "<C-r>", "<Nop>")              -- U as redo
vim.keymap.set("n", "<C-o>", "<Nop>")              -- <C-i> is compromised so use <M-o> and <M-i>
vim.keymap.set({"n", "x"}, "<C-e>", "<Nop>")       -- <M-s> and <M-d> are remapped as <C-e> and <C-y>
vim.keymap.set({"n", "x"}, "<Backspace>", "<Nop>")
vim.keymap.set({"n", "x"}, "<Enter>", "<Nop>")
vim.keymap.set({"n", "x"}, "gJ", "<Nop>")          -- gå for spaceless join, leave gJ and gK
                                                   -- as ideas for vertical movement mappings
-- ½
-- zh zl
-- gy gY
-- gz gZ
-- ä Ä gä gÄ zä zÄ
-- gö gÖ zö zÖ
-- gÅ zå zÅ

-- Free (but bad):
vim.keymap.set({"n", "x", "!"}, "<PageUp>", "<Nop>")
vim.keymap.set({"n", "x", "!"}, "<PageDown>", "<Nop>")
vim.keymap.set({"n", "i"}, "<F1>", "<Nop>")

-- Allow vim-sneak to be mapped to q
vim.keymap.set({"n", "x"}, "<Del>", "q")
vim.keymap.set({"n", "x"}, "<S-Del>", "Q")
vim.keymap.set({"n", "x"}, "<M-Del>", "@")
vim.keymap.set({"n", "x"}, "<M-Del><M-Del>", "@@")

-- Move the mark key to the edge of the keyboard to use m for mini.ai textobject motions
vim.keymap.set("n", "<Ins>", "m")

-- Tab to search
vim.keymap.set({"n", "x", "o"}, "<Tab>", "/")
vim.keymap.set({"n", "x", "o"}, "<S-Tab>", "?")

-- Remap jumplist maps: <C-i> and <Tab> are the same due to terminal weirdness
vim.keymap.set("n", "<M-n>", "<C-o>")
vim.keymap.set("n", "<M-S-n>", "<C-i>")

-- Start a substitute command without finger gymnastics:
vim.keymap.set("n", "<leader><Tab>", ":%s/")
vim.keymap.set("x", "<leader><Tab>", ":s/")

vim.keymap.set("n", "<leader><Enter>", function()
    local path = vim.fn.expand("%")
    local tildepath = vim.fn.fnamemodify(path, ":p:~")
    if vim.fn.bufname() == "" then
        tildepath = tildepath .. "[No Name]"
    end
    vim.api.nvim_echo({{tildepath}}, false, {}) -- current buffer full path
end)                                            -- $HOME as ~

vim.keymap.set("n", "<leader><Backspace>",
    "<cmd>echo fnamemodify(getcwd(), ':p:~')<cr>") -- pwd but with tilde

vim.keymap.set("n", "<Esc>", "<cmd>echo ''<cr>") -- clear cmdline text

-- Command mode <C-f> special buffer fixes
-- (currently not needed because I don't have an <Enter> mapping)
-- 
-- vim.api.nvim_create_autocmd({"CmdWinEnter"}, {
--     callback = function()
--         vim.keymap.set("n", "<Enter>", "<Enter>", b)
--     end
-- })

-- Mappings like in zsh line editing
-- Todo: not quite consistent with zsh emacs-mode in all cases
vim.keymap.set("!", "<C-h>", "<Left>")
vim.keymap.set("!", "<C-l>", "<Right>")

vim.keymap.set("!", "<C-k>", "<Up>")
vim.keymap.set("!", "<C-j>", "<Down>")
vim.keymap.set("!", "<M-k>", "<Up>")
vim.keymap.set("!", "<M-j>", "<Down>")

-- Similar to zsh 'emacs-forward-word':
-- Go to the next word end (on the whitespace), or if EOL comes first, go to EOL
vim.keymap.set("i", "<M-l>", function()
    local line = vim.fn.getline(".")
    local col = vim.fn.col(".")
    local eol_col = #line + 1

    local pair_at_cursor = line:sub(col, col + 1)

    -- At the last char of a word, move to the whitespace after it
    if pair_at_cursor:match("%S%s") then
        vim.cmd("normal! l")
        return
    end

    -- Cursor initially at EOL edge cases
    if col == eol_col then
        vim.cmd("normal! El") -- Move to the next word end on the next line

        -- If next line has only one word, need to correct col to the next line's EOL
        local next_line = vim.fn.getline(".")
        local next_col = vim.fn.col(".")
        local next_eol_col = #next_line + 1

        if next_col == #next_line then
            vim.api.nvim_win_set_cursor(0, { vim.fn.line('.'), next_eol_col })
        end
        return
    end

    local rest_of_line = line:sub(col + 1)

    -- Go to the next word end, or EOL if that comes first
    if rest_of_line:find("%S%s") then
        vim.cmd("normal! El")
    else
        vim.api.nvim_win_set_cursor(0, { vim.fn.line('.'), eol_col })
    end
end)

-- Basically a simple `B` is sufficient as a backwards variant,
-- but needs to skip empty lines
vim.keymap.set("i", "<M-h>", function()
    vim.cmd("normal! B")

    -- Skip empty lines
    while vim.fn.getline(".") == "" do
        if vim.fn.line(".") == 1 then break end
        vim.cmd("normal! B")
    end
end)

-- Same idea in command mode (has differences with word delimiters)
vim.keymap.set("c", "<M-h>", "<C-Left>")
vim.keymap.set("c", "<M-l>", "<C-Right>")

vim.keymap.set("!", "<M-w>", "<C-w>") -- Todo: <C-w>
vim.keymap.set("!", "<M-u>", "<C-u>") -- Todo: <C-u>
                                      -- Todo: <M-U>
vim.keymap.set("!", "<M-H>", "<Home>")
vim.keymap.set("!", "<M-L>", "<End>")

-- Autopair-like mappings with the same aliases as mini.tpopesurround and mini.ai
-- Todo: Won't cleanly undo when these mappings are used
-- Todo: Visual block mode various strange behaviors (unusable really)
-- Todo: Turn into a plugin to better control when to indent and when not to
vim.keymap.set("!", "<M-e>", "()<Left>")
vim.keymap.set("!", "<M-d>", "{}<Left>")
vim.keymap.set("!", "<M-a>", "[]<Left>")
vim.keymap.set("!", "<M-<>", "<><Left>")

vim.keymap.set("!", "<M-E>",    "(  )<Left><Left>")
vim.keymap.set("!", "<M-D>",    "{  }<Left><Left>")
vim.keymap.set("!", "<M-A>",    "[  ]<Left><Left>")
vim.keymap.set("!", "<M-S-lt>", "<  ><Left><Left>") -- ">" would close the key tag

vim.keymap.set("!", "<M-q>", '""<Left>')
vim.keymap.set("!", "<M-r>", "''<Left>")
vim.keymap.set("!", "<M-z>", "``<Left>")

vim.keymap.set("!", "<M-Space>", "  <Left>")

vim.keymap.set("!", "<M-Q>", '""""""<left><left><left>')
vim.keymap.set("!", "<M-Z>", "``````<Left><Left><Left>")

vim.keymap.set("!", "<M-'>",   "**<Left>")
vim.keymap.set("!", "<M-S-'>", "****<Left><Left>")

-- Todo: syntax highlight flashes uncomfortably. Reimplement with nvim API stuff.
vim.keymap.set("i", "<M-Enter>", "<Enter><Esc>O")
vim.keymap.set("i", "<M-S-Enter>", "<M-Enter>", { remap = true })

-- Weird experimental mappings to enter some of the most annoying-to-type chars
vim.keymap.set("!", "<M-1>", "~/")
vim.keymap.set("!", "<M-2>", "&")

 -- Todo: turn this into 'repeat last substitute exactly as it was'
 --       meaning: including range or `%s`, and same flags
-- vim.keymap.set("n", "<M-2>", "g&")
vim.keymap.set({"n", "x"}, "<M-.>", "@:") -- Repeat last command

-- Essential keys for both movement and operator pending
-- (with the worst defaults known to man)
vim.keymap.set({"n", "x"}, "-", "}")
vim.keymap.set({"n", "x"}, "_", "{")
vim.keymap.set({"n", "x", "o"}, "H", "^")
vim.keymap.set({"n", "x", "o"}, "L", "$")
vim.keymap.set({"n", "x", "o"}, "gH", "g^")
vim.keymap.set({"n", "x", "o"}, "gL", "g$")

-- Force operator-pending paragraph motion linewise (otherwise almost useless)
vim.keymap.set("o", "-", "V}")
vim.keymap.set("o", "_", "V{")

-- Remap what the above has overriden
vim.keymap.set("!", "<C-z>", "<C-k>")
vim.keymap.set({"n", "x", "o"}, "<leader>k", "H")
vim.keymap.set({"n", "x", "o"}, "<leader><leader>", "M")
vim.keymap.set({"n", "x", "o"}, "<leader>j", "L")
vim.keymap.set({"n", "x"}, "?", "K")

-- Shift+g slightly too annoying to press.
-- Enter and Backspace are pressed easily by accident on normal mode, so use Alt, but
-- allow dropping alt in operator-pending.
-- Goes nicely with mini.ai "entire buffer" textobject on Enter.
vim.keymap.set({"n", "x"}, "<M-Enter>", "G")
vim.keymap.set({"n", "x"}, "<M-Backspace>", "gg")
vim.keymap.set("o", "<Enter>", "G")
vim.keymap.set("o", "<Backspace>", "gg")

-- Spammable buffer navigation
vim.keymap.set("n", "<C-h>", "<cmd>bp<cr>")
vim.keymap.set("n", "<C-l>", "<cmd>bn<cr>")

-- Group together similar mappings that move the view without moving the cursor
vim.keymap.set({"n", "x"}, "<M-j>", "3<C-e>")
vim.keymap.set({"n", "x"}, "<M-k>", "3<C-y>")
vim.keymap.set({"n", "x"}, "<M-S-j>", "<C-e>")
vim.keymap.set({"n", "x"}, "<M-S-k>", "<C-y>")
vim.keymap.set({"n", "x"}, "<M-h>", "3zh")
vim.keymap.set({"n", "x"}, "<M-l>", "3zl")
vim.keymap.set({"n", "x"}, "<M-S-h>", "zh")
vim.keymap.set({"n", "x"}, "<M-S-l>", "zl")
vim.keymap.set({"n", "x"}, "zj", "zt")
vim.keymap.set({"n", "x"}, "zk", "zb")

-- (Never used folds but) swap what was overriden above
vim.keymap.set({"n", "x"}, "zt", "zk")
vim.keymap.set({"n", "x"}, "zb", "zj")

-- Like <C-d> and <C-u> but never moves the cursor relative to the 'view'

-- Todo:
--      Doesn't work with `smoothscroll`:
--          - Can't make the first line partially shown on its own
--          - It there is a partially shown line (through other scroll method),
--            the '<<<' gets stuck at top even when it should not be there,
--            until screen is scrolled by any other way than this function.
--      Wrap edge case:
--          - At EOB, if there's a line in the previous view that's heavily wrapped,
--            many EOB characters can be shown in the last view.
--          - It's an impossible scenario: one line is too far, but the previous
--            line doesn't show the last line of the buffer.
--            The former case is the better compromise.
--      Fold behavior:
--          - Looks like it isn't moving, but goes through the fold lines,
--            passing through eventually. Would be nice to ignore folded lines
--            completely.
--            See `:h foldclosed`

local function scroll(distance)
    local top = vim.fn.line("w0")
    local bottom = vim.fn.line("w$")

    local keep_at_bottom = false
    local keep_at_top = false

    local curpos = vim.fn.getcurpos(0)
    local lnum = curpos[2]
    local curswant = curpos[5]

    -- When there are soft wrapped lines,
    -- If cursor is at the extreme top/bottom line (only possible with no scrolloff),
    -- make sure it stays there in the next view.
    if vim.o.scrolloff == 0 then
        if lnum == bottom then
            keep_at_bottom = true
        end
        if lnum == top then
            keep_at_top = true
        end
    end

    local n = 0
    if distance > 0 then
        local eof = vim.api.nvim_buf_line_count(0)
        n = math.min(distance, eof - bottom)
    else
        n = math.max(distance, -top + 1)
    end

    vim.fn.winrestview({
        topline = top + n,
        lnum = lnum + n,
        curswant = curswant - 1,
        col = curswant - 1
    })

    if keep_at_bottom then
        vim.fn.cursor({vim.fn.line("w$"), curswant, 0, curswant})
    elseif keep_at_top then
        vim.fn.cursor({vim.fn.line("w0"), curswant, 0, curswant})
    end
end
vim.keymap.set({"n", "x", "o"}, "<C-j>", function() scroll(12) end)
vim.keymap.set({"n", "x", "o"}, "<C-k>", function() scroll(-12) end)
vim.keymap.set({"n", "x", "o"}, "<C-M-j>", function() scroll(1) end)
vim.keymap.set({"n", "x", "o"}, "<C-M-k>", function() scroll(-1) end)

-- One-handed save and quit
vim.keymap.set({"n", "x"}, "<C-s>", "<cmd>w<cr>")
vim.keymap.set({"n", "x"}, "<C-q>", "<cmd>q<cr>")

-- Replace builtin J with an equivalent that takes a motion
-- (meaning I won't find a new mapping for J because it's that much worse)
-- (note: these functions are global)
function J_motion(type)
    vim.cmd("'[,']join")
end
function gJ_motion(type)
    vim.cmd("'[,']join!")
end
vim.keymap.set({"n", "x"}, "å", "<cmd>set opfunc=v:lua.J_motion<cr>g@")
vim.keymap.set({"n", "x"}, "gå", "<cmd>set opfunc=v:lua.gJ_motion<cr>g@")
vim.keymap.set({"n", "x"}, "åå", "åj", { remap = true }) -- Todo: handle [count]åå

-- Like yy dd cc but no newline at end (Todo: handle counts)
vim.keymap.set("n", "<C-y>", function()
    vim.fn.setreg(vim.v.register, vim.api.nvim_get_current_line())
end)

vim.keymap.set("n", "<C-d>", '<C-y>0"_D', { remap = true }) -- blackhole the deletion to not set unnamed reg
vim.keymap.set("n", "<C-c>", '<C-y>0"_C', { remap = true }) -- if another reg was chosen

-- Append register to current line as a oneliner
-- Sanitizes whitespace:
--      Trim leading/trailing whitespace
--      Tabs/indents in the middle get reduced to 1 space
vim.keymap.set("n", "<C-p>", function()
    local line = vim.api.nvim_get_current_line()
    local reg = vim.fn.getreg(vim.v.register)

    if reg ~= "" then
        local joined = reg:gsub("\n$", ""):gsub("^%s*", ""):gsub("%s*$", ""):gsub("%s+", " ")
        if line ~= "" then
            line = line .. " "
        end
        vim.api.nvim_set_current_line(line .. joined)
    end
    vim.cmd("normal! $")
end)

-- Visual mode variants
vim.keymap.set("x", "<C-d>", function()
    -- Only in visual line selection, delete and leave one empty line
    if vim.fn.mode() == "V" then
        vim.cmd("normal! c") -- (does not stay in insert mode)
    end
end)
vim.keymap.set("x", "<C-c>", "<Nop>")
vim.keymap.set("x", "<C-y>", "<Nop>")
vim.keymap.set("x", "<C-p>", "<Nop>") -- todo: this could make sense in visual block mode

-- Fix x and X (from being terrible)
-- To be fixed: would like consecutive xxxxxxx to be treated as a single undo item
-- (not simple)
local function blackhole(count, key)
    if count > 1 then
        -- If count is given, you probably do want it in the register
        vim.cmd('normal! ' .. count .. key)
    else
        vim.cmd('normal! "_' .. key)
    end
end

vim.keymap.set("n", "x", function() blackhole(vim.v.count1, "x") end)

-- Delete the last character of the line (haven't found builtin X useful)
vim.keymap.set("n", "X", function()
    local count = vim.v.count1
    vim.cmd("normal! $")
    if count > 1 then
        vim.cmd("normal! " .. count - 1 .. "h")
    end
    blackhole(count, "x")
end)

-- o O normal mode companion
vim.keymap.set("n", "<M-o>", "o<Esc>")
vim.keymap.set("n", "<M-O>", "O<Esc>")

-- Without shift = forward, with shift = backward
vim.keymap.set({"n", "x"}, "<", ">")
vim.keymap.set({"n", "x"}, ">", "<")
vim.keymap.set("n", "<<", ">>")
vim.keymap.set("n", ">>", "<<")

-- regular , and ; are surpassed by 'clever' f/t/s with option g:sneak#s_next
-- remap to jump between last edit positions (:h changelist)
vim.keymap.set("n", ",", "g;")
vim.keymap.set("n", ";", "g,")
vim.keymap.set({"x", "o"}, ",", "<Nop>")
vim.keymap.set({"x", "o"}, ";", "<Nop>")

-- Undo follows the same idea as above
-- Map <M-u> to WeirdUndo so it's still available when you want to use it (never)
vim.keymap.set("n", "U", "<C-r>")
vim.keymap.set("n", "<M-u>", "U")

-- ~ too hard to press for being so useful
vim.keymap.set("n", "<M-r>", "v~") -- v to prevent moving (moves 1 right by default)
vim.keymap.set("x", "<M-r>", "~")

-- Treesitter tools
vim.keymap.set("n", "<leader>e", "<cmd>Inspect<cr>")
vim.keymap.set("n", "<leader>E", "<cmd>InspectTree<cr>")

-- Toggle colorcolumn at `textwidth + 1`
vim.keymap.set({"n", "x"}, "¤", function()
    if #vim.opt.colorcolumn:get() == 0 then
        vim.opt.colorcolumn = { "+1" }
    else
        vim.opt.colorcolumn = {}
    end
end)

-- ===== PLUGINS =====

-- mini.splitjoin
local MiniSplitjoin = require("mini.splitjoin")
MiniSplitjoin.setup({
    mappings = {
        toggle = "Å"
    },
    join = {
        hooks_post = {
            MiniSplitjoin.gen_hook.pad_brackets({ brackets = { '%b{}' } })
        }
    }
})

-- mini.operators

require("mini.operators").setup({
    replace  = { prefix = "dp", selection = "p" },
    exchange = { prefix = "cx", selection = "x", cancel = "<Esc>" },
    multiply = { prefix = "ö" },
    evaluate = { prefix = "g." }
})

-- Make P the one that puts the replaced part in default register
-- because now p doesn't.
-- Todo: make that preserve indent as well.
--       (but I want this more generally for p/P in every mode)
--       (relevant plugin: vim-pasta)
vim.keymap.set("x", "P", "p")

vim.keymap.set("n", "dP", "dp$", { remap = true })
vim.keymap.set("n", "cX", "cx$", { remap = true })
vim.keymap.set("n", "Ö",  "ö$",  { remap = true })
vim.keymap.set("n", "gS", "gs$", { remap = true })
vim.keymap.set("n", "g:", "g.$", { remap = true })

-- mini.ai
local MiniAi = require("mini.ai")

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

local function ai_indent(ai_type)
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
local function ai_entire_buffer(ai_type)
    local start_line = 1
    local end_line = vim.fn.line('$')

    if ai_type == 'i' then
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

MiniAi.setup({
    mappings = {
        inside_next = "il",
        around_next = "al",
        inside_last = "ih",
        around_last = "ah",

        goto_next_end = "m",
        goto_next_start = "gm",
        goto_prev_start = "M",
        goto_prev_end = "gM"
    },
    custom_textobjects = {

        ["b"] = MiniAi.gen_spec.treesitter({ i = "@comment.inner", a = "@comment.outer" }),

        -- Remap 'argument' textobject, 'a' for square bracket
        ["c"] = MiniAi.gen_spec.argument(),

        -- Remap builtin '?'
        ["\t"] = MiniAi.gen_spec.user_prompt(), -- Tab

        -- Brackets aliases
        ["e"] = { "%b()", "^.().*().$" },
        ["d"] = { "%b{}", "^.().*().$" },
        ["a"] = { "%b[]", "^.().*().$" },
        ["<"] = { "%b<>", "^.().*().$" },
        ["E"] = { "%b()", "^.%s*().-()%s*.$" },
        ["D"] = { "%b{}", "^.%s*().-()%s*.$" },
        ["A"] = { "%b[]", "^.%s*().-()%s*.$" },
        [">"] = { "%b<>", "^.%s*().-()%s*.$" },

        -- Quotation aliases
        ["r"] = { "%b''", "^.().*().$" },
        ["z"] = { "%b``", "^.().*().$" },
        ["q"] = { '%b""', "^.().*().$" },
        ["Q"] = { '"""().-()"""' },
        ["Z"] = { "```().-()```" },

        -- Markdown (experimental)
        ["'"] = MiniAi.gen_spec.pair("*", "*", { type = "greedy" }),
        ["*"] = MiniAi.gen_spec.pair("*", "*", { type = "greedy" }),
        ["_"] = MiniAi.gen_spec.pair("_", "_", { type = "greedy" }),

        -- Custom
        ["i"]  = ai_indent,
        ["\r"] = ai_entire_buffer -- Enter

    },
    n_lines = 100,
    silent = true
})

-- mini.tpopesurround
-- todo: vim-wordmotion can make message noise on dot repeat
local MiniTpopesurround = require("mini.tpopesurround")

MiniTpopesurround.setup({
    mappings = {
        add = "s",
        delete = "ds",
        replace = "cs",

        add_visual = "s",

        add_and_indent = "<M-s>",
        replace_and_indent = "c<M-s>", -- awful but I never use this

        add_line = "ss",
        add_line_and_indent = "<M-s><M-s>",

        suffix_next = "l",
        suffix_last = "h",

        -- Disable
        find = "",
        find_left = "",
        update_n_lines = "",
        highlight = ""
    },
    custom_surroundings = {

        -- Brackets aliases
        ["e"] = { input = { "%b()", "^.().*().$" }, output = { left = "(",  right = ")" } },
        ["d"] = { input = { "%b{}", "^.().*().$" }, output = { left = "{",  right = "}" } },
        ["a"] = { input = { "%b[]", "^.().*().$" }, output = { left = "[",  right = "]" } },
        ["<"] = { input = { "%b<>", "^.().*().$" }, output = { left = "<",  right = ">" } },

        ["E"] = { input = { "%b()", "^. +().-() +.$" }, output = { left = "( ", right = " )" } },
        ["D"] = { input = { "%b{}", "^. +().-() +.$" }, output = { left = "{ ", right = " }" } },
        ["A"] = { input = { "%b[]", "^. +().-() +.$" }, output = { left = "[ ", right = " ]" } },
        [">"] = { input = { "%b<>", "^. +().-() +.$" }, output = { left = "< ", right = " >" } },

        -- Quotation aliases
        ["r"] = { input = { "%b''", "^.().*().$" }, output = { left = "'", right = "'" } },
        ["z"] = { input = { "%b``", "^.().*().$" }, output = { left = "`", right = "`" } },
        ["q"] = { input = { '%b""', "^.().*().$" }, output = { left = '"', right = '"' } },

        ["Q"] = { input = { '"""().-()"""' }, output = { left = '"""', right = '"""' } },
        ["Z"] = { input = { "```().-()```" }, output = { left = "```", right = "```" } },

        -- Markdown (experimental)
        ["'"] = { input = { "*().-()*"       }, output = { left = "*",  right = "*"  } },
        ["*"] = { input = { "%*%*().-()%*%*" }, output = { left = "**", right = "**" } },

        -- Map <Tab> to builtin `?`
        ["\t"] = {
            input = MiniTpopesurround.gen_spec.input.user_prompt(),
            output = MiniTpopesurround.gen_spec.output.user_prompt()
        }

    },
    silent = true
})
vim.keymap.set("n", "S", "s$", { remap = true })
vim.keymap.set("n", "<M-S>", "<M-s>$", { remap = true })

-- mini.move
require("mini.move").setup({
    mappings = {
        down =  "<C-S-j>",
        up =    "<C-S-k>",
        left =  "<C-S-h>",
        right = "<C-S-l>",

        line_down =  "<C-S-j>",
        line_up =    "<C-S-k>",
        line_left =  "<C-S-h>",
        line_right = "<C-S-l>"
    }
})

-- Comment.nvim
require("Comment").setup({
    opleader = {
        -- Swap the defaults,
        -- this allows to use `gbb` instead of `gbc`
        -- (line-operator doesn't need to use `b` motion)
        -- Slight inconsistency: line-operator with motions within a single line
        --                       insert block comments, so actually the `b` motion would work,
        --                       but I don't want to use `gb` this way.
        line = "gb",
        block = "gc"
    },
    toggler = {
        line = "gbb",
        block = "gcc"
    },
    extra = {
        below = "gbo",
        above = "gbO",
        eol = "gbA"
    }
})
vim.keymap.set("n", "gC", "gc$", { remap = true })

-- Todo:
-- Put line-comment string at cursor position, to comment til the end of line
-- vim.keymap.set("n", "gB", function()
--     local left, right = string.match(vim.bo.commentstring, "(.*)%%s(.*)")
--     left = vim.trim(left)
--     right = vim.trim(right)
--     -- Problem: for example in C we would get `/*`, when we want `//` for this,
--     --          and `/*`, `*/` for the block operator
-- end)

-- vim-sneak
vim.keymap.set({"n", "x", "o"}, "q", "<Plug>Sneak_s")
vim.keymap.set({"n", "x", "o"}, "Q", "<Plug>Sneak_S")
vim.keymap.set({"n", "x", "o"}, "f", "<Plug>Sneak_f")
vim.keymap.set({"n", "x", "o"}, "F", "<Plug>Sneak_F")
vim.keymap.set({"n", "x", "o"}, "t", "<Plug>Sneak_t")
vim.keymap.set({"n", "x", "o"}, "T", "<Plug>Sneak_T")

-- Wretched ftplugin wants to steal my q map
vim.api.nvim_create_autocmd("FileType", {
    pattern = "man",
    callback = function()
        vim.keymap.set("n", "q", "<Plug>Sneak_s", { buffer = true })
    end,
})

-- vim-edgemotion
vim.keymap.set({"n", "x", "o"}, "J", "<Plug>(edgemotion-j)")
vim.keymap.set({"n", "x", "o"}, "K", "<Plug>(edgemotion-k)")

-- vim-lion
vim.g.lion_map_left = "gh"
vim.g.lion_prompt_map = "<Tab>" -- (added in my fork)

-- toggle g:lion_squeeze_spaces
vim.keymap.set("n", "<leader>gl", function()
    vim.g.lion_squeeze_spaces = not vim.g.lion_squeeze_spaces
    vim.cmd("echo 'g:lion_squeeze_spaces "
        .. (vim.g.lion_squeeze_spaces and "ON" or "OFF")
        .. "'")
end)

-- undotree
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { remap = true })

-- undotree buffer default overwrites
vim.g.Undotree_CustomMap = function()
    vim.keymap.set("n", "q", "<Plug>Sneak_s", { buffer = 0 })                    -- undotree would map q to quit
    vim.keymap.set("n", "<C-q>", "<Plug>UndotreeClose", { buffer = 0 })
    vim.keymap.set("n", "U", "<Plug>UndotreeRedo", { buffer = 0 })
    vim.keymap.set("n", "J", "<Plug>UndotreePreviousSavedState", { buffer = 0 }) -- Note: PreviousSaved and NextSaved
    vim.keymap.set("n", "K", "<Plug>UndotreeNextSavedState", { buffer = 0 })     --       seem broken, jumping to
    vim.keymap.set("n", "<Tab>", "/", { buffer = 0 })                            --       wrong nodes or getting stuck
    vim.keymap.set("n", "C", "<Nop>", { buffer = 0 })
end

-- vim-dirvish
vim.keymap.set("n", "<C-PageUp>", "<Plug>(dirvish_up)") -- Other dirvish maps in ftplugin/dirvish.lua
