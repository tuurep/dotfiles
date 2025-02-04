-- Shorthands
local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local g = vim.g
local r = { remap = true }
local b = { buffer = 0 }

-- <leader> is <Space>
map({"n", "x", "o"}, "<Space>", "<Nop>")
g.mapleader = " "

-- Free keys:
map({"n", "x", "o"}, "<Up>", "<Nop>")
map({"n", "x", "o"}, "<Down>", "<Nop>")
map({"n", "x", "o"}, "<Left>", "<Nop>")
map({"n", "x", "o"}, "<Right>", "<Nop>")
map({"n", "x", "o"}, "M", "<Nop>")      -- H M L -> <leader>k <leader>m <leader>j
map({"n", "x", "o"}, "/", "<Nop>")      -- Tab/S-Tab as search, ? is now :help
map("n", "<C-r>", "<Nop>")              -- U as redo
map("n", "<C-o>", "<Nop>")              -- <C-i> is compromised so use <M-o> and <M-i>
map({"n", "x"}, "<C-e>", "<Nop>")       -- <M-s> and <M-d> are remapped as <C-e> and <C-y>
map({"n", "x"}, "<BS>", "<Nop>")
map({"n", "x"}, "gJ", "<Nop>")          -- g¤ for spaceless join, leave gJ and gK
                                        -- as ideas for vertical movement mappings

-- zh zl
-- gy gY
-- gz gZ
-- ä Ä      (and g or z prefix)
-- ö Ö      (and g or z prefix)
-- å Å      g or z prefix
-- ½

-- Practically free:
-- , ;      surpassed by clever-f/t/s
--          although only , and ; will repeat last f/t/s regardless of what it as

-- Free (but bad):
map({"n", "x", "i", "c"}, "<PageUp>", "<Nop>")
map({"n", "x", "i", "c"}, "<PageDown>", "<Nop>")
map({"n", "i"}, "<F1>", "<Nop>")

-- q/Q for macros problems:
--     1. it's easy to start recording a macro by accident
--     2. will conflict with visual mode Q surround mapping
map({"n", "x"}, "q", "<Nop>")
map({"n", "x"}, "Q", "<Nop>")
map({"n", "x"}, "+", "q")
map({"n", "x"}, "<leader>+", "Q")   -- Todo: maybe give ? to this and put :help somewhere else
map({"n", "x"}, "<M-+", "@")        -- @ too hard to press and too separated from the other macro mappings

-- Tab to search
map({"n", "x", "o"}, "<Tab>", "/")
map({"n", "x", "o"}, "<S-Tab>", "?")

-- Remap jumplist maps: <C-i> and <Tab> are the same due to terminal weirdness
map("n", "<M-n>", "<C-o>")
map("n", "<M-S-n>", "<C-i>")

-- Start a substitute command without finger gymnastics:
map("n", "<leader><Tab>", ":%s/")
map("x", "<leader><Tab>", ":s/")

map("n", "<M-Enter>", function()
    local path = vim.fn.expand("%")
    local tildepath = vim.fn.fnamemodify(path, ":p:~")
    if vim.fn.bufname() == "" then
        tildepath = tildepath .. "[No Name]"
    end
    vim.api.nvim_echo({{tildepath}}, false, {})      -- current buffer full path
end)                                                 -- $HOME as ~

map("n", "<leader><Enter>",
    "<cmd>echo fnamemodify(getcwd(), ':p:~')<cr>")    -- pwd but with tilde

map("n", "<Enter>", "<cmd>echo ''<cr>")               -- clear cmdline text

-- Command mode <C-f> special buffer fixes
autocmd({"CmdWinEnter"}, {
    callback = function()
        map("n", "<Enter>", "<Enter>", b) -- The above Enter mapping can't be used here
        map("n", "q", "<cmd>q<cr>", b)
        -- Todo: this window opens too small,
        --       how to make it behave like normal splits: take half of the
        --       available space above?
    end
})

-- Insert/command mode Ctrl+a for beginning of line, Ctrl+E for end of line (readline style)
-- If they override something, remap that elsewhere
map({"i", "c"}, "<C-a>", "<Home>")
map("i", "<C-e>", "<End>")
map({"i", "c"}, "<C-b>", "<C-a>") -- command mode: <C-b> == <Home>, insert mode: <C-b> is unmapped
map("i", "<M-i>", "<C-e>")

-- Insert mode bracket/quote aliases with autopair behavior
-- Todo: Turn into a plugin to better control when to indent and when not to
map("i", "<M-b>", "()<Left>")
map("i", "<M-e>", "()<Left>")
map("i", "<M-d>", "{}<Left>")
map("i", "<M-a>", "[]<Left>")
map("i", "<M-<>", "<><Left>")

map("i", "<M-B>",    "(  )<Left><Left>")
map("i", "<M-E>",    "(  )<Left><Left>")
map("i", "<M-D>",    "{  }<Left><Left>")
map("i", "<M-A>",    "[  ]<Left><Left>")
map("i", "<M-S-lt>", "<  ><Left><Left>") -- ">" would close the key tag

map("i", "<M-q>", '""<Left>')
map("i", "<M-r>", "''<Left>")
map("i", "<M-x>", "``<Left>")

map("i", "<M-Q>", '""""""<left><left><left>')
map("i", "<M-X>", "``````<Left><Left><Left>")

map("i", "<M-m>", "**<Left>")
map("i", "<M-M>", "****<Left><Left>")

map("i", "<M-Enter><M-b>", "()<left><Enter><Esc>O")
map("i", "<M-Enter><M-e>", "()<left><Enter><Esc>O")
map("i", "<M-Enter><M-d>", "{}<left><Enter><Esc>O")
map("i", "<M-Enter><M-a>", "[]<left><Enter><Esc>O")
map("i", "<M-Enter><M-<>", "<><left><Enter><Esc>O")

map("i", "<M-Enter><M-q>", '""<left><Enter><Esc>O')
map("i", "<M-Enter><M-r>", "''<left><Enter><Esc>O")
map("i", "<M-Enter><M-x>", "``<left><Enter><Esc>O")

map("i", "<M-Enter><M-Q>", '""""""<left><left><left><Enter><Esc>O')
map("i", "<M-Enter><M-X>", "``````<left><left><left><Enter><Esc>O")

map("i", "<M-Enter><M-m>", "**<left><Enter><Esc>O")
map("i", "<M-Enter><M-M>", "****<left><left><Enter><Esc>O")

-- Need these to avoid arrow keys
map("i", "<C-h>", "<Left>")
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")
map("i", "<C-l>", "<Right>")
map("i", "<M-h>", "<Left>")
map("i", "<M-j>", "<Down>")
map("i", "<M-k>", "<Up>")
map("i", "<M-l>", "<Right>")

-- TODO: need some changes and C-hjkl added
map("c", "<M-j>", "<Down>")
map("c", "<M-k>", "<Up>")
map("c", "<M-h>", "<C-Left>")
map("c", "<M-l>", "<C-Right>")

-- Essential keys for both movement and operator pending
-- (with the worst defaults known to man)
map({"n", "x", "o"}, "-", "}")
map({"n", "x", "o"}, "_", "{")
map({"n", "x", "o"}, "H", "^")
map({"n", "x", "o"}, "L", "$")
map({"n", "x", "o"}, "gH", "g^")
map({"n", "x", "o"}, "gL", "g$")

map("n", "<C-h>", "<cmd>bp<cr>")
map("n", "<C-l>", "<cmd>bn<cr>")

-- Remap what the above has overriden
map({"n", "x"}, "¤", "J")
map({"n", "x"}, "g¤", "gJ")
map({"i", "c"}, "<C-z>", "<C-k>")
map({"n", "x", "o"}, "<leader>k", "H")
map({"n", "x", "o"}, "<leader>m", "M") -- (pretty random choice)
map({"n", "x", "o"}, "<leader>j", "L")
map({"n", "x"}, "?", "K")

-- Group together similar mappings that move the view without moving the cursor
map({"n", "x"}, "<M-j>", "3<C-e>")
map({"n", "x"}, "<M-k>", "3<C-y>")
map({"n", "x"}, "<M-S-j>", "<C-e>")
map({"n", "x"}, "<M-S-k>", "<C-y>")
map({"n", "x"}, "<M-h>", "3zh")
map({"n", "x"}, "<M-l>", "3zl")
map({"n", "x"}, "<M-S-h>", "zh")
map({"n", "x"}, "<M-S-l>", "zl")
map({"n", "x"}, "zj", "zt")
map({"n", "x"}, "zk", "zb")

-- (Never used folds but) swap what was overriden above
map({"n", "x"}, "zt", "zk")
map({"n", "x"}, "zb", "zj")

-- One-handed save and quit
map("n", "<C-s>", "<cmd>w<cr>")
map("n", "<C-q>", "<cmd>q<cr>")

-- Like yy dd cc but no newline at end
map("n", "<C-y>", function()
    vim.fn.setreg(vim.v.register, vim.api.nvim_get_current_line())
end)

map("n", "<C-d>", '<C-y>0"_D', r) -- blackhole the deletion to not set unnamed reg
map("n", "<C-c>", '<C-y>0"_C', r) -- if another reg was chosen

-- Append register to current line as a oneliner
map("n", "<C-p>", function()
    local line = vim.api.nvim_get_current_line()
    local reg = vim.fn.getreg(vim.v.register)

    if reg ~= "" then
        local joined = reg:gsub("\n$", ""):gsub("^%s*", ""):gsub("%s+", " ")
        if line ~= "" then
            line = line .. " "
        end
        vim.api.nvim_set_current_line(line .. joined)
    end
    vim.cmd.normal("$")
end)

-- Visual mode variants
map("x", "<C-d>", function()
    -- Only in visual line selection, delete and leave one empty line
    if vim.fn.mode() == "V" then
        vim.cmd.normal("c") -- (does not stay in insert mode)
    end
end)
map("x", "<C-c>", "<Nop>")
map("x", "<C-y>", "<Nop>")
map("x", "<C-p>", "<Nop>") -- todo: this could make sense in visual block mode

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
map("n", "x", function() blackhole("x") end)
map("n", "X", function() blackhole("X") end)

-- o O normal mode companion
map("n", "<M-o>", "o<Esc>")
map("n", "<M-S-o>", "O<Esc>")

-- Without shift = forward, with shift = backward
map({"n", "x"}, "<", ">")
map({"n", "x"}, ">", "<")
map("n", "<<", ">>")
map("n", ">>", "<<")
map({"n", "x", "o"}, ",", ";")
map({"n", "x", "o"}, ";", ",")

-- Undo follows the same idea as above
-- Map <M-u> to WeirdUndo so it's still available when you want to use it (never)
map("n", "U", "<C-r>")
map("n", "<M-u>", "U")

-- ~ too hard to press for being so useful
map("n", "å", "~")
map("n", "gå", "g~")
map("n", "gåå", "g~~")

-- Treesitter tools
map("n", "<leader>e", "<cmd>Inspect<cr>")
map("n", "<leader>E", "<cmd>InspectTree<cr>")

-- Bigger lua functions
map("n", "Å", require("trailingwhite-toggle"))

-- ===== PLUGINS =====

-- mini.operators
local operators = require("mini.operators")
operators.setup({
    replace  = { prefix = "" },
    exchange = { prefix = "" }
})
operators.make_mappings(
    "replace", { textobject = "dp", line = "", selection = "" } -- in visual, P already does it
)
operators.make_mappings(
    "exchange", { textobject = "cx", line = "", selection = "X" }
)
-- The fact that I remap _ in operator-pending causes a (solvable) mess here:
-- https://github.com/echasnovski/mini.nvim/issues/1088
map("o", "💩", "_")
map("n", "dpp", "dp💩", r)
map("n", "cxx", "cx💩", r)
map("n", "gmm", "gm💩", r)
map("n", "g==", "g=💩", r)

map("n", "dP", "dp$", r)
map("n", "cX", "cx$", r)
map("n", "gM", "gm$", r)
map("n", "gS", "gs$", r)

-- mini.surround
-- todo: ? to <tab>
--       also it turns on unwanted search hl (look at plugin/search-improvements.lua)
-- todo: vim-wordmotion can make message noise on dot repeat

-- todo: fork -- https://github.com/tuurep/mini.tpopesurround

-- working on it
vim.opt.runtimepath:append("~/.config/nvim/plugin/mini.tpopesurround")

require("mini.tpopesurround").setup({
    mappings = {
        add = "q",
        delete = "qd",
        replace = "qr",

        add_visual = "Q",

        add_line = "qq",

        add_and_indent = "Q",
        replace_and_indent = "Qr",

        find = "",          -- todo: idk what to choose
        find_left = "",     -- todo: idk what to choose

        -- Disable
        update_n_lines = "",
        highlight = ""
    },
    custom_surroundings = {

        -- For cohesion with lowercase b
        ["B"] = { input = { { "%b()", "%b[]", "%b{}" }, "^.().*().$" }, output = { left = "( ", right = " )" }},

        -- Brackets aliases
        ["e"] = { input = { "%b()", "^.().*().$" }, output = { left = "(",  right = ")"  } },
        ["d"] = { input = { "%b{}", "^.().*().$" }, output = { left = "{",  right = "}"  } },
        ["a"] = { input = { "%b[]", "^.().*().$" }, output = { left = "[",  right = "]"  } },
        ["<"] = { input = { "%b<>", "^.().*().$" }, output = { left = "<",  right = ">"  } },
        ["E"] = { input = { "%b()", "^.().*().$" }, output = { left = "( ", right = " )" } },
        ["D"] = { input = { "%b{}", "^.().*().$" }, output = { left = "{ ", right = " }" } },
        ["A"] = { input = { "%b[]", "^.().*().$" }, output = { left = "[ ", right = " ]" } },
        [">"] = { input = { "%b<>", "^.().*().$" }, output = { left = "< ", right = " >" } },

        -- Quotation aliases (experimental)
        ["r"] = { input = { "%b''", "^.().*().$" }, output = { left = "'",   right = "'"   } },
        ["x"] = { input = { "%b``", "^.().*().$" }, output = { left = "`",   right = "`"   } },
        ["Q"] = { input = { '"""().-()"""'       }, output = { left = '"""', right = '"""' } },
        ["X"] = { input = { "```().-()```"       }, output = { left = "```", right = "```" } },

        -- Markdown (experimental)
        ["m"] = { input = { "%*().-()%*"     }, output = { left = "*",   right = "*"   } },
        ["M"] = { input = { "%*%*().-()%*%*" }, output = { left = "**",  right = "**"  } },

    },
    search_method = "cover_or_next",
    silent = true
})

-- mini.ai
-- todo: ? to <tab>
--       look at: https://github.com/echasnovski/mini.nvim/blob/f90b6b820062fc06d6d51ed61a0f9b7f9a13b01b/lua/mini/ai.lua#L1097

local gen_spec = require('mini.ai').gen_spec

require("mini.ai").setup({
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

        -- Quotation aliases (experimental)
        ["r"] = { "%b''", "^.().*().$" },
        ["x"] = { "%b``", "^.().*().$" },
        ["Q"] = { '"""().-()"""' },
        ["X"] = { "```().-()```" },

        -- Markdown (experimental)
        ["m"] = gen_spec.pair("*", "*", { type = "greedy" }),
        ["*"] = gen_spec.pair("*", "*", { type = "greedy" }),
        ["_"] = gen_spec.pair("_", "_", { type = "greedy" }),
        ["M"] = { "%*%*().-()%*%*" },

    },
    silent = true
})

require("mini.move").setup({
    mappings = {
        down =  '<C-S-j>',
        up =    '<C-S-k>',
        left =  '<C-S-h>',
        right = '<C-S-l>',

        line_down =  '<C-S-j>',
        line_up =    '<C-S-k>',
        line_left =  '<C-S-h>',
        line_right = '<C-S-l>'
    }
})

-- mini.indentscope
map({"n", "x", "o"}, "<leader>i", "]i", r) -- to current indentation level bottom edge
map({"n", "x", "o"}, "<leader>I", "[i", r) -- to current indentation level top edge

-- vim-sneak
map({"n", "x", "o"}, "f", "<Plug>Sneak_f")
map({"n", "x", "o"}, "F", "<Plug>Sneak_F")
map({"n", "x", "o"}, "t", "<Plug>Sneak_t")
map({"n", "x", "o"}, "T", "<Plug>Sneak_T")
map({"n", "x", "o"}, ",", "<Plug>Sneak_;")
map({"n", "x", "o"}, ";", "<Plug>Sneak_,")

-- allow sneak to use s in all cases, because surround is mapped to q
map({"x", "o"}, "s", "<Plug>Sneak_s")
map({"x", "o"}, "S", "<Plug>Sneak_S")

-- vim-edgemotion
map({"n", "x", "o"}, "J", "<Plug>(edgemotion-j)")
map({"n", "x", "o"}, "K", "<Plug>(edgemotion-k)")

-- vim-lion
g.lion_map_left = "gh"
g.lion_prompt_map = "<Tab>" -- (added in my fork)

-- toggle g:lion_squeeze_spaces
map("n", "<leader>gl", function()
    g.lion_squeeze_spaces = not g.lion_squeeze_spaces
    vim.cmd("echo 'g:lion_squeeze_spaces "
        .. (g.lion_squeeze_spaces and "ON" or "OFF")
        .. "'")
end)

-- undotree
map("n", "<leader>u", "<cmd>UndotreeToggle<cr>", r)

-- undotree buffer default overwrites
g.Undotree_CustomMap = function()
    map("n", "<C-q>", "<Plug>UndotreeClose", b)
    map("n", "U", "<Plug>UndotreeRedo", b)
    map("n", "J", "<Plug>UndotreePreviousSavedState", b) -- Note: PreviousSaved and NextSaved
    map("n", "K", "<Plug>UndotreeNextSavedState", b)     --       seem broken, jumping to
    map("n", "<Tab>", "/", b)                            --       wrong nodes or getting stuck
    map("n", "C", "<Nop>", b)
end

-- vim-dirvish
map("n", "<C-PageUp>", "<Plug>(dirvish_up)") -- Other dirvish maps in ftplugin/dirvish.lua
