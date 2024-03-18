-- goodnight.lua colorscheme by tuurep (github.com/tuurep)
-- This colorscheme is based on Base16-Tomorrow-Night by Chris Kempson (github.com/chriskempson)

vim.cmd.highlight("clear")
vim.cmd.syntax("reset")

vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "goodnight"

-- Default background and foreround:
local bg =      "#0f0f0f"
local fg =      "#d0d0d0"

-- The six basic (ANSI) colors:
local red =     "#c36060"
local green =   "#a7bd68"
local yellow =  "#e8c47b"
local blue =    "#7d9fbd"
local magenta = "#a684b0"
local cyan =    "#88bab0"

-- "Bright black", chosen with comments in mind
local comment = "#5f6160"

-- Standout color mainly for numbers (int, float, bool, const)
local orange =  "#d17c6b"

-- Borders and floating window backgrounds:
local l_bg =    "#222525" -- lighter background
local ll_bg =   "#313438" -- lighter lighter background

-- fg variants for more concealed/more emphasized text
local d_fg =    "#909090" -- darker foreground
local dd_fg =   "#787878" -- darker darker foreground (but not as dark as comment)
-- local l_fg = "#eaeaea" -- lighter foreground

-- Inactive UI elements colors:
local stat_fg = "#656e6e" -- inactive statusline foreground
local linenum = "#404040" -- inactive linenumber foreground
local search =  "#6b6b6b" -- inactive search bg

-- (Note: the 'active' counterpart is just default fg)

-- These colors are part of the palette, but haven't found use:
-- local b_white = "#ffffff" -- bright white
-- local brown =   "#a3685a"

-- shorthands
local hl = vim.api.nvim_set_hl
local autocmd = vim.api.nvim_create_autocmd

-- Namespaces
local active_win = vim.api.nvim_create_namespace("active_window")
local inactive_win = vim.api.nvim_create_namespace("inactive_window")

-- Active line
hl(0, "CursorLine",   {})                      -- clear: no cursorline bg
hl(0, "CursorLineNr", { fg = dd_fg, bg = bg }) --    ... only the LineNr highlighted

-- Inactive line
hl(0, "LineNr",       { fg = linenum })
hl(0, "EndOfBuffer",  { fg = linenum })

-- Search and substitute (:%s)
hl(0, "Search",     { fg = bg, bg = search }) -- cursor not in result
hl(0, "CurSearch",  { fg = bg, bg = fg     }) -- cursor in result
hl(0, "IncSearch",  { fg = bg, bg = fg     })
hl(0, "Substitute", { fg = bg, bg = fg     })

hl(active_win, "search",     { link = "Search"     })
hl(active_win, "cursearch",  { link = "Cursearch"  })
hl(active_win, "incsearch",  { link = "IncSearch"  })
hl(active_win, "substitute", { link = "Substitute" })

hl(inactive_win, "Search",     { link = "None" })
hl(inactive_win, "CurSearch",  { link = "None" })
hl(inactive_win, "IncSearch",  { link = "None" })
hl(inactive_win, "Substitute", { link = "None" })

-- tommcdo/vim-exchange
hl(0, "ExchangeRegion", { link = "Search" })

-- vim-sneak
hl(0, "Sneak",      { link = "Search" })
hl(0, "SneakScope", { link = "None"   })

-- Init inactive windows
autocmd({"VimEnter"}, {
    callback = function()
        local wlist = vim.api.nvim_tabpage_list_wins(0)
        local current_w = vim.api.nvim_get_current_win()
        for _, w in ipairs(wlist) do
            if w ~= current_w then
                vim.wo[w].cursorline = false
                vim.api.nvim_win_set_hl_ns(w, inactive_win)
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
        vim.api.nvim_win_set_hl_ns(w, active_win)
    end
})
-- INACTIVE WINDOW
autocmd({"WinLeave"}, {
    callback = function()
        vim.opt_local.cursorline = false
        local w = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_hl_ns(w, inactive_win)
    end
})

-- Editor colors
hl(0, "Normal",       { fg = fg,      bg = bg   })
hl(0, "Debug",        { fg = red                })
hl(0, "Directory",    { fg = blue               })
hl(0, "ErrorMsg",     { fg = red,     bg = bg   })
hl(0, "Error",        { fg = bg,      bg = red  })
hl(0, "Exception",    { fg = red                })
hl(0, "FoldColumn",   { fg = cyan,    bg = l_bg })
hl(0, "Folded",       { fg = comment, bg = l_bg })
hl(0, "MoreMsg",      { fg = fg                 })
hl(0, "Question",     { fg = fg                 })
hl(0, "SpecialKey",   { fg = comment            })
hl(0, "TooLong",      { fg = red                })
hl(0, "Visual",       { fg = bg,      bg = fg   })
hl(0, "WarningMsg",   { fg = yellow             })
hl(0, "WildMenu",     { fg = l_bg               })
hl(0, "Title",        { fg = blue               })
hl(0, "NonText",      { fg = comment            })
hl(0, "SignColum",    { fg = comment, bg = bg   })
hl(0, "StatusLine",   { fg = fg,      bg = l_bg })
hl(0, "StatusLineNC", { fg = stat_fg, bg = l_bg })
hl(0, "WinSeparator", { fg = l_bg,    bg = l_bg })
hl(0, "SignColumn",   {               bg = bg   })
hl(0, "ColorColumn",  {               bg = l_bg })
hl(0, "CursorColumn", {               bg = l_bg })
hl(0, "QuickFixLine", {               bg = l_bg })
hl(0, "PMenu",        { fg = fg,      bg = l_bg })
hl(0, "PMenuSel",     { fg = l_bg,    bg = fg   })
hl(0, "TabLine",      { fg = comment, bg = l_bg })
hl(0, "TabLineFill",  { fg = comment, bg = l_bg })
hl(0, "TabLineSel",   { fg = green,   bg = l_bg })

-- Diff highlighting
hl(0, "DiffAdd",     { fg = bg,    bg = green  })
hl(0, "DiffChange",  { fg = bg,    bg = d_fg   })
hl(0, "DiffDelete",  { fg = bg,    bg = red    })
hl(0, "DiffText",    { fg = bg,    bg = green  })
hl(0, "DiffAdded",   { fg = green, bg = bg     })
hl(0, "DiffRemoved", { fg = red,   bg = bg     })
hl(0, "DiffLine",    { fg = cyan,  bg = bg     })

hl(0, "DiagnosticError", { fg = red     })
hl(0, "DiagnosticWarn",  { fg = yellow  })
hl(0, "DiagnosticOk",    { fg = green   })
hl(0, "DiagnosticInfo",  { fg = comment })
hl(0, "DiagnosticHint",  { fg = comment })

-- Undotree highlighting
hl(0, "UndoTreeNodeCurrent", { fg = fg                  })
hl(0, "UndoTreeCurrent",     { fg = fg                  })
hl(0, "UndoTreeHead",        { fg = green               })
hl(0, "UndotreeSavedSmall",  { fg = green               })
hl(0, "UndoTreeSavedBig",    { fg = bg,      bg = green })
hl(0, "UndotreeTimeStamp",   { fg = linenum             })

-- Dirvish
hl(0, "DirvishArg", { fg = green })

-- vimtex
hl(0, "texCmd",            { fg = red })
hl(0, "texCmdStyle",       { fg = red })
hl(0, "texFileArg",        { fg = fg  })
hl(0, "texFilesArg",       { fg = fg  })
hl(0, "texConcealedArg",   { fg = fg  })
hl(0, "texConditionalArg", { fg = fg  })
hl(0, "texEnvArgName",     { fg = fg  })
hl(0, "texOptEqual",       { fg = fg  })
hl(0, "texTitleArg",       { link = "@markup.heading"  })
hl(0, "texPartArgTitle",   { link = "@markup.heading"  })
hl(0, "texUrlArg",         { link = "@markup.link.url" })
hl(0, "texRefArg",         { link = "@markup.link.url" })
hl(0, "texVerbZone",       { link = "@markup.raw"      })
hl(0, "texVerbZoneInline", { link = "@markup.raw"      })

-- Treesitter capture groups
-- The full list is found here:
-- http//github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md
-- Base16 styling guidelines will help in choosing sensible colors:
-- https://github.com/chriskempson/base16/blob/main/styling.md
hl(0, "@comment",              { fg = comment })
hl(0, "@operator",             { fg = fg      })
hl(0, "@punctuation",          { fg = fg      })
hl(0, "@punctuation.special",  { fg = cyan    })
hl(0, "@string",               { fg = green   })
hl(0, "@string.regexp",        { fg = cyan    })
hl(0, "@string.escape",        { fg = cyan    })
hl(0, "@string.special",       { fg = cyan    })
hl(0, "@character",            { fg = green   })
hl(0, "@character.special",    { fg = cyan    })
hl(0, "@character.printf",     { fg = cyan    })
hl(0, "@boolean",              { fg = orange  })
hl(0, "@number",               { fg = orange  })
hl(0, "@function",             { fg = blue    })
hl(0, "@function.builtin",     { fg = blue    })
hl(0, "@constructor",          { fg = blue    })
hl(0, "@keyword",              { fg = magenta })
hl(0, "@label",                { fg = fg      })
hl(0, "@exception",            { fg = magenta })
hl(0, "@type",                 { fg = fg      })
hl(0, "@type.builtin",         { fg = magenta })
hl(0, "@type.definition",      { fg = fg      })
hl(0, "@type.qualifier",       { fg = magenta })
hl(0, "@attribute",            { fg = fg      })
hl(0, "@property",             { fg = fg      })
hl(0, "@variable",             { fg = fg      })
hl(0, "@variable.builtin",     { fg = magenta })
hl(0, "@constant",             { fg = fg      })
hl(0, "@constant.builtin",     { fg = orange  })
hl(0, "@constant.macro",       { fg = orange  })
hl(0, "@module",               { fg = fg      })
hl(0, "@tag",                  { fg = red     })
hl(0, "@tag.attribute",        { fg = yellow  })
hl(0, "@tag.delimiter",        { fg = fg      })
hl(0, "@diff.plus",            { fg = green   })
hl(0, "@diff.minus",           { fg = red     })
hl(0, "@diff.delta",           { fg = green   })
hl(0, "@spell",                { link="None"  })
hl(0, "@nospell",              { link="None"  })

-- Markdown
hl(0, "@punctuation.special.markdown", { fg = red     })
hl(0, "@markup.heading",               { fg = blue    })
hl(0, "@markup.strong",                { fg = yellow  })
hl(0, "@markup.underline",             { fg = yellow  })
hl(0, "@markup.italic",                { fg = magenta })
hl(0, "@markup.quote",                 { fg = cyan    })
hl(0, "@markup.list",                  { fg = red     })
hl(0, "@markup.raw",                   { fg = green   })
hl(0, "@markup.math",                  { fg = green   })
hl(0, "@markup.link",                  { fg = fg      })
hl(0, "@markup.link.label",            { fg = red     })
hl(0, "@markup.link.url",              { fg = cyan    })
hl(0, "@markup.strikethrough",         { fg = red     })

-- Regex
hl(0, "@constant.regex",              { fg = cyan })
hl(0, "@operator.regex",              { fg = cyan })
hl(0, "@punctuation.delimiter.regex", { fg = cyan })
hl(0, "@punctuation.bracket.regex",   { fg = cyan })
hl(0, "@variable.builtin.regex",      { fg = cyan })

-- Link for languages that don't have a treesitter parser
-- To have somewhat sensible defaults (otherwise Vim's default colorscheme will show)
hl(0, "Character",    { link = "@character"            })
hl(0, "Comment",      { link = "@comment"              })
hl(0, "Conditional",  { link = "@keyword.conditional"  })
hl(0, "Constant",     { link = "@constant"             })
hl(0, "Define",       { link = "@keyword.directive"    })
hl(0, "Delimiter",    { link = "@punctuation.delimiter"})
hl(0, "Float",        { link = "@number"               })
hl(0, "Function",     { link = "@function"             })
hl(0, "Identifier",   { link = "@type.definition"      })
hl(0, "Include",      { link = "@keyword.import"       })
hl(0, "Keyword",      { link = "@keyword"              })
hl(0, "Label",        { link = "@label"                })
hl(0, "Number",       { link = "@number"               })
hl(0, "Operator",     { link = "@operator"             })
hl(0, "PreProc",      { link = "@keyword.directive"    })
hl(0, "Repeat",       { link = "@keyword.repeat"       })
hl(0, "Special",      { link = "@punctuation.special"  })
hl(0, "SpecialChar",  { link = "@character.special"    })
hl(0, "Statement",    { link = "@keyword"              })
hl(0, "StorageClass", { link = "@keyword.storage"      })
hl(0, "String",       { link = "@string"               })
hl(0, "Structure",    { link = "@keyword"              })
hl(0, "Tag",          { link = "@tag"                  })
hl(0, "Type",         { link = "@type"                 })
hl(0, "Typedef",      { link = "@type.definition"      })

-- Fine-tuning and pinpointing issues

-- Gitcommit
hl(0, "@string.special.url.gitcommit", { fg = fg    })
hl(0, "@markup.link.gitcommit",        { fg = green })

-- Stuff that insists on being annoying
hl(0, "MatchParen", { link = "None" })
hl(0, "Conceal",    { link = "None" })
hl(0, "Todo",   { link = "@comment" })

-- Vimtex
hl(0, "texError", { link = "None" }) -- Please stop trying to use syntax highlighting
                                     -- as a wannabe linter
-- XML
hl(0, "xmlTagName",         { link = "@tag"           })
hl(0, "xmlTag",             { link = "@tag.delimiter" })
hl(0, "xmlProcessingDelim", { link = "@tag.delimiter" })
hl(0, "xmlAttrib",          { link = "@tag.attribute" })

-- CSS
hl(0, "@tag.css",          { fg = red      })
hl(0, "@type.css",         { fg = red      })
hl(0, "@attribute.css",    { fg = red      })
hl(0, "@constant.css",     { fg = red      })
hl(0, "@property.css",     { fg = magenta  })
hl(0, "@number.css",       { fg = fg       }) -- Todo: numbers and strings are a mess
hl(0, "@number.float.css", { fg = fg       }) --       (punctuation.delimiter granularity)
hl(0, "@string.css",       { fg = fg       }) --       (@string priorized over @number on words like "px", "em", "vh"...)
                                              -- Looks pretty good with no color though
-- Manpage buffer
hl(0, "manItalic",         { fg = green    }) -- in `less` manpage, this is underlined
hl(0, "manSectionHeading", { fg = blue     })
hl(0, "manSubHeading",     { fg = blue     })
hl(0, "manHeader",         { link = "None" })
hl(0, "manReference",      { link = "None" })
hl(0, "manOptionDesc",     { link = "None" })

-- :checkhealth OK
hl(0, "healthSuccess", { fg = bg, bg = green })
