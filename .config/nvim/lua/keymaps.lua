-- <leader> is <Space>
vim.keymap.set({"n", "x", "o"}, "<Space>", "<Nop>")
vim.g.mapleader = " "

-- Free keys:
vim.keymap.set({"n", "x", "o"}, "<Up>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<Down>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<Left>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<Right>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "+", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<C-d>", "<Nop>")  -- <C-d> is remapped, and <C-j> <C-k> preferred for scrolling
vim.keymap.set({"n", "x", "o"}, "/", "<Nop>")      -- Tab/S-Tab as search, ? is now :help
vim.keymap.set("n", "<C-r>", "<Nop>")              -- U as redo
vim.keymap.set("n", "<C-o>", "<Nop>")              -- <C-i> is compromised so use <M-o> and <M-i>
vim.keymap.set({"n", "x"}, "<C-e>", "<Nop>")       -- <M-s> and <M-d> are remapped as <C-e> and <C-y>
vim.keymap.set({"n", "x"}, "<Backspace>", "<Nop>")
vim.keymap.set({"n", "x"}, "gJ", "<Nop>")          -- gä for spaceless join, leave gJ and gK
                                                   -- as ideas for vertical movement mappings
-- ½
-- zh zl
-- gy gY
-- gz gZ
-- gä gÄ zä zÄ
-- gö gÖ zö zÖ
-- gÅ zå zå

-- Practically free:
-- , ;      surpassed by clever-f/t/s
--          although only , and ; will repeat last f/t/s regardless of what it was

-- Free (but bad):
vim.keymap.set({"n", "x", "i", "c"}, "<PageUp>", "<Nop>")
vim.keymap.set({"n", "x", "i", "c"}, "<PageDown>", "<Nop>")
vim.keymap.set({"n", "i"}, "<F1>", "<Nop>")

-- Give macro keys to mini.tpopesurround
vim.keymap.set({"n", "x"}, "<Del>", "q")
vim.keymap.set({"n", "x"}, "<S-Del>", "Q")
vim.keymap.set({"n", "x"}, "<M-Del>", "@") -- @ too hard to press and too separated from the other macro mappings

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
    vim.api.nvim_echo({{tildepath}}, false, {})  -- current buffer full path
end)                                             -- $HOME as ~

vim.keymap.set("n", "<leader><Backspace>",
    "<cmd>echo fnamemodify(getcwd(), ':p:~')<cr>") -- pwd but with tilde

vim.keymap.set("n", "<Enter>", "<cmd>echo ''<cr>") -- clear cmdline text

-- Command mode <C-f> special buffer fixes
vim.api.nvim_create_autocmd({"CmdWinEnter"}, {
    callback = function()
        vim.keymap.set("n", "<Enter>", "<Enter>", { buffer = 0 }) -- The above Enter mapping can't be used here
        vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = 0 })
        -- Todo: this window opens too small,
        --       how to make it behave like normal splits: take half of the
        --       available space above?
    end
})

-- Insert/command mode Ctrl+a for beginning of line, Ctrl+E for end of line (readline style)
-- If they override something, remap that elsewhere
vim.keymap.set({"i", "c"}, "<C-a>", "<Home>")
vim.keymap.set("i", "<C-e>", "<End>")
vim.keymap.set({"i", "c"}, "<C-b>", "<C-a>") -- command mode: <C-b> == <Home>, insert mode: <C-b> is unmapped
vim.keymap.set("i", "<M-i>", "<C-e>")

-- Insert mode bracket/quote aliases with autopair behavior
-- Todo: Turn into a plugin to better control when to indent and when not to
vim.keymap.set("i", "<M-b>", "()<Left>")
vim.keymap.set("i", "<M-e>", "()<Left>")
vim.keymap.set("i", "<M-d>", "{}<Left>")
vim.keymap.set("i", "<M-a>", "[]<Left>")
vim.keymap.set("i", "<M-<>", "<><Left>")

vim.keymap.set("i", "<M-B>",    "(  )<Left><Left>")
vim.keymap.set("i", "<M-E>",    "(  )<Left><Left>")
vim.keymap.set("i", "<M-D>",    "{  }<Left><Left>")
vim.keymap.set("i", "<M-A>",    "[  ]<Left><Left>")
vim.keymap.set("i", "<M-S-lt>", "<  ><Left><Left>") -- ">" would close the key tag

vim.keymap.set("i", "<M-q>", '""<Left>')
vim.keymap.set("i", "<M-r>", "''<Left>")
vim.keymap.set("i", "<M-x>", "``<Left>")

vim.keymap.set("i", "<M-Q>", '""""""<left><left><left>')
vim.keymap.set("i", "<M-X>", "``````<Left><Left><Left>")

vim.keymap.set("i", "<M-m>", "**<Left>")
vim.keymap.set("i", "<M-M>", "****<Left><Left>")

vim.keymap.set("i", "<M-Enter><M-b>", "()<left><Enter><Esc>O")
vim.keymap.set("i", "<M-Enter><M-e>", "()<left><Enter><Esc>O")
vim.keymap.set("i", "<M-Enter><M-d>", "{}<left><Enter><Esc>O")
vim.keymap.set("i", "<M-Enter><M-a>", "[]<left><Enter><Esc>O")
vim.keymap.set("i", "<M-Enter><M-<>", "<><left><Enter><Esc>O")

vim.keymap.set("i", "<M-Enter><M-q>", '""<left><Enter><Esc>O')
vim.keymap.set("i", "<M-Enter><M-r>", "''<left><Enter><Esc>O")
vim.keymap.set("i", "<M-Enter><M-x>", "``<left><Enter><Esc>O")

vim.keymap.set("i", "<M-Enter><M-Q>", '""""""<left><left><left><Enter><Esc>O')
vim.keymap.set("i", "<M-Enter><M-X>", "``````<left><left><left><Enter><Esc>O")

vim.keymap.set("i", "<M-Enter><M-m>", "**<left><Enter><Esc>O")
vim.keymap.set("i", "<M-Enter><M-M>", "****<left><left><Enter><Esc>O")

-- Need these to avoid arrow keys
-- Todo: Ctrk+hjkl full word navigation?
--       Try to make consistent with bash
--       Problem: Ctrl+l for `clear` so useful in bash
vim.keymap.set({"i", "c"}, "<M-h>", "<Left>")
vim.keymap.set({"i", "c"}, "<M-j>", "<Down>")
vim.keymap.set({"i", "c"}, "<M-k>", "<Up>")
vim.keymap.set({"i", "c"}, "<M-l>", "<Right>")

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
vim.keymap.set({"i", "c"}, "<C-z>", "<C-k>")
vim.keymap.set({"n", "x", "o"}, "<leader>k", "H")
vim.keymap.set({"n", "x", "o"}, "<leader><leader>", "M")
vim.keymap.set({"n", "x", "o"}, "<leader>j", "L")
vim.keymap.set({"n", "x"}, "?", "K")

-- Shift+g slightly too annoying to press
vim.keymap.set({"n", "x", "o"}, "<M-Enter>", "G")
vim.keymap.set({"n", "x", "o"}, "<M-Backspace>", "gg")

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

-- One-handed save and quit
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>")
vim.keymap.set("n", "<C-q>", "<cmd>q<cr>")

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
vim.keymap.set("n", "<C-p>", function()
    local line = vim.api.nvim_get_current_line()
    local reg = vim.fn.getreg(vim.v.register)

    if reg ~= "" then
        local joined = reg:gsub("\n$", ""):gsub("^%s*", ""):gsub("%s+", " ")
        if line ~= "" then
            line = line .. " "
        end
        vim.api.nvim_set_current_line(line .. joined)
    end
    vim.cmd.normal({ "$", bang = true })
end)

-- Visual mode variants
vim.keymap.set("x", "<C-d>", function()
    -- Only in visual line selection, delete and leave one empty line
    if vim.fn.mode() == "V" then
        vim.cmd.normal({ "c", bang = true }) -- (does not stay in insert mode)
    end
end)
vim.keymap.set("x", "<C-c>", "<Nop>")
vim.keymap.set("x", "<C-y>", "<Nop>")
vim.keymap.set("x", "<C-p>", "<Nop>") -- todo: this could make sense in visual block mode

-- Fix x and X (from being terrible)
-- To be fixed: would like consecutive xxxxxxx to be treated as a single undo item
-- (not simple)
local function blackhole(key)
    local c = vim.v.count
    if c > 0 then
        vim.cmd('normal! ' .. c .. key)
    else
        vim.cmd('normal! "_' .. key)
    end
end
vim.keymap.set("n", "<M-d>", function() blackhole("x") end)
vim.keymap.set("n", "<M-D>", function() blackhole("X") end)

-- Reimplementation of default s for consistency with <M-d> above
vim.keymap.set("n", "<M-c>", function() blackhole("x") vim.fn.feedkeys("i") end)

-- o O normal mode companion
vim.keymap.set("n", "<M-o>", "o<Esc>")
vim.keymap.set("n", "<M-O>", "O<Esc>")

-- Without shift = forward, with shift = backward
vim.keymap.set({"n", "x"}, "<", ">")
vim.keymap.set({"n", "x"}, ">", "<")
vim.keymap.set("n", "<<", ">>")
vim.keymap.set("n", ">>", "<<")
vim.keymap.set({"n", "x", "o"}, ",", ";")
vim.keymap.set({"n", "x", "o"}, ";", ",")

-- Undo follows the same idea as above
-- Map <M-u> to WeirdUndo so it's still available when you want to use it (never)
vim.keymap.set("n", "U", "<C-r>")
vim.keymap.set("n", "<M-u>", "U")

-- ~ too hard to press for being so useful
vim.keymap.set({"n", "x"}, "ä", "~")
vim.keymap.set("n", "ää", "~~")
vim.keymap.set("n", "Ä", "~$")

-- Treesitter tools
vim.keymap.set("n", "<leader>e", "<cmd>Inspect<cr>")
vim.keymap.set("n", "<leader>E", "<cmd>InspectTree<cr>")

-- Bigger lua functions
vim.keymap.set({"n", "x"}, "¤", require("trailingwhite-toggle"))

-- ===== PLUGINS =====

-- mini.splitjoin
local splitjoin = require("mini.splitjoin")
splitjoin.setup({
    mappings = {
        toggle = "Å"
    },
    join = {
        hooks_post = {
            splitjoin.gen_hook.pad_brackets({ brackets = { '%b{}' } })
        }
    }
})

-- mini.operators
local operators = require("mini.operators")
operators.setup({
    replace  = { prefix = "dp", selection = "p" },
    exchange = { prefix = "x", cancel = "<Esc>" },
    multiply = { prefix = "ö"  },
    evaluate = { prefix = "g." }
})

-- Make P the one that puts the replaced part in default register
-- because now p doesn't.
-- Todo: make that preserve indent as well.
--       (but I want this more generally for p/P in every mode)
--       (relevant plugin: vim-pasta)
vim.keymap.set("x", "P", "p")

vim.keymap.set("n", "dP", "dp$", { remap = true })
vim.keymap.set("n", "X",  "x$",  { remap = true })
vim.keymap.set("n", "Ö",  "ö$",  { remap = true })
vim.keymap.set("n", "gS", "gs$", { remap = true })
vim.keymap.set("n", "g:", "g.$", { remap = true })

-- mini.surround
-- todo: vim-wordmotion can make message noise on dot repeat

require("mini.tpopesurround").setup({
    mappings = {
        add = "q",
        delete = "qd",
        replace = "qr",

        add_visual = "q",

        add_and_indent = "<M-q>",
        replace_and_indent = "<M-q>r",

        add_line = "qq",
        add_line_and_indent = "<M-q><M-q>",

        -- Disable
        find = "",
        find_left = "",
        update_n_lines = "",
        highlight = ""
    },
    custom_surroundings = {

        -- For cohesion with lowercase b
        ["B"] = { input = { { "%b()", "%b[]", "%b{}" }, "^.().*().$" }, output = { left = "( ", right = " )" }},

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
        ["r"] = { input = { "%b''", "^.().*().$" }, output = { left = "'",   right = "'"   } },
        ["x"] = { input = { "%b``", "^.().*().$" }, output = { left = "`",   right = "`"   } },
        ["Q"] = { input = { '"""().-()"""'       }, output = { left = '"""', right = '"""' } },
        ["X"] = { input = { "```().-()```"       }, output = { left = "```", right = "```" } },

        -- Markdown
        ["m"] = { input = { "%*().-()%*"     }, output = { left = "*",   right = "*"  } },
        ["M"] = { input = { "%*%*().-()%*%*" }, output = { left = "**",  right = "**" } },

        -- <Tab> to prompt for surroundings
        -- Taken straight from the builtin ? surrounding:
        -- https://github.com/echasnovski/mini.surround/blob/f90069c7441a5fb04c3de42eacf93e16b64dd3eb/lua/mini/surround.lua#L1091-L1107
        ["\t"] = {
            input = function()
                local left = MiniSurround.user_input("Left surrounding")
                if left == nil or left == "" then return end
                local right = MiniSurround.user_input("Right surrounding")
                if right == nil or right == "" then return end

                return { vim.pesc(left) .. "().-()" .. vim.pesc(right) }
            end,
            output = function()
                local left = MiniSurround.user_input("Left surrounding")
                if left == nil then return end
                local right = MiniSurround.user_input("Right surrounding")
                if right == nil then return end
                return { left = left, right = right }
            end,
        },

    },
    search_method = "cover_or_next",
    silent = true
})
vim.keymap.set("n", "Q", "q$", { remap = true })
vim.keymap.set("n", "<M-Q>", "<M-q>$", { remap = true })

-- mini.ai

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

local gen_spec = require("mini.ai").gen_spec

require("mini.ai").setup({
    mappings = {
        goto_right = "m",
        goto_left = "M"
    },
    custom_textobjects = {

        -- Remap 'argument' textobject, I want it for square bracket
        ["v"] = gen_spec.argument(),

        -- Anybracket equivalent for e.g. i(
        ["B"] = { { "%b()", "%b[]", "%b{}" }, "^.%s*().-()%s*.$" },

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
        ["x"] = { "%b``", "^.().*().$" },
        ["Q"] = { '"""().-()"""' },
        ["X"] = { "```().-()```" },

        -- Markdown
        ["m"] = gen_spec.pair("*", "*", { type = "greedy" }),
        ["*"] = gen_spec.pair("*", "*", { type = "greedy" }),
        ["_"] = gen_spec.pair("_", "_", { type = "greedy" }),
        ["M"] = { "%*%*().-()%*%*" },

        ["i"] = ai_indent

    },
    n_lines = 100,
    silent = true
})

-- Lazy way to set <Tab> as builtin mini.ai `?` textobject
-- Uses many helpers inside the mini.ai module:
-- https://github.com/echasnovski/mini.ai/blob/6e01c0e5a15554852546fac9853960780ac52ed4/lua/mini/ai.lua#L1099-L1115
-- Todo: see if I could achieve it anyway
vim.keymap.set({"o", "x"}, "i<Tab>",  "i?",  { remap = true })
vim.keymap.set({"o", "x"}, "in<Tab>", "in?", { remap = true })
vim.keymap.set({"o", "x"}, "il<Tab>", "il?", { remap = true })
vim.keymap.set({"o", "x"}, "a<Tab>",  "a?",  { remap = true })
vim.keymap.set({"o", "x"}, "an<Tab>", "an?", { remap = true })
vim.keymap.set({"o", "x"}, "al<Tab>", "al?", { remap = true })

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

-- vim-sneak
vim.keymap.set({"n", "x", "o"}, "f", "<Plug>Sneak_f")
vim.keymap.set({"n", "x", "o"}, "F", "<Plug>Sneak_F")
vim.keymap.set({"n", "x", "o"}, "t", "<Plug>Sneak_t")
vim.keymap.set({"n", "x", "o"}, "T", "<Plug>Sneak_T")
vim.keymap.set({"n", "x", "o"}, ",", "<Plug>Sneak_;")
vim.keymap.set({"n", "x", "o"}, ";", "<Plug>Sneak_,")

-- allow sneak to use s in all cases, because surround is mapped to q
vim.keymap.set({"x", "o"}, "s", "<Plug>Sneak_s")
vim.keymap.set({"x", "o"}, "S", "<Plug>Sneak_S")

-- vim-edgemotion
vim.keymap.set({"n", "x", "o"}, "J", "<Plug>(edgemotion-j)")
vim.keymap.set({"n", "x", "o"}, "K", "<Plug>(edgemotion-k)")

-- vim-lion
vim.g.lion_map_left = "gh"
vim.g.lion_prompt_map = "<Tab>" -- (added in my fork)

-- toggle g:lion_squeeze_spaces
vim.keymap.set("n", "<leader>gl", function()
    g.lion_squeeze_spaces = not g.lion_squeeze_spaces
    vim.cmd("echo 'g:lion_squeeze_spaces "
        .. (g.lion_squeeze_spaces and "ON" or "OFF")
        .. "'")
end)

-- undotree
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { remap = true })

-- undotree buffer default overwrites
vim.g.Undotree_CustomMap = function()
    vim.keymap.set("n", "<C-q>", "<Plug>UndotreeClose", { buffer = 0 })
    vim.keymap.set("n", "U", "<Plug>UndotreeRedo", { buffer = 0 })
    vim.keymap.set("n", "J", "<Plug>UndotreePreviousSavedState", { buffer = 0 }) -- Note: PreviousSaved and NextSaved
    vim.keymap.set("n", "K", "<Plug>UndotreeNextSavedState", { buffer = 0 })     --       seem broken, jumping to
    vim.keymap.set("n", "<Tab>", "/", { buffer = 0 })                            --       wrong nodes or getting stuck
    vim.keymap.set("n", "C", "<Nop>", { buffer = 0 })
end

-- vim-dirvish
vim.keymap.set("n", "<C-PageUp>", "<Plug>(dirvish_up)") -- Other dirvish maps in ftplugin/dirvish.lua
