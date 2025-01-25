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
map({"n", "x", "o"}, "+", "<Nop>")
map({"n", "x", "o"}, "M", "<Nop>")      -- H M L -> _ - Alt-
map({"n", "x", "o"}, "/", "<Nop>")      -- Tab/S-Tab as search, ? is now :help
map("n", "<C-r>", "<Nop>")              -- U as redo
map("n", "<C-o>", "<Nop>")              -- <C-i> is compromised so use <M-o> and <M-i>
map("n", "<C-h>", "<Nop>")
map("n", "<C-l>", "<Nop>")
map({"n", "x"}, "<C-e>", "<Nop>")       -- <M-j> and <M-k> are remapped as <C-e> and <C-y>
map({"n", "x"}, "<BS>", "<Nop>")
map({"n", "x"}, "gJ", "<Nop>")          -- g¤ for spaceless join, leave gJ and gK
                                        -- as ideas for vertical movement mappings

-- Free (but bad):
map({"n", "x", "i", "c"}, "<PageUp>", "<Nop>")
map({"n", "x", "i", "c"}, "<PageDown>", "<Nop>")
map({"n", "i"}, "<F1>", "<Nop>")

-- Prevent accidental invokings of macros
map({"n", "x"}, "Q", "q")
map({"n", "x"}, "q", "<Nop>")

-- The default Q is not bad but its default mapping is bad, here's a better alternative:
map("n", "<leader>@", "Q")

-- Tab to search
map({"n", "x", "o"}, "<Tab>", "/")
map({"n", "x", "o"}, "<S-Tab>", "?")

-- Remap jumplist maps: <C-i> and <Tab> are the same due to terminal weirdness
map("n", "<M-o>", "<C-o>")
map("n", "<M-i>", "<C-i>")

-- Start a substitute command without finger gymnastics:
map("n", "<leader><Tab>", ":%s/")

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

-- Command mode home row traversal alternatives
map("c", "<M-j>", "<Down>")
map("c", "<M-k>", "<Up>")
map("c", "<M-h>", "<C-Left>")
map("c", "<M-l>", "<C-Right>")

-- Comfortable movement keys:
map({"n", "x", "o"}, "<C-j>", "<C-d>")
map({"n", "x", "o"}, "<C-k>", "<C-u>")
map({"n", "x", "o"}, "<leader>j", "}")
map({"n", "x", "o"}, "<leader>k", "{")
map({"n", "x", "o"}, "H", "^")
map({"n", "x", "o"}, "L", "$")
map({"n", "x", "o"}, "gH", "g^")
map({"n", "x", "o"}, "gL", "g$")
map({"n", "x"}, "<M-j>", "<C-e>")
map({"n", "x"}, "<M-k>", "<C-y>")
map("n", "<M-h>", "zh")
map("n", "<M-l>", "zl")
map("i", "<C-h>", "<Left>")
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")
map("i", "<C-l>", "<Right>")
map("n", "<C-h>", "<cmd>bp<cr>")
map("n", "<C-l>", "<cmd>bn<cr>")

-- Remap what the above has overriden
map({"n", "x"}, "¤", "J")
map({"n", "x"}, "g¤", "gJ")
map({"i", "c"}, "<C-z>", "<C-k>")
map({"n", "x", "o"}, "_", "H")
map({"n", "x", "o"}, "-", "M")     -- dash
map({"n", "x", "o"}, "<M-->", "L") -- Alt + dash
map({"n", "x"}, "?", "K")

-- One-handed save and quit
map("n", "<C-s>", "<cmd>w<cr>")
map("n", "<C-q>", "<cmd>q<cr>")

-- Like yy dd cc but no newline at end
map("n", "<C-y>", function()
    vim.fn.setreg(vim.v.register, vim.api.nvim_get_current_line())
end)

-- TODO: visual line -mode counterpart where it leaves one empty line
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
map("n", "ö", "o<Esc>")
map("n", "Ö", "O<Esc>")

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

-- TODO: separate lines problem:
--
--       The way e.g. `ysip` doesn't put the surroundings on separate lines (like tpope/vim-surround does)
--       will not work for me.
--      
--       Think about yS mapping variant that turns on 'respect_selection_type'
--       (see tpope/vim-surround's yS mapping)
--
--       The yS mapping however is not an answer to the first problem. Consider forking mini.surround.

require("mini.surround").setup({
    -- Can't use s mappings because of sneak, use tpope style
    mappings = {
        add = "ys",
        delete = "ds",
        replace = "cs",
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
        ["c"] = { input = { "%b{}", "^.().*().$" }, output = { left = "{",  right = "}"  } },
        ["r"] = { input = { "%b[]", "^.().*().$" }, output = { left = "[",  right = "]"  } },
        ["<"] = { input = { "%b<>", "^.().*().$" }, output = { left = "<",  right = ">"  } },
        ["E"] = { input = { "%b()", "^.().*().$" }, output = { left = "( ", right = " )" } },
        ["C"] = { input = { "%b{}", "^.().*().$" }, output = { left = "{ ", right = " }" } },
        ["R"] = { input = { "%b[]", "^.().*().$" }, output = { left = "[ ", right = " ]" } },
        [">"] = { input = { "%b<>", "^.().*().$" }, output = { left = "< ", right = " >" } },

        -- Markdown (experimental)
        ["m"] = { input = { "%*().-()%*"     }, output = { left = "*",   right = "*"   } },
        ["M"] = { input = { "%*%*().-()%*%*" }, output = { left = "**",  right = "**"  } },
        ["x"] = { input = { "`().-()`"       }, output = { left = "`",   right = "`"   } },
        ["X"] = { input = { "```().-()```"   }, output = { left = "```", right = "```" } }

    },
    search_method = "cover_or_next",
    silent = true
})
vim.keymap.del("x", "ys")
map("x", "S", [[:<C-u>lua MiniSurround.add("visual")<CR>]], { silent = true })
map("n", "yss", "ys💩", r) -- workaround because I remap _, see above about mini.operators
map("n", "yS", "ys$", r)

-- mini.ai
-- todo: ? to <tab>
--       look at: https://github.com/echasnovski/mini.nvim/blob/f90b6b820062fc06d6d51ed61a0f9b7f9a13b01b/lua/mini/ai.lua#L1097

local spec_pair = require('mini.ai').gen_spec.pair

require("mini.ai").setup({
    custom_textobjects = {

        -- Anybracket equivalent for e.g. i(
        ["B"] = { { "%b()", "%b[]", "%b{}" }, "^.%s*().-()%s*.$" },

        -- Brackets aliases
        ["e"] = { "%b()", "^.().*().$" },
        ["c"] = { "%b{}", "^.().*().$" },
        ["r"] = { "%b[]", "^.().*().$" },
        ["<"] = { "%b<>", "^.().*().$" },
        ["E"] = { "%b()", "^.%s*().-()%s*.$" },
        ["C"] = { "%b{}", "^.%s*().-()%s*.$" },
        ["R"] = { "%b[]", "^.%s*().-()%s*.$" },
        [">"] = { "%b<>", "^.%s*().-()%s*.$" },

        -- Markdown (experimental)
        ["m"] = spec_pair("*", "*", { type = "greedy" }),
        ["M"] = spec_pair("*", "*", { type = "greedy" }),
        ["x"] = spec_pair("`", "`", { type = "greedy" }),
        ["X"] = spec_pair("`", "`", { type = "greedy" }),
        ["*"] = spec_pair("*", "*", { type = "greedy" }),
        ["_"] = spec_pair("_", "_", { type = "greedy" })

    },
    silent = true
})
map({"n", "x", "o"}, "<leader>q", "g]q", r) -- to next closing anyquote
map({"n", "x", "o"}, "<leader>b", "g]b", r) -- to next closing anybracket

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
g["sneak#s_next"] = true

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
