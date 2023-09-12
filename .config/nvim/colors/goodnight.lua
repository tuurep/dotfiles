-- goodnight.lua colorscheme by tuurep (github.com/tuurep)
-- This colorscheme is based on Base16-Tomorrow-Night by Chris Kempson (github.com/chriskempson)

vim.cmd.highlight("clear")
vim.cmd.syntax("reset")

vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "goodnight"

-- Default background and foreround:
local bg =      "#121212"
local fg =      "#d0d0d0"

-- The six basic (ANSI) colors:
local red =     "#cc6666"
local green =   "#a7bd68"
local yellow =  "#f0c674"
local blue =    "#81a2be"
local magenta = "#b294bb"
local cyan =    "#8abeb7"

-- "Bright black", chosen with comments in mind
local comment = "#5f6160"

-- More colors (orange most common):
local b_white = "#ffffff" -- bright white
local orange =  "#de935f"
local brown =   "#a3685a"

-- Mostly greyish, important colors for statusbars, borders and such:
local l_bg =    "#222525" -- lighter background
local ll_bg =   "#313438" -- lighter lighter background
local dd_fg =   "#6b6b6b" -- darker darker foreground (but not as dark as comment)
local d_fg =    "#909090" -- darker foreground
local l_fg =    "#eaeaea" -- lighter foreground
local i_s_fg =  "#656e6e" -- inactive statusline foreground
local linenum = "#404040" -- (non-active) linenumber foreground

-- shorthands
local hl = vim.api.nvim_set_hl
local autocmd = vim.api.nvim_create_autocmd

-- Namespaces
local g = 0 -- global
local active = vim.api.nvim_create_namespace("active_window")
local inactive = vim.api.nvim_create_namespace("inactive_window")

-- Active line
hl(g, "CursorLine",   {})                   -- clear: no cursorline bg
hl(g, "CursorLineNr", { fg = fg, bg = bg }) --    ... only the LineNr highlighted

-- Inactive line
hl(g, "LineNr",       { fg = linenum })
hl(g, "EndOfBuffer",  { fg = linenum })

-- Search and substitute (:%s)
hl(g, "Search",     { fg = bg, bg = dd_fg })
hl(g, "CurSearch",  { fg = bg, bg = fg    })
hl(g, "IncSearch",  { fg = bg, bg = fg    })
hl(g, "Substitute", { fg = bg, bg = fg    })

hl(active, "Search",     { link = "Search"     })
hl(active, "CurSearch",  { link = "Cursearch"  })
hl(active, "IncSearch",  { link = "IncSearch"  })
hl(active, "Substitute", { link = "Substitute" })

hl(inactive, "Search",     { link = "None" })
hl(inactive, "CurSearch",  { link = "None" })
hl(inactive, "IncSearch",  { link = "None" })
hl(inactive, "Substitute", { link = "None" })

-- tommcdo/vim-exchange
hl(g, "ExchangeRegion", { link = "Search" })

-- vim-sneak
hl(g, "Sneak",      { link = "Search" })
hl(g, "SneakScope", { link = "None"   })

-- Init inactive windows
autocmd({"VimEnter"}, {
    callback = function()
        local wlist = vim.api.nvim_tabpage_list_wins(0)
        local current_w = vim.api.nvim_get_current_win()
        for _, w in ipairs(wlist) do
            if w ~= current_w then
                vim.wo[w].cursorline = false
                vim.api.nvim_win_set_hl_ns(w, inactive)
            end
        end
    end
})

-- For inactive windows:
--      * Don't highlight current linenumber
--      * Don't higlight search/substitute matches

-- ACTIVE WINDOW
autocmd({"WinEnter", "BufWinEnter"}, {
    callback = function()
        vim.opt_local.cursorline = true
        local w = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_hl_ns(w, active)
    end
})
-- INACTIVE WINDOW
autocmd({"WinLeave"}, {
    callback = function()
        vim.opt_local.cursorline = false
        local w = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_hl_ns(w, inactive)
    end
})

-- Editor colors
hl(g, "Normal",       { fg = fg,      bg = bg   })
hl(g, "Debug",        { fg = red                })
hl(g, "Directory",    { fg = blue               })
hl(g, "ErrorMsg",     { fg = red,     bg = bg   })
hl(g, "Error",        { fg = bg,      bg = red  })
hl(g, "Exception",    { fg = red                })
hl(g, "FoldColumn",   { fg = cyan,    bg = l_bg })
hl(g, "Folded",       { fg = comment, bg = l_bg })
hl(g, "MoreMsg",      { fg = fg                 })
hl(g, "Question",     { fg = fg                 })
hl(g, "SpecialKey",   { fg = comment            })
hl(g, "TooLong",      { fg = red                })
hl(g, "Visual",       { fg = bg,      bg = fg   })
hl(g, "VisualNOS",    { fg = red                })
hl(g, "WarningMsg",   { fg = yellow             })
hl(g, "WildMenu",     { fg = l_bg               })
hl(g, "Title",        { fg = blue               })
hl(g, "NonText",      { fg = comment            })
hl(g, "SignColum",    { fg = comment, bg = bg   })
hl(g, "StatusLine",   { fg = fg,      bg = l_bg })
hl(g, "StatusLineNC", { fg = i_s_fg,  bg = l_bg })
hl(g, "WinSeparator", { fg = l_bg,    bg = l_bg })
hl(g, "ColorColumn",  {               bg = l_bg })
hl(g, "CursorColumn", {               bg = l_bg })
hl(g, "QuickFixLine", {               bg = l_bg })
hl(g, "PMenu",        { fg = fg,      bg = l_bg })
hl(g, "PMenuSel",     { fg = l_bg,    bg = fg   })
hl(g, "TabLine",      { fg = comment, bg = l_bg })
hl(g, "TabLineFill",  { fg = comment, bg = l_bg })
hl(g, "TabLineSel",   { fg = green,   bg = l_bg })

-- Diff highlighting
hl(g, "DiffAdd",     { fg = bg,    bg = green   })
hl(g, "DiffChange",  { fg = bg,    bg = d_fg    })
hl(g, "DiffDelete",  { fg = bg,    bg = red     })
hl(g, "DiffText",    { fg = bg,    bg = green   })
hl(g, "DiffAdded",   { fg = green, bg = bg      })
hl(g, "DiffRemoved", { fg = red,   bg = bg      })
hl(g, "DiffLine",    { fg = cyan,  bg = bg      })

-- Undotree highlighting
hl(g, "UndoTreeNodeCurrent", { fg = fg                  })
hl(g, "UndoTreeCurrent",     { fg = fg                  })
hl(g, "UndoTreeHead",        { fg = green               })
hl(g, "UndotreeSavedSmall",  { fg = green               })
hl(g, "UndoTreeSavedBig",    { fg = bg,      bg = green })
hl(g, "UndotreeTimeStamp",   { fg = comment             })

-- Dirvish
hl(g, "DirvishArg", { fg = green })

-- vimtex
hl(g, "texCmd",            { fg = red })
hl(g, "texCmdStyle",       { fg = red })
hl(g, "texFileArg",        { fg = fg  })
hl(g, "texFilesArg",       { fg = fg  })
hl(g, "texConcealedArg",   { fg = fg  })
hl(g, "texConditionalArg", { fg = fg  })
hl(g, "texEnvArgName",     { fg = fg  })
hl(g, "texOptEqual",       { fg = fg  })
hl(g, "texTitleArg",       { link = "@text.title"   })
hl(g, "texPartArgTitle",   { link = "@text.title"   })
hl(g, "texUrlArg",         { link = "@text.uri"     })
hl(g, "texRefArg",         { link = "@text.uri"     })
hl(g, "texVerbZone",       { link = "@text.literal" })
hl(g, "texVerbZoneInline", { link = "@text.literal" })

-- Treesitter capture groups
-- The full list is found here:
-- http//github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md
-- Base16 styling guidelines will help in choosing sensible colors:
-- https://github.com/chriskempson/base16/blob/main/styling.md
hl(g, "@comment",              { fg = comment })
hl(g, "@comment.documentation",{ fg = comment })
hl(g, "@preproc",              { fg = magenta })
hl(g, "@define",               { fg = magenta })
hl(g, "@operator",             { fg = fg      })
hl(g, "@punctuation",          { fg = fg      })
hl(g, "@punctuation.delimiter",{ fg = fg      })
hl(g, "@punctuation.bracket",  { fg = fg      })
hl(g, "@punctuation.special",  { fg = cyan    })
hl(g, "@string",               { fg = green   })
hl(g, "@string.documentation", { fg = green   })
hl(g, "@string.regex",         { fg = cyan    })
hl(g, "@string.escape",        { fg = cyan    })
hl(g, "@string.special",       { fg = cyan    })
hl(g, "@character",            { fg = green   })
hl(g, "@character.special",    { fg = cyan    })
hl(g, "@boolean",              { fg = orange  })
hl(g, "@number",               { fg = orange  })
hl(g, "@float",                { fg = orange  })
hl(g, "@function",             { fg = blue    })
hl(g, "@function.builtin",     { fg = blue    })
hl(g, "@function.call",        { fg = blue    })
hl(g, "@function.macro",       { fg = blue    })
hl(g, "@method",               { fg = blue    })
hl(g, "@method.call",          { fg = blue    })
hl(g, "@constructor",          { fg = blue    })
hl(g, "@parameter",            { fg = fg      })
hl(g, "@keyword",              { fg = magenta })
hl(g, "@keyword.coroutine",    { fg = magenta })
hl(g, "@keyword.function",     { fg = magenta })
hl(g, "@keyword.operator",     { fg = magenta })
hl(g, "@keyword.return",       { fg = magenta })
hl(g, "@conditional",          { fg = magenta })
hl(g, "@conditional.ternary",  { fg = magenta })
hl(g, "@repeat",               { fg = magenta })
hl(g, "@debug",                { fg = magenta })
hl(g, "@label",                { fg = fg      })
hl(g, "@include",              { fg = magenta })
hl(g, "@exception",            { fg = magenta })
hl(g, "@type",                 { fg = fg      })
hl(g, "@type.builtin",         { fg = magenta })
hl(g, "@type.definition",      { fg = fg      })
hl(g, "@type.qualifier",       { fg = magenta })
hl(g, "@storageclass",         { fg = magenta })
hl(g, "@attribute",            { fg = blue    })
hl(g, "@field",                { fg = fg      })
hl(g, "@property",             { fg = fg      })
hl(g, "@variable",             { fg = fg      })
hl(g, "@variable.builtin",     { fg = magenta })
hl(g, "@constant",             { fg = fg      })
hl(g, "@constant.builtin",     { fg = orange  })
hl(g, "@constant.macro",       { fg = orange  })
hl(g, "@namespace",            { fg = fg      })
hl(g, "@symbol",               { fg = fg      })
hl(g, "@text",                 { fg = fg      })
hl(g, "@text.strong",          { fg = yellow  })
hl(g, "@text.emphasis",        { fg = magenta })
hl(g, "@text.underline",       { fg = yellow  })
hl(g, "@text.strike",          { fg = red     })
hl(g, "@text.title",           { fg = blue    })
hl(g, "@text.quote",           { fg = cyan    })
hl(g, "@text.uri",             { fg = orange  })
hl(g, "@text.math",            { fg = green   })
hl(g, "@text.reference",       { fg = red     })
hl(g, "@text.literal",         { fg = green   })
hl(g, "@text.literal.block",   { fg = green   })
hl(g, "@text.diff.add",        { fg = green   })
hl(g, "@text.diff.delete",     { fg = red     })
hl(g, "@tag",                  { fg = red     })
hl(g, "@tag.attribute",        { fg = yellow  })
hl(g, "@tag.delimiter",        { fg = fg      })
hl(g, "@text.todo",            { link="None"  })
hl(g, "@text.note",            { link="None"  })
hl(g, "@text.warning",         { link="None"  })
hl(g, "@text.danger",          { link="None"  })
hl(g, "@spell",                { link="None"  })
hl(g, "@nospell",              { link="None"  })

-- Link for languages that don't have a treesitter parser
-- To have somewhat sensible defaults (otherwise Vim's default colorscheme will show)
hl(g, "Character",    { link = "@character"            })
hl(g, "Comment",      { link = "@comment"              })
hl(g, "Conditional",  { link = "@conditional"          })
hl(g, "Constant",     { link = "@constant"             })
hl(g, "Define",       { link = "@define"               })
hl(g, "Delimiter",    { link = "@punctuation.delimiter"})
hl(g, "Float",        { link = "@float"                })
hl(g, "Function",     { link = "@function"             })
hl(g, "Identifier",   { link = "@text"                 })
hl(g, "Include",      { link = "@include"              })
hl(g, "Keyword",      { link = "@keyword"              })
hl(g, "Label",        { link = "@label"                })
hl(g, "Number",       { link = "@number"               })
hl(g, "Operator",     { link = "@operator"             })
hl(g, "PreProc",      { link = "@preproc"              })
hl(g, "Repeat",       { link = "@repeat"               })
hl(g, "Special",      { link = "@punctuation.special"  })
hl(g, "SpecialChar",  { link = "@character.special"    })
hl(g, "Statement",    { link = "@keyword"              })
hl(g, "StorageClass", { link = "@storageclass"         })
hl(g, "String",       { link = "@string"               })
hl(g, "Structure",    { link = "@keyword"              })
hl(g, "Tag",          { link = "@tag"                  })
hl(g, "Type",         { link = "@type"                 })
hl(g, "Typedef",      { link = "@type.definition"      })

-- Fine-tuning and pinpointing issues

-- Stuff that insists on being annoying
hl(g, "MatchParen", { link = "None" })
hl(g, "Conceal",    { link = "None" })
hl(g, "Todo",   { link = "@comment" })

-- XML
hl(g, "xmlTagName",         { link = "@tag"           })
hl(g, "xmlTag",             { link = "@tag.delimiter" })
hl(g, "xmlProcessingDelim", { link = "@tag.delimiter" })
hl(g, "xmlAttrib",          { link = "@tag.attribute" })

-- Markdown
hl(g, "@punctuation.special.markdown", { fg = red })

-- Lazy.nvim UI (Note: can break other floating windows)
hl(g, "NormalFloat",     { bg = bg      })
hl(g, "DiagnosticError", { fg = red     })
hl(g, "DiagnosticOk",    { fg = green   })
hl(g, "DiagnosticWarn",  { fg = yellow  })
hl(g, "DiagnosticInfo",  { fg = comment })
hl(g, "DiagnosticHint",  { fg = comment })

-- :checkhealth OK
hl(g, "healthSuccess", { fg = bg, bg = green })

-- git commit
hl(g, "@text.reference.gitcommit", { fg = green })
hl(g, "@text.uri.gitcommit",       { fg = fg    })
