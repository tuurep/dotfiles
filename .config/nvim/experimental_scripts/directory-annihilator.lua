-- Tried a setup where netrw is unloaded and you can never edit a directory buffer

for i=0, vim.fn.argc()-1 do
    local fname = vim.fn.argv(i)
    if vim.fn.isdirectory(fname)==1 then
        vim.cmd.bwipeout(fname)
    end
end

autocmd({"BufEnter"}, {
    callback = function()
        local bufname = vim.fn.expand("%")
        if vim.fn.isdirectory(bufname) == 1 then
            vim.cmd.bwipeout()
            print(bufname .. " is a directory")
        end
    end
})

-- Problems:
--  1. if you open a lot of directories and files like: `nvim *`, 
--     syntax highlighting is turned off for the initial file
--  2. arglist (:args) doesn't remove the wiped out buffers and on exit you get:
--     "n more files to edit. Quit anyway?"
--          - could also be deleted from arglist with :argdel?
