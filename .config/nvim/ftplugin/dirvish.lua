vim.keymap.set("n", "<C-q>", "<Plug>(dirvish_quit)", {buffer=0})
vim.keymap.set({"n", "x"}, "<C-PageDown>", "<cr>", {remap=true, buffer=0})

-- Ain't nobody allowed to map my K
vim.cmd("silent! unmap <buffer> K")

vim.keymap.set({"n", "x"}, "?", "<Plug>(dirvish_K)", {buffer=0})

local buf = vim.fn.expand("%")
vim.opt_local.statusline = vim.fn.fnamemodify(buf, ":p:~") .. " %r%m"
