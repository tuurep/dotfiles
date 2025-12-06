-- Unwanted dirvish maps
vim.cmd("silent! unmap <buffer> .")
vim.cmd("silent! unmap <buffer> K")

-- Remaps for above
-- Todo: if . was useful, remap to something?
vim.keymap.set({"n", "x"}, "?", "<Plug>(dirvish_K)", { buffer = 0 })

vim.keymap.set("n", "<C-q>", "<Plug>(dirvish_quit)", { buffer = 0 })
vim.keymap.set({"n", "x"}, "<C-PageDown>", "<cr>", { remap=true, buffer = 0 })

local buf = vim.fn.expand("%")
vim.opt_local.statusline = vim.fn.fnamemodify(buf, ":p:~") .. " %r%m"
