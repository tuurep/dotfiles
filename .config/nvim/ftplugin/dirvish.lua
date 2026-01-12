-- Unwanted dirvish maps
vim.cmd("silent! unmap <buffer> .")
vim.cmd("silent! unmap <buffer> K")

-- Remaps for above
-- Todo: if . was useful, remap to something?
vim.keymap.set({"n", "x"}, "?", "<Plug>(dirvish_K)", { buffer = 0 })

-- Todo: Make <C-q> fully quit when there are no (real) buffers open
--       Annoying when doing "nvim <dir>" and trying to quit, requires <C-q> twice
vim.keymap.set("n", "<C-q>", "<Plug>(dirvish_quit)", { buffer = 0 })
vim.keymap.set({"n", "x"}, "<C-PageDown>", "<cr>", { remap=true, buffer = 0 })

vim.opt_local.statusline = vim.fn.expand("%:p:~") .. " %r%m"
