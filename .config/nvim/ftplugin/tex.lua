-- Soft wrap
vim.opt_local.wrap = true
vim.opt_local.linebreak = true

-- Vimtex keymaps
vim.keymap.set("n", "<leader>gc", "<Plug>(vimtex-compile)", {buffer=0, silent =true})
vim.keymap.set("n", "<leader>gv", "<Plug>(vimtex-view)",    {buffer=0, silent =true})
vim.keymap.set("n", "<leader>ge", "<Plug>(vimtex-errors)",  {buffer=0, silent =true})
