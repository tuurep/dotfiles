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
local red =     "#d46161"
local green =   "#a7bd68"
local yellow =  "#edc36f"
local blue =    "#7d9fbd"
local magenta = "#a986b3"
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
local g = 0 -- global
local active_win = vim.api.nvim_create_namespace("active_window")
local inactive_win = vim.api.nvim_create_namespace("inactive_window")

-- Active line
hl(g, "CursorLine",   {})                      -- clear: no cursorline bg
hl(g, "CursorLineNr", { fg = dd_fg, bg = bg }) --    ... only the LineNr highlighted

-- Inactive line
hl(g, "LineNr",       { fg = linenum })
hl(g, "EndOfBuffer",  { fg = linenum })

-- Search and substitute (:%s)
hl(g, "Search",     { fg = bg, bg = search }) -- cursor not in result
hl(g, "CurSearch",  { fg = bg, bg = fg     }) -- cursor in result
hl(g, "IncSearch",  { fg = bg, bg = fg     })
hl(g, "Substitute", { fg = bg, bg = fg     })

hl(active_win, "search",     { link = "Search"     })
hl(active_win, "cursearch",  { link = "Cursearch"  })
hl(active_win, "incsearch",  { link = "IncSearch"  })
hl(active_win, "substitute", { link = "Substitute" })

hl(inactive_win, "Search",     { link = "None" })
hl(inactive_win, "CurSearch",  { link = "None" })
hl(inactive_win, "IncSearch",  { link = "None" })
hl(inactive_win, "Substitute", { link = "None" })

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
hl(g, "StatusLineNC", { fg = stat_fg, bg = l_bg })
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
hl(g, "DiffAdd",     { fg = bg,    bg = green  })
hl(g, "DiffChange",  { fg = bg,    bg = d_fg   })
hl(g, "DiffDelete",  { fg = bg,    bg = red    })
hl(g, "DiffText",    { fg = bg,    bg = green  })
hl(g, "DiffAdded",   { fg = green, bg = bg     })
hl(g, "DiffRemoved", { fg = red,   bg = bg     })
hl(g, "DiffLine",    { fg = cyan,  bg = bg     })

hl(g, "DiagnosticError", { fg = red     })
hl(g, "DiagnosticWarn",  { fg = yellow  })
hl(g, "DiagnosticOk",    { fg = green   })
hl(g, "DiagnosticInfo",  { fg = comment })
hl(g, "DiagnosticHint",  { fg = comment })

-- Undotree highlighting
hl(g, "UndoTreeNodeCurrent", { fg = fg                  })
hl(g, "UndoTreeCurrent",     { fg = fg                  })
hl(g, "UndoTreeHead",        { fg = green               })
hl(g, "UndotreeSavedSmall",  { fg = green               })
hl(g, "UndoTreeSavedBig",    { fg = bg,      bg = green })
hl(g, "UndotreeTimeStamp",   { fg = linenum             })

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
hl(g, "texTitleArg",       { link = "@markup.heading"  })
hl(g, "texPartArgTitle",   { link = "@markup.heading"  })
hl(g, "texUrlArg",         { link = "@markup.link.url" })
hl(g, "texRefArg",         { link = "@markup.link.url" })
hl(g, "texVerbZone",       { link = "@markup.raw"      })
hl(g, "texVerbZoneInline", { link = "@markup.raw"      })

-- Treesitter capture groups
-- The full list is found here:
-- http//github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md
-- Base16 styling guidelines will help in choosing sensible colors:
-- https://github.com/chriskempson/base16/blob/main/styling.md
hl(g, "@comment",              { fg = comment })
hl(g, "@operator",             { fg = fg      })
hl(g, "@punctuation",          { fg = fg      })
hl(g, "@punctuation.special",  { fg = cyan    })
hl(g, "@string",               { fg = green   })
hl(g, "@string.regexp",        { fg = cyan    })
hl(g, "@string.escape",        { fg = cyan    })
hl(g, "@string.special",       { fg = cyan    })
hl(g, "@character",            { fg = green   })
hl(g, "@character.special",    { fg = cyan    })
hl(g, "@character.printf",     { fg = cyan    })
hl(g, "@boolean",              { fg = orange  })
hl(g, "@number",               { fg = orange  })
hl(g, "@function",             { fg = blue    })
hl(g, "@function.builtin",     { fg = blue    })
hl(g, "@constructor",          { fg = blue    })
hl(g, "@keyword",              { fg = magenta })
hl(g, "@label",                { fg = fg      })
hl(g, "@exception",            { fg = magenta })
hl(g, "@type",                 { fg = fg      })
hl(g, "@type.builtin",         { fg = magenta })
hl(g, "@type.definition",      { fg = fg      })
hl(g, "@type.qualifier",       { fg = magenta })
hl(g, "@attribute",            { fg = fg      })
hl(g, "@property",             { fg = fg      })
hl(g, "@variable",             { fg = fg      })
hl(g, "@variable.builtin",     { fg = magenta })
hl(g, "@constant",             { fg = fg      })
hl(g, "@constant.builtin",     { fg = orange  })
hl(g, "@constant.macro",       { fg = orange  })
hl(g, "@module",               { fg = fg      })
hl(g, "@tag",                  { fg = red     })
hl(g, "@tag.attribute",        { fg = yellow  })
hl(g, "@tag.delimiter",        { fg = fg      })
hl(g, "@diff.plus",            { fg = green   })
hl(g, "@diff.minus",           { fg = red     })
hl(g, "@diff.delta",           { fg = green   })
hl(g, "@spell",                { link="None"  })
hl(g, "@nospell",              { link="None"  })

-- Markdown
hl(g, "@punctuation.special.markdown", { fg = red     })
hl(g, "@markup.heading",               { fg = blue    })
hl(g, "@markup.strong",                { fg = yellow  })
hl(g, "@markup.underline",             { fg = yellow  })
hl(g, "@markup.italic",                { fg = magenta })
hl(g, "@markup.quote",                 { fg = cyan    })
hl(g, "@markup.list",                  { fg = red     })
hl(g, "@markup.raw",                   { fg = green   })
hl(g, "@markup.math",                  { fg = green   })
hl(g, "@markup.link",                  { fg = fg      })
hl(g, "@markup.link.label",            { fg = red     })
hl(g, "@markup.link.url",              { fg = cyan    })
hl(g, "@markup.strikethrough",         { fg = red     })

-- Regex
hl(g, "@constant.regex",              { fg = cyan })
hl(g, "@operator.regex",              { fg = cyan })
hl(g, "@punctuation.delimiter.regex", { fg = cyan })
hl(g, "@punctuation.bracket.regex",   { fg = cyan })
hl(g, "@variable.builtin.regex",      { fg = cyan })

-- Link for languages that don't have a treesitter parser
-- To have somewhat sensible defaults (otherwise Vim's default colorscheme will show)
hl(g, "Character",    { link = "@character"            })
hl(g, "Comment",      { link = "@comment"              })
hl(g, "Conditional",  { link = "@keyword.conditional"  })
hl(g, "Constant",     { link = "@constant"             })
hl(g, "Define",       { link = "@keyword.directive"    })
hl(g, "Delimiter",    { link = "@punctuation.delimiter"})
hl(g, "Float",        { link = "@number"               })
hl(g, "Function",     { link = "@function"             })
hl(g, "Identifier",   { link = "@type.definition"      })
hl(g, "Include",      { link = "@keyword.import"       })
hl(g, "Keyword",      { link = "@keyword"              })
hl(g, "Label",        { link = "@label"                })
hl(g, "Number",       { link = "@number"               })
hl(g, "Operator",     { link = "@operator"             })
hl(g, "PreProc",      { link = "@keyword.directive"    })
hl(g, "Repeat",       { link = "@keyword.repeat"       })
hl(g, "Special",      { link = "@punctuation.special"  })
hl(g, "SpecialChar",  { link = "@character.special"    })
hl(g, "Statement",    { link = "@keyword"              })
hl(g, "StorageClass", { link = "@keyword.storage"      })
hl(g, "String",       { link = "@string"               })
hl(g, "Structure",    { link = "@keyword"              })
hl(g, "Tag",          { link = "@tag"                  })
hl(g, "Type",         { link = "@type"                 })
hl(g, "Typedef",      { link = "@type.definition"      })

-- Fine-tuning and pinpointing issues

-- Gitcommit
hl(g, "@string.special.url.gitcommit", { fg = fg    })
hl(g, "@markup.link.gitcommit",        { fg = green })

-- Stuff that insists on being annoying
hl(g, "MatchParen", { link = "None" })
hl(g, "Conceal",    { link = "None" })
hl(g, "Todo",   { link = "@comment" })

-- Vimtex
hl(g, "texError", { link = "None" }) -- Please stop trying to use syntax highlighting
                                     -- as a wannabe linter
-- XML
hl(g, "xmlTagName",         { link = "@tag"           })
hl(g, "xmlTag",             { link = "@tag.delimiter" })
hl(g, "xmlProcessingDelim", { link = "@tag.delimiter" })
hl(g, "xmlAttrib",          { link = "@tag.attribute" })

-- CSS
hl(g, "@tag.css",          { fg = red      })
hl(g, "@type.css",         { fg = red      })
hl(g, "@attribute.css",    { fg = red      })
hl(g, "@constant.css",     { fg = red      })
hl(g, "@property.css",     { fg = magenta  })
hl(g, "@number.css",       { fg = fg       }) -- Todo: numbers and strings are a mess
hl(g, "@number.float.css", { fg = fg       }) --       (punctuation.delimiter granularity)
hl(g, "@string.css",       { fg = fg       }) --       (@string priorized over @number on words like "px", "em", "vh"...)
                                              -- Looks pretty good with no color though
-- Manpage buffer
hl(g, "manItalic",         { fg = red      }) -- in `less` manpage, this is underlined
hl(g, "manHeader",         { link = "None" })
hl(g, "manSectionHeading", { link = "None" })
hl(g, "manSubHeading",     { link = "None" })
hl(g, "manReference",      { link = "None" })

-- :checkhealth OK
hl(g, "healthSuccess", { fg = bg, bg = green })
