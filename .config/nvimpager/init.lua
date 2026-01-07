-- init.lua for nvimpager
-- https://github.com/lucc/nvimpager

-- To use neovim as a pager, we can ignore any editing-related configuration

-- SETTINGS

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.cmd("normal! L") -- Put cursor on the last line of the first page
    end,
})

vim.loader.enable()

-- Leech plugins from nvim (paq)
vim.opt.runtimepath:append("~/.local/share/nvim/site/pack/paqs/start/vim-edgemotion")
vim.opt.runtimepath:append("~/.local/share/nvim/site/pack/paqs/start/vim-sneak")
vim.opt.runtimepath:append("~/projects/mini.ai")        -- todo: rework motions
vim.opt.runtimepath:append("~/projects/vim-wordmotion") -- done some fixes

vim.g.loaded_netrwPlugin = 0 -- When unloading netrw, `nvimpager <dir>` shows a blank buffer in pager mode
-- vim.g.loaded_matchparen = 0
vim.api.nvim_set_hl(0, "MatchParen", { link = "None" }) -- Workaround for Sneak problems

vim.cmd.colorscheme("goodnight-pager")

-- Copied from Kickstart, which says this makes startup faster
vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)

vim.opt.shortmess:prepend("Ia")
vim.opt.fillchars:prepend("eob:󰧟")

vim.o.guicursor = "a:block"

vim.opt.jumpoptions:append("view")

vim.o.laststatus = 1
vim.o.statusline = "%{expand('%t')} %r%m"

vim.o.cursorline = true -- Only for the LineNr highlight

vim.o.timeout = false
vim.o.showcmd = false
vim.o.ruler = false

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.splitright = true
vim.o.splitbelow = true

-- Avoid useless timeout error on `gx` when firefox isn't already open (it opens anyway)
vim.ui.open = function(url)
    vim.fn.jobstart({ "xdg-open", url }, { detach = true })
end

-- KEYMAPS

-- Disable nvimpager default keymaps
nvimpager.maps = false

vim.keymap.set({"n", "x", "o"}, "<Space>", "<Nop>")
vim.g.mapleader = " "

-- Free keys:
vim.keymap.set({"n", "x"}, "q", "<Nop>")
vim.keymap.set({"n", "x"}, "Q", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<Up>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<Down>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<Left>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<Right>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "+", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<C-u>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "/", "<Nop>")
vim.keymap.set("n", "<C-r>", "<Nop>")
vim.keymap.set("n", "<C-o>", "<Nop>")
vim.keymap.set({"n", "x"}, "<C-e>", "<Nop>")
vim.keymap.set({"n", "x"}, "<C-y>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<BS>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "0", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "G", "<Nop>")
vim.keymap.set({"n", "x"}, "gJ", "<Nop>")
vim.keymap.set("n", ":", "<Nop>")
vim.keymap.set("n", ".", "<Nop>")

-- Free (but bad):
vim.keymap.set({"n", "x", "c"}, "<PageUp>", "<Nop>")
vim.keymap.set({"n", "x", "c"}, "<PageDown>", "<Nop>")
vim.keymap.set("n", "<F1>", "<Nop>")

-- Pager specifics:
vim.keymap.set({"n", "x"}, "§", "<cmd>set number!<cr>")
vim.keymap.set({"n", "x"}, "<leader>§", "<cmd>set wrap!<cr>")

-- I almost never use macros, so move the key to the edge of the keyboard
vim.keymap.set({"n", "x"}, "<Del>", "q")
vim.keymap.set({"n", "x"}, "<S-Del>", "Q")
vim.keymap.set({"n", "x"}, "<M-Del>", "@")
vim.keymap.set({"n", "x"}, "<M-Del><M-Del>", "@@")

-- Todo: q key is free as it's mapped to dot-repeat
-- but could be put back as exit for readonly buffers
vim.keymap.set({"n", "x"}, "q", "<Nop>")

-- I literally never use marks, so move the key to the edge of the keyboard
-- Sneak gets m
vim.keymap.set("n", "<Ins>", "m")

-- Search and commandline remaps
vim.keymap.set({"n", "x", "o"}, "<Tab>", "/")
vim.keymap.set({"n", "x", "o"}, "<S-Tab>", "?")
vim.keymap.set({"n", "x"}, ".", ":")

-- Repeat last command
-- Todo: go further in history if it's an exit command
vim.keymap.set({"n", "x"}, ":", ":<Up><cr>", { silent = true })

-- Remap jumplist maps: <C-i> and <Tab> are the same due to terminal weirdness
vim.keymap.set("n", "<M-n>", "<C-o>")
vim.keymap.set("n", "<M-S-n>", "<C-i>")

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
-- vim.api.nvim_create_autocmd({"CmdWinEnter"}, {
--     callback = function()
--         vim.keymap.set("n", "<Enter>", "<Enter>", b)
--     end
-- })

-- Mappings like in zsh line editing {{{
vim.keymap.set("c", "<C-h>", "<Left>")
vim.keymap.set("c", "<C-l>", "<Right>")

vim.keymap.set("c", "<M-h>", "<C-Left>")
vim.keymap.set("c", "<M-l>", "<C-Right>")

vim.keymap.set("c", "<M-l>", "<C-Right>")
vim.keymap.set("c", "<M-Space>", "<C-Right>")
vim.keymap.set("c", "<M-h>", "<C-Left>")

vim.keymap.set("c", "<M-k>", "<Up>")
vim.keymap.set("c", "<M-j>", "<Down>")

vim.keymap.set("c", "<M-w>", "<C-w>") -- Todo: <C-w>
vim.keymap.set("c", "<M-u>", "<C-u>") -- Todo: <C-u>
                                      -- Todo: <M-U>
vim.keymap.set("c", "<M-H>", "<Home>")
vim.keymap.set("c", "<M-L>", "<End>")

-- Autopair-like mappings with the same aliases as mini.tpopesurround and mini.ai
vim.keymap.set("c", "<M-e>", "()<Left>")
vim.keymap.set("c", "<M-d>", "{}<Left>")
vim.keymap.set("c", "<M-a>", "[]<Left>")
vim.keymap.set("c", "<M-<>", "<><Left>")

vim.keymap.set("c", "<M-E>",    "(  )<Left><Left>")
vim.keymap.set("c", "<M-D>",    "{  }<Left><Left>")
vim.keymap.set("c", "<M-A>",    "[  ]<Left><Left>")
vim.keymap.set("c", "<M-S-lt>", "<  ><Left><Left>") -- ">" would close the key tag

vim.keymap.set("c", "<M-q>", '""<Left>')
vim.keymap.set("c", "<M-r>", "''<Left>")
vim.keymap.set("c", "<M-z>", "``<Left>")

vim.keymap.set("c", "<M-Q>", '""""""<left><left><left>')
vim.keymap.set("c", "<M-Z>", "``````<Left><Left><Left>")

vim.keymap.set("c", "<M-m>", "**<Left>")
vim.keymap.set("c", "<M-M>", "****<Left><Left>")

vim.keymap.set("c", "<C-Space>", "  <Left>")

-- Weird experimental mappings to enter some of the most annoying-to-type chars
vim.keymap.set("c", "<M-1>", "~/")
vim.keymap.set("c", "<M-2>", "&")
-- }}}

-- Essential keys for both movement and operator pending
-- (with the worst defaults known to man)
vim.keymap.set({"n", "x", "o"}, "H", "g^")
vim.keymap.set({"n", "x", "o"}, "L", "g$")
vim.keymap.set({"n", "x", "o"}, "<leader>h", "0")
vim.keymap.set({"n", "x", "o"}, "<leader>l", "$")

-- Remap what the above has overridden
vim.keymap.set("!", "<C-z>", "<C-k>")
vim.keymap.set({"n", "x", "o"}, "gk", "H")
vim.keymap.set({"n", "x", "o"}, "gg", function()
    if vim.v.count1 == 1 then
        vim.cmd("normal! M")
    else
        vim.cmd("normal! " .. vim.v.count1 .. "gg")
    end
end)
vim.keymap.set({"n", "x", "o"}, "gj", "L")
vim.keymap.set({"n", "x"}, "?", "K")

-- j/k traverses soft-wrapped lines
-- unless in Visual Line mode where that's quite bad
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("x", "j", function()
    if vim.api.nvim_get_mode().mode == "V" then
        return "j"
    else
        return "gj"
    end
end, { expr = true })
vim.keymap.set("x", "k", function()
    if vim.api.nvim_get_mode().mode == "V" then
        return "k"
    else
        return "gk"
    end
end, { expr = true })

-- Shift+g slightly too annoying to press
vim.keymap.set({"n", "x", "o"}, "<leader>j", "G")
vim.keymap.set({"n", "x", "o"}, "<leader>k", "gg")

-- (Todo: pager can't handle multiple files as arguments atm)
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

-- Swap what was overridden above
vim.keymap.set({"n", "x"}, "zt", "zk")
vim.keymap.set({"n", "x"}, "zb", "zj")

-- Like <C-d> and <C-u> but never moves the cursor relative to the 'view'
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

-- Mouse: Enable scrolling, disable most of everything else
vim.keymap.set({"n", "x"}, "<ScrollWheelDown>", function() scroll(1) end) -- Todo: abysmal performance in diff views?
vim.keymap.set({"n", "x"}, "<ScrollWheelUp>", function() scroll(-1) end)
vim.keymap.set({"n", "x"}, "<C-ScrollWheelDown>", function() scroll(6) end)
vim.keymap.set({"n", "x"}, "<C-ScrollWheelUp>", function() scroll(-6) end)
vim.keymap.set({"n", "x"}, "<M-ScrollWheelDown>", "<C-e>")
vim.keymap.set({"n", "x"}, "<M-ScrollWheelUp>", "<C-y>")
vim.keymap.set({"n", "x", "o"}, "<ScrollWheelRight>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<ScrollWheelLeft>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<C-ScrollWheelRight>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<C-ScrollWheelLeft>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<LeftMouse>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<2-LeftMouse>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<3-LeftMouse>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<4-LeftMouse>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<RightMouse>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<2-RightMouse>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<3-RightMouse>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<4-RightMouse>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<MiddleMouse>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<2-MiddleMouse>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<3-MiddleMouse>", "<Nop>")
vim.keymap.set({"n", "x", "o"}, "<4-MiddleMouse>", "<Nop>")

-- One-handed quit
vim.keymap.set({"n", "x"}, "<C-q>", "<cmd>q<cr>")

-- Sensible undo
vim.keymap.set("n", "U", "<C-r>")
vim.keymap.set("n", "<M-u>", "U")

-- Treesitter tools
vim.keymap.set("n", "<leader>e", "<cmd>Inspect<cr>")
vim.keymap.set("n", "<leader>E", "<cmd>InspectTree<cr>")

-- ===== PLUGINS =====

-- mini.ai
local MiniAi = require("mini.ai")
local custom = require("mini-ai-textobjects")

require("mini.ai").setup({
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

-- vim-sneak
vim.g["sneak#s_next"] = true
vim.g["sneak#use_ic_scs"] = true
vim.g["sneak#label"] = true
vim.g["sneak#target_labels"] = "wefnuz123,vbt.4567890"
vim.keymap.set({"n", "x", "o"}, "m", "<Plug>Sneak_s")
vim.keymap.set({"n", "x", "o"}, "M", "<Plug>Sneak_S")
vim.keymap.set({"n", "x", "o"}, "f", "<Plug>Sneak_f")
vim.keymap.set({"n", "x", "o"}, "F", "<Plug>Sneak_F")
vim.keymap.set({"n", "x", "o"}, "t", "<Plug>Sneak_t")
vim.keymap.set({"n", "x", "o"}, "T", "<Plug>Sneak_T")

-- vim-edgemotion
vim.keymap.set({"n", "x", "o"}, "J", "<Plug>(edgemotion-j)")
vim.keymap.set({"n", "x", "o"}, "K", "<Plug>(edgemotion-k)")
