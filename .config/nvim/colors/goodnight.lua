-- goodnight.lua colorscheme by tuurep (github.com/tuurep)
-- This colorscheme is based on Base16-Tomorrow-Night by Chris Kempson (github.com/chriskempson)
vim.g.colors_name = "goodnight"

-- Default background and foreround:
local bg =      "#0d0d0d"
local fg =      "#d0d0d0"

-- The six basic (ANSI) colors:
local red =     "#c36060"
local green =   "#a7bd68"
local yellow =  "#e8c580"
local blue =    "#7d9fbd"
local magenta = "#a684b0"
local cyan =    "#88bab0"

-- Comments have a dedicated color not used elsewhere
local comment = "#5f6160"

-- Standout color mainly for numbers (int, float, bool, const)
local orange =  "#d17c6b"

-- Borders and floating window backgrounds:
local l_bg=     "#121212" -- lighter background
local ll_bg=    "#222525" -- lighter lighter background
local lll_bg =  "#313438" -- lighter lighter lighter background

-- fg variants for more concealed/more emphasized text
local d_fg =    "#909090" -- darker foreground
local dd_fg =   "#767676" -- darker darker foreground (but not as dark as comment)
-- local l_fg = "#eaeaea" -- lighter foreground

-- Inactive UI elements colors:
local stat_fg = "#656e6e" -- inactive statusline foreground
local linenum = "#404040" -- inactive linenumber foreground
local search =  "#7d7d7d" -- inactive search bg

-- These colors are part of the palette, but haven't found use:
-- local b_white = "#ffffff" -- bright white
-- local brown =   "#a3685a"

-- Namespaces
local active_win = vim.api.nvim_create_namespace("active_window")
local inactive_win = vim.api.nvim_create_namespace("inactive_window")

-- Active line
vim.api.nvim_set_hl(0, "CursorLine",   {})                      -- clear: no cursorline bg
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = dd_fg, bg = bg }) --    ... only the LineNr highlighted

-- Inactive line
vim.api.nvim_set_hl(0, "LineNr",       { fg = linenum })
vim.api.nvim_set_hl(0, "EndOfBuffer",  { fg = linenum })

-- Search and substitute (:%s)
vim.api.nvim_set_hl(0, "Search",     { fg = bg, bg = search }) -- cursor not in result
vim.api.nvim_set_hl(0, "CurSearch",  { fg = bg, bg = fg     }) -- cursor in result
vim.api.nvim_set_hl(0, "IncSearch",  { fg = bg, bg = fg     })
vim.api.nvim_set_hl(0, "Substitute", { fg = bg, bg = fg     })

vim.api.nvim_set_hl(active_win, "Search",     { link = "Search"     })
vim.api.nvim_set_hl(active_win, "CurSearch",  { link = "CurSearch"  })
vim.api.nvim_set_hl(active_win, "IncSearch",  { link = "IncSearch"  })
vim.api.nvim_set_hl(active_win, "Substitute", { link = "Substitute" })

vim.api.nvim_set_hl(inactive_win, "Search",     { link = "None" })
vim.api.nvim_set_hl(inactive_win, "CurSearch",  { link = "None" })
vim.api.nvim_set_hl(inactive_win, "IncSearch",  { link = "None" })
vim.api.nvim_set_hl(inactive_win, "Substitute", { link = "None" })

-- echasnovski/mini.operators exchange
vim.api.nvim_set_hl(0, "MiniOperatorsExchangeFrom", { link = "Search" })

-- vim-sneak
vim.api.nvim_set_hl(0, "Sneak",        { link = "Search"    })
vim.api.nvim_set_hl(0, "SneakCurrent", { link = "CurSearch" })
vim.api.nvim_set_hl(0, "SneakScope",   { link = "None"      })

-- Init inactive windows
vim.api.nvim_create_autocmd({"VimEnter"}, {
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
vim.api.nvim_create_autocmd({"WinEnter", "BufWinEnter"}, {
    callback = function()
        vim.opt_local.cursorline = true
        local w = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_hl_ns(w, active_win)
    end
})
-- INACTIVE WINDOW
vim.api.nvim_create_autocmd({"WinLeave"}, {
    callback = function()
        vim.opt_local.cursorline = false
        local w = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_hl_ns(w, inactive_win)
    end
})

-- Editor colors
vim.api.nvim_set_hl(0, "Normal",       { fg = fg,      bg = bg     })
vim.api.nvim_set_hl(0, "Debug",        { fg = red                  })
vim.api.nvim_set_hl(0, "Directory",    { fg = blue                 })
vim.api.nvim_set_hl(0, "ErrorMsg",     { fg = red,     bg = bg     })
vim.api.nvim_set_hl(0, "Error",        { fg = bg,      bg = red    })
vim.api.nvim_set_hl(0, "Exception",    { fg = red                  })
vim.api.nvim_set_hl(0, "FoldColumn",   { fg = cyan,    bg = ll_bg  })
vim.api.nvim_set_hl(0, "Folded",       { fg = comment, bg = ll_bg  })
vim.api.nvim_set_hl(0, "MoreMsg",      { fg = fg                   })
vim.api.nvim_set_hl(0, "ModeMsg",      { fg = fg                   })
vim.api.nvim_set_hl(0, "Question",     { fg = fg                   })
vim.api.nvim_set_hl(0, "SpecialKey",   { fg = comment              })
vim.api.nvim_set_hl(0, "TooLong",      { fg = red                  })
vim.api.nvim_set_hl(0, "Visual",       { fg = bg,      bg = fg     })
vim.api.nvim_set_hl(0, "WarningMsg",   { fg = yellow               })
vim.api.nvim_set_hl(0, "WildMenu",     { fg = ll_bg                })
vim.api.nvim_set_hl(0, "Title",        { fg = blue                 })
vim.api.nvim_set_hl(0, "NonText",      { fg = dd_fg                })
vim.api.nvim_set_hl(0, "SignColum",    { fg = comment, bg = bg     })
vim.api.nvim_set_hl(0, "StatusLine",   { fg = fg,      bg = ll_bg  })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = stat_fg, bg = ll_bg  })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = l_bg,    bg = ll_bg  })
vim.api.nvim_set_hl(0, "SignColumn",   {               bg = bg     })
vim.api.nvim_set_hl(0, "ColorColumn",  {               bg = l_bg   })
vim.api.nvim_set_hl(0, "CursorColumn", {               bg = ll_bg  })
vim.api.nvim_set_hl(0, "QuickFixLine", { fg = bg,      bg = search })
vim.api.nvim_set_hl(0, "QfLineNr",     { fg = fg,                  })
vim.api.nvim_set_hl(0, "qfSeparator",  { fg = fg,                  })
vim.api.nvim_set_hl(0, "PMenu",        { fg = fg,      bg = ll_bg  })
vim.api.nvim_set_hl(0, "PMenuSel",     { fg = l_bg,    bg = fg     })
vim.api.nvim_set_hl(0, "TabLine",      { fg = comment, bg = ll_bg  })
vim.api.nvim_set_hl(0, "TabLineFill",  { fg = comment, bg = ll_bg  })
vim.api.nvim_set_hl(0, "TabLineSel",   { fg = green,   bg = ll_bg  })

-- Diff highlighting
vim.api.nvim_set_hl(0, "DiffAdd",       { fg = bg,      bg = green })
vim.api.nvim_set_hl(0, "DiffChange",    { fg = bg,      bg = d_fg  })
vim.api.nvim_set_hl(0, "DiffDelete",    { fg = bg,      bg = red   })
vim.api.nvim_set_hl(0, "DiffText",      { fg = bg,      bg = green })
vim.api.nvim_set_hl(0, "DiffAdded",     { fg = green,   bg = bg    })
vim.api.nvim_set_hl(0, "DiffRemoved",   { fg = red,     bg = bg    })
vim.api.nvim_set_hl(0, "DiffLine",      { fg = cyan,    bg = bg    })
vim.api.nvim_set_hl(0, "DiffFile",      { fg = comment, bg = bg    })
vim.api.nvim_set_hl(0, "DiffIndexLine", { fg = comment, bg = bg    })
vim.api.nvim_set_hl(0, "DiffOldFile",   { fg = comment, bg = bg    })
vim.api.nvim_set_hl(0, "DiffNewFile",   { fg = comment, bg = bg    })

vim.api.nvim_set_hl(0, "DiagnosticError", { fg = red     })
vim.api.nvim_set_hl(0, "DiagnosticWarn",  { fg = yellow  })
vim.api.nvim_set_hl(0, "DiagnosticOk",    { fg = green   })
vim.api.nvim_set_hl(0, "DiagnosticInfo",  { fg = comment })
vim.api.nvim_set_hl(0, "DiagnosticHint",  { fg = comment })

-- Undotree highlighting
vim.api.nvim_set_hl(0, "UndoTreeNodeCurrent", { fg = fg                  })
vim.api.nvim_set_hl(0, "UndoTreeCurrent",     { fg = fg                  })
vim.api.nvim_set_hl(0, "UndoTreeHead",        { fg = green               })
vim.api.nvim_set_hl(0, "UndotreeSavedSmall",  { fg = green               })
vim.api.nvim_set_hl(0, "UndoTreeSavedBig",    { fg = bg,      bg = green })
vim.api.nvim_set_hl(0, "UndotreeTimeStamp",   { fg = linenum             })

-- Dirvish
vim.api.nvim_set_hl(0, "DirvishArg", { fg = green })

-- Treesitter capture groups
-- The full list is found here:
-- https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md
-- Base16 styling guidelines will help in choosing sensible colors:
-- https://github.com/chriskempson/base16/blob/main/styling.md
vim.api.nvim_set_hl(0, "@comment",              { fg = comment })
vim.api.nvim_set_hl(0, "@operator",             { fg = fg      })
vim.api.nvim_set_hl(0, "@punctuation",          { fg = fg      })
vim.api.nvim_set_hl(0, "@punctuation.special",  { fg = cyan    })
vim.api.nvim_set_hl(0, "@string",               { fg = green   })
vim.api.nvim_set_hl(0, "@string.regexp",        { fg = cyan    })
vim.api.nvim_set_hl(0, "@string.escape",        { fg = cyan    })
vim.api.nvim_set_hl(0, "@string.special",       { fg = cyan    })
vim.api.nvim_set_hl(0, "@string.special.url",   { fg = cyan    })
vim.api.nvim_set_hl(0, "@character",            { fg = green   })
vim.api.nvim_set_hl(0, "@character.special",    { fg = cyan    })
vim.api.nvim_set_hl(0, "@character.printf",     { fg = cyan    })
vim.api.nvim_set_hl(0, "@boolean",              { fg = orange  })
vim.api.nvim_set_hl(0, "@number",               { fg = orange  })
vim.api.nvim_set_hl(0, "@function",             { fg = blue    })
vim.api.nvim_set_hl(0, "@function.builtin",     { fg = blue    })
vim.api.nvim_set_hl(0, "@constructor",          { fg = blue    })
vim.api.nvim_set_hl(0, "@keyword",              { fg = magenta })
vim.api.nvim_set_hl(0, "@label",                { fg = fg      })
vim.api.nvim_set_hl(0, "@exception",            { fg = magenta })
vim.api.nvim_set_hl(0, "@type",                 { fg = magenta })
vim.api.nvim_set_hl(0, "@type.builtin",         { fg = magenta })
vim.api.nvim_set_hl(0, "@type.definition",      { fg = magenta })
vim.api.nvim_set_hl(0, "@type.qualifier",       { fg = magenta })
vim.api.nvim_set_hl(0, "@attribute",            { fg = fg      })
vim.api.nvim_set_hl(0, "@property",             { fg = fg      })
vim.api.nvim_set_hl(0, "@variable",             { fg = fg      })
vim.api.nvim_set_hl(0, "@variable.builtin",     { fg = magenta })
vim.api.nvim_set_hl(0, "@constant",             { fg = fg      })
vim.api.nvim_set_hl(0, "@constant.builtin",     { fg = orange  })
vim.api.nvim_set_hl(0, "@constant.macro",       { fg = orange  })
vim.api.nvim_set_hl(0, "@module",               { fg = fg      })
vim.api.nvim_set_hl(0, "@module.builtin",       { fg = magenta })
vim.api.nvim_set_hl(0, "@tag",                  { fg = red     })
vim.api.nvim_set_hl(0, "@tag.attribute",        { fg = yellow  })
vim.api.nvim_set_hl(0, "@tag.delimiter",        { fg = fg      })
vim.api.nvim_set_hl(0, "@diff.plus",            { fg = green   })
vim.api.nvim_set_hl(0, "@diff.minus",           { fg = red     })
vim.api.nvim_set_hl(0, "@diff.delta",           { fg = green   })
vim.api.nvim_set_hl(0, "@spell",                { link="None"  })
vim.api.nvim_set_hl(0, "@nospell",              { link="None"  })

-- Latex
vim.api.nvim_set_hl(0, "@module.latex",              { fg = red  })
vim.api.nvim_set_hl(0, "@function.latex",            { fg = red  })
vim.api.nvim_set_hl(0, "@function.macro.latex",      { fg = red  })
vim.api.nvim_set_hl(0, "@keyword.import.latex",      { fg = red  })
vim.api.nvim_set_hl(0, "@punctuation.special.latex", { fg = red  })
vim.api.nvim_set_hl(0, "@markup.link.latex",         { fg = cyan })
vim.api.nvim_set_hl(0, "@string.latex",              { fg = fg   })
vim.api.nvim_set_hl(0, "@string.special.path.latex", { fg = fg   })
vim.api.nvim_set_hl(0, "@string.regexp.latex",       { fg = fg   })

-- Markdown
vim.api.nvim_set_hl(0, "@punctuation.special.markdown", { fg = red     })
vim.api.nvim_set_hl(0, "@markup.heading",               { fg = blue    })
vim.api.nvim_set_hl(0, "@markup.strong",                { fg = yellow  })
vim.api.nvim_set_hl(0, "@markup.underline",             { fg = yellow  })
vim.api.nvim_set_hl(0, "@markup.italic",                { fg = magenta })
vim.api.nvim_set_hl(0, "@markup.quote",                 { fg = cyan    })
vim.api.nvim_set_hl(0, "@markup.list",                  { fg = red     })
vim.api.nvim_set_hl(0, "@markup.raw",                   { fg = green   })
vim.api.nvim_set_hl(0, "@markup.math",                  { fg = green   })
vim.api.nvim_set_hl(0, "@markup.link",                  { fg = fg      })
vim.api.nvim_set_hl(0, "@markup.link.label",            { fg = red     })
vim.api.nvim_set_hl(0, "@markup.link.url",              { fg = cyan    })
vim.api.nvim_set_hl(0, "@markup.strikethrough",         { fg = red     })

-- Regex
vim.api.nvim_set_hl(0, "@constant.regex",              { fg = cyan })
vim.api.nvim_set_hl(0, "@operator.regex",              { fg = cyan })
vim.api.nvim_set_hl(0, "@punctuation.delimiter.regex", { fg = cyan })
vim.api.nvim_set_hl(0, "@punctuation.bracket.regex",   { fg = cyan })
vim.api.nvim_set_hl(0, "@variable.builtin.regex",      { fg = cyan })

-- Link for languages that don't have a treesitter parser
-- To have somewhat sensible defaults (otherwise nvim's default colorscheme will show)
vim.api.nvim_set_hl(0, "Character",    { link = "@character"            })
vim.api.nvim_set_hl(0, "Comment",      { link = "@comment"              })
vim.api.nvim_set_hl(0, "Conditional",  { link = "@keyword.conditional"  })
vim.api.nvim_set_hl(0, "Constant",     { link = "@constant"             })
vim.api.nvim_set_hl(0, "Define",       { link = "@keyword.directive"    })
vim.api.nvim_set_hl(0, "Delimiter",    { link = "@punctuation.delimiter"})
vim.api.nvim_set_hl(0, "Float",        { link = "@number"               })
vim.api.nvim_set_hl(0, "Function",     { link = "@function"             })
vim.api.nvim_set_hl(0, "Identifier",   { link = "@type.definition"      })
vim.api.nvim_set_hl(0, "Include",      { link = "@keyword.import"       })
vim.api.nvim_set_hl(0, "Keyword",      { link = "@keyword"              })
vim.api.nvim_set_hl(0, "Label",        { link = "@label"                })
vim.api.nvim_set_hl(0, "Number",       { link = "@number"               })
vim.api.nvim_set_hl(0, "Operator",     { link = "@operator"             })
vim.api.nvim_set_hl(0, "PreProc",      { link = "@keyword.directive"    })
vim.api.nvim_set_hl(0, "Repeat",       { link = "@keyword.repeat"       })
vim.api.nvim_set_hl(0, "Special",      { link = "@punctuation.special"  })
vim.api.nvim_set_hl(0, "SpecialChar",  { link = "@character.special"    })
vim.api.nvim_set_hl(0, "Statement",    { link = "@keyword"              })
vim.api.nvim_set_hl(0, "StorageClass", { link = "@keyword.storage"      })
vim.api.nvim_set_hl(0, "String",       { link = "@string"               })
vim.api.nvim_set_hl(0, "Structure",    { link = "@keyword"              })
vim.api.nvim_set_hl(0, "Tag",          { link = "@tag"                  })
vim.api.nvim_set_hl(0, "Type",         { link = "@type"                 })
vim.api.nvim_set_hl(0, "Typedef",      { link = "@type.definition"      })

-- There's no treesitter parser for zsh yet
-- There's not enough granularity in the zsh highlight groups,
-- but set them as something semi-sensible for now
vim.api.nvim_set_hl(0, "zshCommands",   { fg = magenta  })
vim.api.nvim_set_hl(0, "zshException",  { fg = magenta  })
vim.api.nvim_set_hl(0, "zshTypes",      { fg = magenta  })
vim.api.nvim_set_hl(0, "zshFunction",   { fg = blue     })
vim.api.nvim_set_hl(0, "zshDeref",      { fg = cyan     })
vim.api.nvim_set_hl(0, "zshShortDeref", { fg = cyan     })
vim.api.nvim_set_hl(0, "zshSubst",      { link = "None" })

-- Fine-tuning and pinpointing issues

-- Using vimtex's highlighting instead of treesitter latex parser
-- because opening a .tex file with treesitter parser takes ~500ms
-- See: https://github.com/latex-lsp/tree-sitter-latex/issues/97
vim.api.nvim_set_hl(0, "texCmd",                { link = "@function.latex"      })
vim.api.nvim_set_hl(0, "texCmdConditional",     { link = "@keyword.conditional" })
vim.api.nvim_set_hl(0, "texCmdSize",            { link = "texCmd"               })
vim.api.nvim_set_hl(0, "texCmdStyle",           { link = "texCmd"               })
vim.api.nvim_set_hl(0, "texEnvArgName",         { link = "@markup.raw"          })
vim.api.nvim_set_hl(0, "texMathDelimZone",      { link = "@markup.math"         })
vim.api.nvim_set_hl(0, "texMathZone",           { link = "@markup.math"         })
vim.api.nvim_set_hl(0, "texPartArgTitle",       { link = "@markup.heading"      })
vim.api.nvim_set_hl(0, "texRefArg",             { link = "@markup.link.url"     })
vim.api.nvim_set_hl(0, "texStyleBold",          { link = "@markup.strong"       })
vim.api.nvim_set_hl(0, "texStyleBoldItalUnder", { link = "@markup.underline"    })
vim.api.nvim_set_hl(0, "texStyleBoldUnder",     { link = "@markup.underline"    })
vim.api.nvim_set_hl(0, "texStyleItal",          { link = "@markup.italic"       })
vim.api.nvim_set_hl(0, "texStyleItalUnder",     { link = "@markup.underline"    })
vim.api.nvim_set_hl(0, "texStyleUnder",         { link = "@markup.underline"    })
vim.api.nvim_set_hl(0, "texTitleArg",           { link = "@markup.heading"      })
vim.api.nvim_set_hl(0, "texZone",               { link = "@markup.raw"          })

vim.api.nvim_set_hl(0, "texConditionalArg", { fg = fg })
vim.api.nvim_set_hl(0, "texFileArg",        { fg = fg })
vim.api.nvim_set_hl(0, "texFilesArg",       { fg = fg })
vim.api.nvim_set_hl(0, "texLength",         { fg = fg })
vim.api.nvim_set_hl(0, "texNewEnvArgName",  { fg = fg })
vim.api.nvim_set_hl(0, "texOptEqual",       { fg = fg })

vim.api.nvim_set_hl(0, "texError", { link = "None" }) -- syntax highlighting != linting

-- Gitcommit
vim.api.nvim_set_hl(0, "@comment.warning.gitcommit",    { fg = red   }) -- Title exceeds 50 chars warning
vim.api.nvim_set_hl(0, "@string.special.url.gitcommit", { fg = fg    })
vim.api.nvim_set_hl(0, "@markup.link.gitcommit",        { fg = green })

-- Stuff that insists on being annoying
vim.api.nvim_set_hl(0, "MatchParen", { link = "None" })
vim.api.nvim_set_hl(0, "Conceal",    { link = "None" })
vim.api.nvim_set_hl(0, "Todo",   { link = "@comment" })

-- XML
vim.api.nvim_set_hl(0, "xmlTagName",         { link = "@tag"           })
vim.api.nvim_set_hl(0, "xmlTag",             { link = "@tag.delimiter" })
vim.api.nvim_set_hl(0, "xmlProcessingDelim", { link = "@tag.delimiter" })
vim.api.nvim_set_hl(0, "xmlAttrib",          { link = "@tag.attribute" })

-- CSS
vim.api.nvim_set_hl(0, "@tag.css",          { fg = red      })
vim.api.nvim_set_hl(0, "@type.css",         { fg = red      })
vim.api.nvim_set_hl(0, "@attribute.css",    { fg = red      })
vim.api.nvim_set_hl(0, "@constant.css",     { fg = red      })
vim.api.nvim_set_hl(0, "@property.css",     { fg = magenta  })
vim.api.nvim_set_hl(0, "@number.css",       { fg = fg       }) -- Todo: numbers and strings are a mess
vim.api.nvim_set_hl(0, "@number.float.css", { fg = fg       }) --       (punctuation.delimiter granularity)
vim.api.nvim_set_hl(0, "@string.css",       { fg = fg       }) --       (@string priorized over @number on words like "px", "em", "vh"...)
                                                               -- Looks pretty good with no color though
-- Manpage buffer
vim.api.nvim_set_hl(0, "manUndeline",       { fg = green    })
vim.api.nvim_set_hl(0, "manSectionHeading", { fg = blue     })
vim.api.nvim_set_hl(0, "manSubHeading",     { fg = blue     })
vim.api.nvim_set_hl(0, "manHeader",         { link = "None" })
vim.api.nvim_set_hl(0, "manReference",      { link = "None" })
vim.api.nvim_set_hl(0, "manOptionDesc",     { link = "None" })

-- Vimdoc
vim.api.nvim_set_hl(0, "@label.vimdoc",       { fg = red  })
vim.api.nvim_set_hl(0, "@markup.link.vimdoc", { fg = cyan })

-- :TSModuleInfo
vim.api.nvim_set_hl(0, "TSModuleInfoGood", { fg = green })
vim.api.nvim_set_hl(0, "TSModuleInfoBad",  { fg = red   })
