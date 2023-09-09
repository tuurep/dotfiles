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
    git = {
        -- Shows all commits newer than 2 weeks
        -- Plugins that don't have newer commits aren't shown at all
        log = { "--since=$(date -d '-2 week')" }
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
