local lazypath = vim.fn.stdpath("data") .. "/lazy"
vim.opt.runtimepath:prepend(lazypath .. "/lazy.nvim")

-- Override Lazy default keybinds
require("lazy.view.config").keys.hover = "gx"

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

    -- :Lazy log
    -- Problem, would want to only show new commits
    -- (Like max 2 weeks old)
    git = {
        log = { "-10" }
    },

    performance = {
        rtp = {
            disabled_plugins = {
                "editorconfig",
                "gzip",
                "man",
                "matchparen",
                "netrwPlugin",
                "rplugin",
                "spellfile",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            }
        }
    }
}
