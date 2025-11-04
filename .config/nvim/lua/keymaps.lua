-- <leader> is <Space>
vim.keymap.set({"n", "x", "o"}, "<Space>", "<Nop>")
vim.g.mapleader = " "

-- Free keys:
vim.keymap.set({"n", "x"}, "Q", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<Up>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<Down>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<Left>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<Right>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "+", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<C-u>", "<Nop>")  -- <C-d> is remapped, and <C-j> <C-k> preferred for scrolling
vim.keymap.set({"n", "x", "o"}, "/", "<Nop>")      -- Tab/S-Tab as search, ? is now :help
vim.keymap.set("n", "<C-r>", "<Nop>")              -- U as redo
vim.keymap.set({"n", "x"}, "<C-e>", "<Nop>")       -- <M-s> and <M-d> are remapped as <C-e> and <C-y>
vim.keymap.set({"n", "x"}, "<Backspace>", "<Nop>")
vim.keymap.set({"n", "x"}, ":", "<Nop>")           -- <Enter> as :
vim.keymap.set({"n", "x"}, "0", "<Nop>")           -- <M-Esc> as 0
vim.keymap.set({"n", "x"}, "gJ", "<Nop>")          -- gå for spaceless join, leave gJ and gK
                                                   -- as ideas for vertical movement mappings
-- Free (but bad):
vim.keymap.set({"n", "x", "!"}, "<PageUp>", "<Nop>")
vim.keymap.set({"n", "x", "!"}, "<PageDown>", "<Nop>")
vim.keymap.set({"n", "i"}, "<F1>", "<Nop>")

-- q key is free for future idea
vim.keymap.set({"n", "x"}, "<Del>", "q")
vim.keymap.set({"n", "x"}, "<S-Del>", "Q")
vim.keymap.set({"n", "x"}, "<M-Del>", "@")
vim.keymap.set({"n", "x"}, "<M-Del><M-Del>", "@@")

-- Move the mark key to the edge of the keyboard to use m for sneak
vim.keymap.set("n", "<Ins>", "m")

-- Tab to search, enter to command
vim.keymap.set({"n", "x", "o"}, "<Tab>", "/")
vim.keymap.set({"n", "x", "o"}, "<S-Tab>", "?")
vim.keymap.set({"n", "x"}, "<Enter>", ":")

-- Dot-repeat on q
-- vim-repeat requires that it's a recursive map
vim.keymap.set({"n", "x"}, "q", ".", { remap = true })

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

-- Esc to clear cmdline text
-- Workaround for sneak: my mapping wouldn't allow sneak to quit with <Esc> when it's
-- clever-sneaking
vim.keymap.set("n", "<Esc>", function()
    vim.cmd("call sneak#cancel()")
    vim.cmd("echo ''")
end)

-- Command mode <C-f> special buffer fixes
vim.api.nvim_create_autocmd({"CmdWinEnter"}, {
    callback = function()
        vim.keymap.set("n", "<Enter>", "<Enter>", b)
    end
})

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
local function emacs_forward_word()
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
end

-- Basically a simple `B` is sufficient as a backwards variant,
-- but needs to skip empty lines
local function emacs_backward_word()
    vim.cmd("normal! B")

    -- Skip empty lines
    while vim.fn.getline(".") == "" do
        if vim.fn.line(".") == 1 then break end
        vim.cmd("normal! B")
    end
end

vim.keymap.set("i", "<M-l>", function() emacs_forward_word() end)
vim.keymap.set("i", "<M-Space>", function() emacs_forward_word() end)
vim.keymap.set("i", "<M-h>", function() emacs_backward_word() end)

-- Same idea in command mode (has differences with word delimiters)
vim.keymap.set("c", "<M-l>", "<C-Right>")
vim.keymap.set("c", "<M-Space>", "<C-Right>")
vim.keymap.set("c", "<M-h>", "<C-Left>")

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

-- Experimental
vim.keymap.set({"n", "x", "o"}, "<M-Esc>", "0")
vim.keymap.set("i", "<M-Esc>", "<Esc>0")

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
vim.keymap.set("n", "å", "<cmd>set opfunc=v:lua.J_motion<cr>g@")
vim.keymap.set("n", "gå", "<cmd>set opfunc=v:lua.gJ_motion<cr>g@")
vim.keymap.set("n", "åå", function()
    vim.api.nvim_feedkeys("å" .. vim.v.count1 .. "j", "m", true)
end)
vim.keymap.set("x", "å", "J")
vim.keymap.set("x", "gå", "gJ")

local textcommands = require("textcommands")
vim.keymap.set({"n", "x"}, "Z", function() textcommands.squeeze_spaces() end)
vim.keymap.set({"n", "x"}, "X", function() textcommands.delete_last_char() end)
vim.keymap.set({"n", "x"}, "<C-d>", function() textcommands.wipe_line() end)
vim.keymap.set({"n", "x", "i"}, "<C-o>", function() textcommands.surround_with_blanklines() end)

vim.keymap.set({"n", "x"}, "<C-p>", function()
    local join_by_space = true
    textcommands.append_paste(join_by_space)
end)
vim.keymap.set({"n", "x"}, "g<C-p>", function()
    local join_by_space = false
    textcommands.append_paste(join_by_space)
end)

-- Fix x (from being terrible)
-- To be fixed: would like consecutive xxxxxxx to be treated as a single undo item
-- (not simple)
vim.keymap.set("n", "x", function()
    local count = vim.v.count1
    if count > 1 then
        -- If count is given, you probably do want it in the register
        vim.cmd('normal! ' .. count .. "x")
    else
        vim.cmd('normal! "_' .. "x")
    end
end)

-- o O without changing mode
vim.keymap.set("n", "<M-o>", "o<Esc>")
vim.keymap.set("n", "<M-O>", "O<Esc>")
vim.keymap.set("i", "<M-o>", "<Esc>o")
vim.keymap.set("i", "<M-O>", "<Esc>O")

-- Surround cursor (or selection) with spaces
-- Todo: Half baked:
-- - dot repeat
-- - visual block mode
-- Maybe turn into a module similarly to textcommands.lua?
vim.keymap.set("!", "<C-Space>", "  <Left>")
vim.keymap.set("n", "<C-Space>", "i <Esc>la <Esc>h")
vim.keymap.set("x", "<C-Space>", "<Esc>`>a <Esc>`<i <Esc>l")

-- Without shift = forward, with shift = backward
vim.keymap.set("n", "<", ">")
vim.keymap.set("n", ">", "<")
vim.keymap.set("n", "<<", ">>")
vim.keymap.set("n", ">>", "<<")

-- Re-enter visual mode for spammability
vim.keymap.set("x", "<", ">gv")
vim.keymap.set("x", ">", "<gv")

-- Spammable changelist jump + free g; and g, for mini.ai motions
vim.keymap.set("n", "<M-i>", "g;")
vim.keymap.set("n", "<M-S-i>", "g,")

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
local custom = require("mini-ai-textobjects")

MiniAi.setup({
    mappings = {
        inside_next = "il",
        around_next = "al",
        inside_last = "ij",
        around_last = "aj",

        -- Builtin , and ; are surpassed by "clever" f/t/sneak
        goto_next_end = ",",
        goto_next_start = "g,",
        goto_prev_start = ";",
        goto_prev_end = "g;"
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

        -- Markdown (experimental)
        ["'"] = MiniAi.gen_spec.pair("*", "*", { type = "greedy" }),
        ["*"] = MiniAi.gen_spec.pair("*", "*", { type = "greedy" }),
        ["_"] = MiniAi.gen_spec.pair("_", "_", { type = "greedy" }),

        -- Custom
        ["Z"]  = custom.md_codeblock,
        ["i"]  = custom.indent,
        ["\r"] = custom.entire_buffer -- Enter

    },
    n_lines = 100,
    silent = true
})

-- mini.tpopesurround
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
        suffix_last = "j",

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


        ["Z"] = { input = { "```%s*%w*().-()```" }, output = { left = "```", right = "```" } },
        ["Q"] = { input = { '"""().-()"""' },       output = { left = '"""', right = '"""' } },

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
local MiniMove = require("mini.move")

MiniMove.setup({
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

vim.keymap.set("i", "<C-S-j>", function() MiniMove.move_line("down")  end)
vim.keymap.set("i", "<C-S-k>", function() MiniMove.move_line("up")    end)
vim.keymap.set("i", "<C-S-h>", function() MiniMove.move_line("left")  end)
vim.keymap.set("i", "<C-S-l>", function() MiniMove.move_line("right") end)

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
vim.keymap.set({"n", "x", "o"}, "m", "<Plug>Sneak_s")
vim.keymap.set({"n", "x", "o"}, "M", "<Plug>Sneak_S")
vim.keymap.set({"n", "x", "o"}, "f", "<Plug>Sneak_f")
vim.keymap.set({"n", "x", "o"}, "F", "<Plug>Sneak_F")
vim.keymap.set({"n", "x", "o"}, "t", "<Plug>Sneak_t")
vim.keymap.set({"n", "x", "o"}, "T", "<Plug>Sneak_T")

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
    vim.keymap.set("n", "<C-q>", "<Plug>UndotreeClose", { buffer = 0 })
    vim.keymap.set("n", "U", "<Plug>UndotreeRedo", { buffer = 0 })
    vim.keymap.set("n", "J", "<Plug>UndotreePreviousSavedState", { buffer = 0 }) -- Note: PreviousSaved and NextSaved
    vim.keymap.set("n", "K", "<Plug>UndotreeNextSavedState", { buffer = 0 })     --       seem broken, jumping to
    vim.keymap.set("n", "<Tab>", "/", { buffer = 0 })                            --       wrong nodes or getting stuck
    vim.keymap.set("n", "C", "<Nop>", { buffer = 0 })
end

-- vim-dirvish
vim.keymap.set("n", "<C-PageUp>", "<Plug>(dirvish_up)") -- Other dirvish maps in ftplugin/dirvish.lua
