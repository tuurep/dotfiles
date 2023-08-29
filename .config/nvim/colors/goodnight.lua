-- goodnight.vim colorscheme by tuurep (github.com/tuurep)
-- This colorscheme is based on Base16-Tomorrow-Night by Chris Kempson (github.com/chriskempson)

vim.cmd("highlight clear")
vim.cmd("syntax reset")

vim.o.background = "dark"
vim.g.colors_name = "goodnight"

-- ====== Terminal Colors ======
--
-- Expects colors to be set in the terminal emulator
-- Terminal needs to be able to set colors 0-23 as:
--
-- Color00: #121212
-- Color01: #cc6666
-- Color02: #a7bd68
-- Color03: #f0c674
-- Color04: #81a2be
-- Color05: #b294bb
-- Color06: #8abeb7
-- Color07: #d0d0d0
-- Color08: #5f6160
-- Color09: (unused)
-- Color10: (unused)
-- Color11: (unused)
-- Color12: (unused)
-- Color13: (unused)
-- Color14: (unused)
-- Color15: #ffffff
-- Color16: #de935f
-- Color17: #a3685a
-- Color18: #222525
-- Color19: #313438
-- Color20: #909090
-- Color21: #eaeaea
-- Color22: #656e6e
-- Color23: #404040

-- Default background and foreround:
local bg = 0
local fg = 7

-- The six basic (ANSI) colors:
local red =     1
local green =   2
local yellow =  3
local blue =    4
local magenta = 5
local cyan =    6

-- "Bright black", chosen with comments in mind
local comment = 8

-- More colors (orange most common):
local b_white = 15  -- bright white
local orange =  16
local brown =   17

-- Mostly greyish, important colors for statusbars, borders and such:
local l_bg =    18  -- lighter background
local sel_bg =  19  -- selection background (but in practice: lighter lighter bg)
local d_fg =    20  -- darker foreground
local l_fg =    21  -- lighter foreground
local i_s_fg =  22  -- inactive statusline foreground
local linenum = 23  -- (non-active) linenumber foreground

local hl = vim.api.nvim_set_hl -- shorthand

-- Namespaces
local g = 0 -- global
local active = vim.api.nvim_create_namespace("active_window")
local inactive = vim.api.nvim_create_namespace("inactive_window")

-- No cursorline background, but current linenumber is highlighted:
--      * this depends on `set cursorline`
--
hl(g, "CursorLine",   {}) -- clear (fix weird underline)
hl(g, "CursorLineNr", { ctermfg = fg, ctermbg = bg })
hl(g, "LineNr",       { ctermfg = linenum })
hl(g, "EndOfBuffer",  { ctermfg = linenum })

-- Search and substitute (:%s)
hl(active, "Search",     { ctermfg = bg, ctermbg = brown  })
hl(active, "CurSearch",  { ctermfg = bg, ctermbg = yellow })
hl(active, "IncSearch",  { ctermfg = bg, ctermbg = yellow })
hl(active, "Substitute", { ctermfg = bg, ctermbg = yellow })

hl(inactive, "Search",     {})
hl(inactive, "CurSearch",  {})
hl(inactive, "IncSearch",  {})
hl(inactive, "Substitute", {})

-- For inactive windows:
--      * Don't highlight current linenumber
--      * Don't higlight search/substitute matches
--
vim.api.nvim_create_autocmd({"WinLeave"}, {
    callback = function()
        vim.opt_local.cursorline = false
        local w = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_hl_ns(w, inactive)
    end
})
vim.api.nvim_create_autocmd({"VimEnter", "WinEnter", "BufWinEnter"}, {
    callback = function()
        vim.opt_local.cursorline = true
        local w = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_hl_ns(w, active)
    end
})

-- Editor colors
hl(g, "Cursor",       { ctermfg = bg,      ctermbg = fg   })
hl(g, "Normal",       { ctermfg = fg,      ctermbg = bg   })
hl(g, "Debug",        { ctermfg = red                     })
hl(g, "Directory",    { ctermfg = blue                    })
hl(g, "ErrorMsg",     { ctermfg = red,     ctermbg = bg   })
hl(g, "Error",        { ctermfg = bg,      ctermbg = red  })
hl(g, "Exception",    { ctermfg = red                     })
hl(g, "FoldColumn",   { ctermfg = cyan,    ctermbg = l_bg })
hl(g, "Folded",       { ctermfg = comment, ctermbg = l_bg })
hl(g, "MoreMsg",      { ctermfg = fg                      })
hl(g, "Question",     { ctermfg = fg                      })
hl(g, "SpecialKey",   { ctermfg = comment                 })
hl(g, "TooLong",      { ctermfg = red                     })
hl(g, "Visual",       { ctermfg = bg,      ctermbg = fg   })
hl(g, "VisualNOS",    { ctermfg = red                     })
hl(g, "WarningMsg",   { ctermfg = red                     })
hl(g, "WildMenu",     { ctermfg = l_bg                    })
hl(g, "Title",        { ctermfg = blue                    })
hl(g, "NonText",      { ctermfg = comment                 })
hl(g, "SignColum",    { ctermfg = comment, ctermbg = bg   })
hl(g, "StatusLine",   { ctermfg = fg,      ctermbg = l_bg })
hl(g, "StatusLineNC", { ctermfg = i_s_fg,  ctermbg = l_bg })
hl(g, "VertSplit",    { ctermfg = l_bg,    ctermbg = l_bg })
hl(g, "ColorColumn",  {                    ctermbg = l_bg })
hl(g, "CursorColumn", {                    ctermbg = l_bg })
hl(g, "QuickFixLine", {                    ctermbg = l_bg })
hl(g, "PMenu",        { ctermfg = fg,      ctermbg = l_bg })
hl(g, "PMenuSel",     { ctermfg = l_bg,    ctermbg = fg   })
hl(g, "TabLine",      { ctermfg = comment, ctermbg = l_bg })
hl(g, "TabLineFill",  { ctermfg = comment, ctermbg = l_bg })
hl(g, "TabLineSel",   { ctermfg = green,   ctermbg = l_bg })

-- Diff highlighting
hl(g, "DiffAdd",     { ctermfg = bg,    ctermbg = green   })
hl(g, "DiffChange",  { ctermfg = bg,    ctermbg = dark_fg })
hl(g, "DiffDelete",  { ctermfg = bg,    ctermbg = red     })
hl(g, "DiffText",    { ctermfg = bg,    ctermbg = green   })
hl(g, "DiffAdded",   { ctermfg = green, ctermbg = bg      })
hl(g, "DiffRemoved", { ctermfg = red,   ctermbg = bg      })
hl(g, "DiffLine",    { ctermfg = blue,  ctermbg = bg      })

-- Undotree highlighting
hl(g, "UndoTreeNodeCurrent", { ctermfg = fg                       })
hl(g, "UndoTreeCurrent",     { ctermfg = fg                       })
hl(g, "UndoTreeHead",        { ctermfg = green                    })
hl(g, "UndotreeSavedSmall",  { ctermfg = green                    })
hl(g, "UndoTreeSavedBig",    { ctermfg = bg,      ctermbg = green })
hl(g, "UndotreeTimeStamp",   { ctermfg = comment                  })

-- Fern highlighting
hl(g, "FernSpinner",  { ctermbg = bg })

-- vimtex
hl(g, "texCmd",            { ctermfg = red })
hl(g, "texCmdStyle",       { ctermfg = red })
hl(g, "texFileArg",        { ctermfg = fg  })
hl(g, "texFilesArg",       { ctermfg = fg  })
hl(g, "texConcealedArg",   { ctermfg = fg  })
hl(g, "texConditionalArg", { ctermfg = fg  })
hl(g, "texEnvArgName",     { ctermfg = fg  })
hl(g, "texOptEqual",       { ctermfg = fg  })
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
hl(g, "@comment",              { ctermfg = comment, cterm={italic=true} })
hl(g, "@preproc",              { ctermfg = magenta })
hl(g, "@define",               { ctermfg = magenta })
hl(g, "@operator",             { ctermfg = fg      })
hl(g, "@punctuation",          { ctermfg = fg      })
hl(g, "@punctuation.delimiter",{ ctermfg = fg      })
hl(g, "@punctuation.bracket",  { ctermfg = fg      })
hl(g, "@punctuation.special",  { ctermfg = cyan    })
hl(g, "@string",               { ctermfg = green   })
hl(g, "@string.regex",         { ctermfg = cyan    })
hl(g, "@string.escape",        { ctermfg = cyan    })
hl(g, "@string.special",       { ctermfg = cyan    })
hl(g, "@character",            { ctermfg = green   })
hl(g, "@character.special",    { ctermfg = cyan    })
hl(g, "@boolean",              { ctermfg = orange  })
hl(g, "@number",               { ctermfg = orange  })
hl(g, "@float",                { ctermfg = orange  })
hl(g, "@function",             { ctermfg = blue    })
hl(g, "@function.builtin",     { ctermfg = blue    })
hl(g, "@function.call",        { ctermfg = blue    })
hl(g, "@function.macro",       { ctermfg = blue    })
hl(g, "@method",               { ctermfg = blue    })
hl(g, "@method.call",          { ctermfg = blue    })
hl(g, "@constructor",          { ctermfg = blue    })
hl(g, "@parameter",            { ctermfg = fg      })
hl(g, "@keyword",              { ctermfg = magenta })
hl(g, "@keyword.function",     { ctermfg = magenta })
hl(g, "@keyword.operator",     { ctermfg = magenta })
hl(g, "@keyword.return",       { ctermfg = magenta })
hl(g, "@conditional",          { ctermfg = magenta })
hl(g, "@conditional.ternary",  { ctermfg = magenta })
hl(g, "@repeat",               { ctermfg = magenta })
hl(g, "@debug",                { ctermfg = magenta })
hl(g, "@label",                { ctermfg = fg      })
hl(g, "@include",              { ctermfg = magenta })
hl(g, "@exception",            { ctermfg = magenta })
hl(g, "@type",                 { ctermfg = fg      })
hl(g, "@type.builtin",         { ctermfg = magenta })
hl(g, "@type.definition",      { ctermfg = fg      })
hl(g, "@type.qualifier",       { ctermfg = magenta })
hl(g, "@storageclass",         { ctermfg = magenta })
hl(g, "@attribute",            { ctermfg = blue    })
hl(g, "@field",                { ctermfg = fg      })
hl(g, "@property",             { ctermfg = fg      })
hl(g, "@variable",             { ctermfg = fg      })
hl(g, "@variable.builtin",     { ctermfg = magenta })
hl(g, "@constant",             { ctermfg = fg      })
hl(g, "@constant.builtin",     { ctermfg = orange  })
hl(g, "@constant.macro",       { ctermfg = orange  })
hl(g, "@namespace",            { ctermfg = fg      })
hl(g, "@symbol",               { ctermfg = fg      })
hl(g, "@text",                 { ctermfg = fg      })
hl(g, "@text.strong",          { ctermfg = yellow  })
hl(g, "@text.emphasis",        { ctermfg = magenta })
hl(g, "@text.underline",       { ctermfg = yellow  })
hl(g, "@text.strike",          { ctermfg = red     })
hl(g, "@text.title",           { ctermfg = blue    })
hl(g, "@text.literal",         { ctermfg = green   })
hl(g, "@text.quote",           { ctermfg = cyan    })
hl(g, "@text.uri",             { ctermfg = orange  })
hl(g, "@text.reference",       { ctermfg = red     })
hl(g, "@text.diff.add",        { ctermfg = green   })
hl(g, "@text.diff.delete",     { ctermfg = red     })
hl(g, "@tag",                  { ctermfg = red     })
hl(g, "@tag.attribute",        { ctermfg = yellow  })
hl(g, "@tag.delimiter",        { ctermfg = fg      })

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

-- Disable standouts in comments
hl(g, "Todo", { link = "@comment" })

-- XML
hl(g, "xmlTagName",         { link = "@tag"           })
hl(g, "xmlTag",             { link = "@tag.delimiter" })
hl(g, "xmlProcessingDelim", { link = "@tag.delimiter" })
hl(g, "xmlAttrib",          { link = "@tag.attribute" })

-- Markdown
hl(g, "@punctuation.special.markdown", { ctermfg = blue })

-- :checkhealth OK
hl(g, "healthSuccess",     { ctermfg = bg, ctermbg = green })

-- git commit
hl(g, "@text.reference.gitcommit", { ctermfg = green })
hl(g, "@text.uri.gitcommit",       { ctermfg = fg    })
