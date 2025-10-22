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
vim.opt.runtimepath:append("~/.local/share/nvim/site/pack/paqs/start/vim-sneak")
vim.opt.runtimepath:append("~/.local/share/nvim/site/pack/paqs/start/vim-edgemotion")
vim.opt.runtimepath:append("~/.local/share/nvim/site/pack/paqs/start/vim-sneak")
vim.opt.runtimepath:append("~/projects/mini.ai")   -- todo: rework motions

vim.g.loaded_netrwPlugin = 0 -- When unloading netrw, `nvimpager <dir>` shows a blank buffer in pager mode

vim.cmd.colorscheme("goodnight-pager")

vim.opt.shortmess:prepend("Ia")
vim.opt.fillchars:prepend("eob:󰧟")

vim.o.clipboard = "unnamedplus"
vim.o.guicursor = "a:block"
vim.o.mouse = ""

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
vim.keymap.set({"n", "x"}, "<Backspace>", "<Nop>")
vim.keymap.set({"n", "x"}, "<Enter>", "<Nop>")
vim.keymap.set({"n", "x"}, ":", "<Nop>")
vim.keymap.set({"n", "x"}, "gJ", "<Nop>")

-- Free (but bad):
vim.keymap.set({"n", "x", "c"}, "<PageUp>", "<Nop>")
vim.keymap.set({"n", "x", "c"}, "<PageDown>", "<Nop>")
vim.keymap.set("n", "<F1>", "<Nop>")

-- Pager specifics:
vim.keymap.set({"n", "x"}, "§", "<cmd>set number!<cr>")
vim.keymap.set({"n", "x"}, "<leader>§", "<cmd>set wrap!<cr>")

-- q key is free for future idea
vim.keymap.set({"n", "x"}, "<Del>", "q")
vim.keymap.set({"n", "x"}, "<S-Del>", "Q")
vim.keymap.set({"n", "x"}, "<M-Del>", "@")
vim.keymap.set({"n", "x"}, "<M-Del><M-Del>", "@@")

-- Give mark key to sneak
vim.keymap.set("n", "<Ins>", "m")

-- Tab to search, enter to command
vim.keymap.set({"n", "x", "o"}, "<Tab>", "/")
vim.keymap.set({"n", "x", "o"}, "<S-Tab>", "?")
vim.keymap.set({"n", "x"}, "<Enter>", ":")

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
vim.keymap.set("c", "<M-l>", "<C-Right>")
vim.keymap.set("c", "<M-Space>", "<C-Right>")
vim.keymap.set("c", "<M-h>", "<C-Left>")

-- Todo: nothing like 'emacs-*-word' in insert mode
vim.keymap.set("c", "<M-h>", "<C-Left>")
vim.keymap.set("c", "<M-l>", "<C-Right>")

vim.keymap.set("c", "<C-k>", "<Up>")
vim.keymap.set("c", "<C-j>", "<Down>")
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

-- Weird experimental mappings to enter some of the most annoying-to-type chars
vim.keymap.set("c", "<M-1>", "~/")
vim.keymap.set("c", "<M-2>", "&")

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
vim.keymap.set({"n", "x", "o"}, "<leader>k", "H")
vim.keymap.set({"n", "x", "o"}, "<leader><leader>", "M")
vim.keymap.set({"n", "x", "o"}, "<leader>j", "L")
vim.keymap.set({"n", "x"}, "?", "K")

-- (Experimental)
-- Shift+g slightly too annoying to press
vim.keymap.set({"n", "x", "o"}, "<M-Enter>", "G")
vim.keymap.set({"n", "x", "o"}, "<M-Backspace>", "gg")

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

-- Swap what was overriden above
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

-- One-handed quit
vim.keymap.set({"n", "x"}, "<C-q>", "<cmd>q<cr>")

-- Like yy but no newline at end
vim.keymap.set("n", "<C-y>", function()
    vim.fn.setreg(vim.v.register, vim.api.nvim_get_current_line())
end)

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
        inside_next = "ij",
        around_next = "aj",
        inside_last = "ik",
        around_last = "ak",

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
vim.g["sneak#prompt"] = ""
vim.g["sneak#label"] = true
vim.g["sneak#target_labels"] = "qwefnu1234,vbt-567890"
vim.keymap.set({"n", "x", "o"}, "m", "<Plug>Sneak_s")
vim.keymap.set({"n", "x", "o"}, "M", "<Plug>Sneak_S")
vim.keymap.set({"n", "x", "o"}, "f", "<Plug>Sneak_f")
vim.keymap.set({"n", "x", "o"}, "F", "<Plug>Sneak_F")
vim.keymap.set({"n", "x", "o"}, "t", "<Plug>Sneak_t")
vim.keymap.set({"n", "x", "o"}, "T", "<Plug>Sneak_T")

-- vim-edgemotion
vim.keymap.set({"n", "x", "o"}, "J", "<Plug>(edgemotion-j)")
vim.keymap.set({"n", "x", "o"}, "K", "<Plug>(edgemotion-k)")
