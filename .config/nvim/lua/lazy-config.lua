local lazypath = vim.fn.stdpath("data") .. "/lazy"
vim.opt.runtimepath:prepend(lazypath .. "/lazy.nvim")

return {
    lockfile = lazypath .. "/lazy-lock.json",

    ui = {
        -- Full screen window with default bg color
        size = { width=1, height=1 },

        -- Remove keybind info at top
        pills = false,

        -- Eradicate icons
        icons = {
            cmd =        "", config = "", event =   "",
            ft =         "", init =   "", import =  "",
            keys =       "", lazy =   "", loaded =  "", 
            not_loaded = "", plugin = "", runtime = "",
            source =     "", start =  "", task =    "", 

            list = { "", "", "", "" }
        }
    },
    disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin"
    }
}
