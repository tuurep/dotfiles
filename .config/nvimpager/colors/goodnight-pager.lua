-- Colorscheme for nvimpager

-- No syntax highlighting except:
--      Diffs
--      Manpages

vim.cmd.highlight("clear")
vim.cmd.syntax("reset")

vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "goodnight-pager"

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

-- Borders
local l_bg =    "#222525" -- lighter background

local d_fg =    "#909090" -- darker foreground
local dd_fg =   "#767676" -- darker darker foreground

-- Inactive UI elements colors:
local stat_fg = "#656e6e" -- inactive statusline foreground
local linenum = "#404040" -- inactive linenumber foreground
local search =  "#6b6b6b" -- inactive search bg

-- shorthands
local hl = vim.api.nvim_set_hl
local autocmd = vim.api.nvim_create_autocmd

-- Active line
hl(0, "CursorLine",   {})                      -- clear: no cursorline bg
hl(0, "CursorLineNr", { fg = dd_fg, bg = bg }) --    ... only the LineNr highlighted

-- Inactive line
hl(0, "LineNr",       { fg = linenum })
hl(0, "EndOfBuffer",  { fg = linenum })

-- Visual mode inverted colors
hl(0, "Normal", { fg = fg, bg = bg })
hl(0, "Visual", { fg = bg, bg = fg })

-- Search
hl(0, "Search",     { fg = bg, bg = search }) -- cursor not in result
hl(0, "CurSearch",  { fg = bg, bg = fg     }) -- cursor in result
hl(0, "IncSearch",  { fg = bg, bg = fg     })

-- vim-sneak
hl(0, "Sneak",      { link = "Search" })
hl(0, "SneakScope", { link = "None"   })

-- Diff highlighting
hl(0, "DiffAdd",       { fg = bg, bg = green   })
hl(0, "DiffChange",    { fg = bg, bg = d_fg    })
hl(0, "DiffDelete",    { fg = bg, bg = red     })
hl(0, "DiffText",      { fg = bg, bg = green   })
hl(0, "DiffAdded",     { fg = green, bg = bg   })
hl(0, "DiffRemoved",   { fg = red, bg = bg     })
hl(0, "DiffLine",      { fg = cyan, bg = bg    })
hl(0, "DiffFile",      { fg = dd_fg, bg = bg   })
hl(0, "DiffIndexLine", { fg = dd_fg, bg = bg   })
hl(0, "DiffOldFile",   { fg = dd_fg, bg = bg   })
hl(0, "DiffNewFile",   { fg = dd_fg, bg = bg   })

-- Manpage buffer
hl(0, "manItalic",         { fg = green    }) -- in `less` manpage, this is underlined
hl(0, "manSectionHeading", { fg = blue     })
hl(0, "manSubHeading",     { fg = blue     })
hl(0, "manHeader",         { link = "None" })
hl(0, "manReference",      { link = "None" })
hl(0, "manOptionDesc",     { link = "None" })

-- Error/Warn
hl(0, "ErrorMsg",   { fg = red,     bg = bg   })
hl(0, "Error",      { fg = bg,      bg = red  })
hl(0, "WarningMsg", { fg = yellow             })

-- Editor UI
hl(0, "StatusLine",   { fg = fg,      bg = l_bg })
hl(0, "StatusLineNC", { fg = stat_fg, bg = l_bg })
hl(0, "WinSeparator", { fg = l_bg,    bg = l_bg })
hl(0, "PMenu",        { fg = fg,      bg = l_bg })
hl(0, "PMenuSel",     { fg = l_bg,    bg = fg   })
hl(0, "TabLine",      { fg = fg,      bg = l_bg })
hl(0, "TabLineFill",  { fg = fg,      bg = l_bg })
hl(0, "TabLineSel",   { fg = green,   bg = l_bg })
hl(0, "WildMenu",     { fg = l_bg               })

-- Editor colors
hl(0, "Debug",        { link = "None" })
hl(0, "Directory",    { link = "None" })
hl(0, "Exception",    { link = "None" })
hl(0, "FoldColumn",   { link = "None" })
hl(0, "Folded",       { link = "None" })
hl(0, "MoreMsg",      { link = "None" })
hl(0, "Question",     { link = "None" })
hl(0, "SpecialKey",   { link = "None" })
hl(0, "TooLong",      { link = "None" })
hl(0, "Title",        { link = "None" })
hl(0, "NonText",      { link = "None" })
hl(0, "SignColum",    { link = "None" })
hl(0, "ColorColumn",  { link = "None" })
hl(0, "CursorColumn", { link = "None" })
hl(0, "QuickFixLine", { link = "None" })

-- Syntax highlighting
hl(0, "Character",    { link = "None" })
hl(0, "Comment",      { link = "None" })
hl(0, "Conditional",  { link = "None" })
hl(0, "Constant",     { link = "None" })
hl(0, "Define",       { link = "None" })
hl(0, "Delimiter",    { link = "None" })
hl(0, "Float",        { link = "None" })
hl(0, "Function",     { link = "None" })
hl(0, "Identifier",   { link = "None" })
hl(0, "Include",      { link = "None" })
hl(0, "Keyword",      { link = "None" })
hl(0, "Label",        { link = "None" })
hl(0, "Number",       { link = "None" })
hl(0, "Operator",     { link = "None" })
hl(0, "PreProc",      { link = "None" })
hl(0, "Repeat",       { link = "None" })
hl(0, "Special",      { link = "None" })
hl(0, "SpecialChar",  { link = "None" })
hl(0, "Statement",    { link = "None" })
hl(0, "StorageClass", { link = "None" })
hl(0, "String",       { link = "None" })
hl(0, "Structure",    { link = "None" })
hl(0, "Tag",          { link = "None" })
hl(0, "Type",         { link = "None" })
hl(0, "Typedef",      { link = "None" })

-- Stuff that insists on being annoying
hl(0, "MatchParen", { link = "None" })
hl(0, "Conceal",    { link = "None" })
hl(0, "Todo",       { link = "None" })

-- Anything else that comes up
hl(0, "Underlined", { link = "None" })
