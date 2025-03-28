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
vim.opt.runtimepath:append("~/projects/mini.ai")

vim.g.loaded_netrwPlugin = 0 -- When unloading netrw, `nvimpager <dir>` shows a blank buffer in pager mode

vim.cmd.colorscheme("goodnight-pager")

vim.opt.shortmess:prepend("Ia")
vim.opt.fillchars:prepend("eob:󰧟")

vim.o.clipboard = "unnamedplus"
vim.o.guicursor = "a:block"
vim.o.mouse = ""

vim.o.laststatus = 1
vim.o.statusline = "%t %r%m"

vim.o.cursorline = true -- Only for the LineNr highlight

vim.o.timeout = false
vim.o.showcmd = false
vim.o.ruler = false

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.splitright = true
vim.o.splitbelow = true

-- KEYMAPS

-- Disable nvimpager default keymaps
nvimpager.maps = false

vim.keymap.set({"n", "x", "o"}, "<Space>", "<Nop>")
vim.g.mapleader = " "

-- Pager specifics:
vim.keymap.set({"n", "x"}, "§", "<cmd>set number!<cr>")
vim.keymap.set({"n", "x"}, "<leader>§", "<cmd>set wrap!<cr>")

-- Remap macros
vim.keymap.set({"n", "x"}, "q", "<Nop>")
vim.keymap.set({"n", "x"}, "Q", "<Nop>")
vim.keymap.set({"n", "x"}, "<Del>", "q")
vim.keymap.set({"n", "x"}, "<S-Del>", "Q")
vim.keymap.set({"n", "x"}, "<M-Del>", "@")

-- Give mark key to `mini.ai` textobject motions
vim.keymap.set("n", "<Ins>", "m")

-- Tab to search
vim.keymap.set({"n", "x", "o"}, "<Tab>", "/")
vim.keymap.set({"n", "x", "o"}, "<S-Tab>", "?")

-- Remap jumplist maps: <C-i> and <Tab> are the same due to terminal weirdness
vim.keymap.set("n", "<M-n>", "<C-o>")
vim.keymap.set("n", "<M-S-n>", "<C-i>")

vim.keymap.set("n", "<leader><Enter>", function()
    local path = vim.fn.expand("%")
    local tildepath = vim.fn.fnamemodify(path, ":p:~")
    if vim.fn.bufname() == "" then
        tildepath = tildepath .. "[No Name]"
    end
    vim.api.nvim_echo({{tildepath}}, false, {})      -- current buffer full path
end)                                                 -- $HOME as ~

vim.keymap.set("n", "<leader><Backspace>",
    "<cmd>echo fnamemodify(getcwd(), ':p:~')<cr>")    -- pwd but with tilde

vim.keymap.set("n", "<Enter>", "<cmd>echo ''<cr>")               -- clear cmdline text

-- Command mode <C-f> special buffer fixes
vim.api.nvim_create_autocmd({"CmdWinEnter"}, {
    callback = function()
        vim.keymap.set("n", "<Enter>", "<Enter>", b) -- The above Enter mapping can't be used here
        vim.keymap.set("n", "q", "<cmd>q<cr>", b)
        -- Todo: this window opens too small,
        --       how to make it behave like normal splits: take half of the
        --       available space above?
    end
})

-- Insert/command mode Ctrl+a for beginning of line, Ctrl+E for end of line (readline style)
-- If they override something, remap that elsewhere
vim.keymap.set({"c"}, "<C-a>", "<Home>")
vim.keymap.set({"c"}, "<C-b>", "<C-a>") -- command mode: <C-b> == <Home>, insert mode: <C-b> is unmapped

-- Command mode home row traversal alternatives
vim.keymap.set("c", "<M-j>", "<Down>")
vim.keymap.set("c", "<M-k>", "<Up>")
vim.keymap.set("c", "<M-h>", "Left>")
vim.keymap.set("c", "<M-l>", "Right>")

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

-- One-handed quit
vim.keymap.set({"n", "x"}, "<C-q>", "<cmd>q<cr>")

-- Like yy but no newline at end
vim.keymap.set("n", "<C-y>", function()
    vim.fn.setreg(vim.v.register, vim.api.nvim_get_current_line())
end)

-- Without shift = forward, with shift = backward
vim.keymap.set({"n", "x", "o"}, ",", ";")
vim.keymap.set({"n", "x", "o"}, ";", ",")

-- Undo follows the same idea as above
-- Map <M-u> to WeirdUndo so it's still available when you want to use it (never)
vim.keymap.set("n", "U", "<C-r>")
vim.keymap.set("n", "<M-u>", "U")

-- Treesitter tools
vim.keymap.set("n", "<leader>e", "<cmd>Inspect<cr>")
vim.keymap.set("n", "<leader>E", "<cmd>InspectTree<cr>")

-- ===== PLUGINS =====

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

local gen_spec = require('mini.ai').gen_spec

require("mini.ai").setup({
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
        
        -- Remap 'argument' textobject, I want it for square bracket
        ["v"] = gen_spec.argument(),

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
        ["q"] = { '%b""', "^.().*().$" },
        ["Q"] = { '"""().-()"""' },
        ["X"] = { "```().-()```" },

        -- Markdown
        ["*"] = gen_spec.pair("*", "*", { type = "greedy" }),
        ["_"] = gen_spec.pair("_", "_", { type = "greedy" }),

        ["i"] = ai_indent

    },
    n_lines = 100,
    silent = true
})
vim.keymap.set({"o", "x"}, "i<Tab>",  "i?",  { remap = true })
vim.keymap.set({"o", "x"}, "il<Tab>", "il?", { remap = true })
vim.keymap.set({"o", "x"}, "ih<Tab>", "ih?", { remap = true })
vim.keymap.set({"o", "x"}, "a<Tab>",  "a?",  { remap = true })
vim.keymap.set({"o", "x"}, "al<Tab>", "al?", { remap = true })
vim.keymap.set({"o", "x"}, "ah<Tab>", "ah?", { remap = true })

-- vim-sneak
vim.g["sneak#s_next"] = true
vim.g["sneak#use_ic_scs"] = true
vim.keymap.set({"n", "x", "o"}, "f", "<Plug>Sneak_f")
vim.keymap.set({"n", "x", "o"}, "F", "<Plug>Sneak_F")
vim.keymap.set({"n", "x", "o"}, "t", "<Plug>Sneak_t")
vim.keymap.set({"n", "x", "o"}, "T", "<Plug>Sneak_T")
vim.keymap.set({"n", "x", "o"}, ",", "<Plug>Sneak_;")
vim.keymap.set({"n", "x", "o"}, ";", "<Plug>Sneak_,")
vim.keymap.set({"x", "o"}, "s", "<Plug>Sneak_s")
vim.keymap.set({"x", "o"}, "S", "<Plug>Sneak_S")

-- vim-edgemotion
vim.keymap.set({"n", "x", "o"}, "J", "<Plug>(edgemotion-j)")
vim.keymap.set({"n", "x", "o"}, "K", "<Plug>(edgemotion-k)")
