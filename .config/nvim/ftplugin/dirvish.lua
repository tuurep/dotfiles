vim.keymap.set("n", "q", "<Plug>(dirvish_quit)")

local buf = vim.fn.expand("%")
vim.opt_local.statusline = vim.fn.fnamemodify(buf, ":p:~") .. " %r%m"
