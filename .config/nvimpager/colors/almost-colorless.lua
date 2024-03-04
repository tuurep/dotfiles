-- Colorscheme for nvimpager

-- No syntax highlighting except:
--      Diffs
--      Manpages

vim.cmd.highlight("clear")
vim.cmd.syntax("reset")

vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "almost-colorless"

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
local dd_fg =   "#787878" -- darker darker foreground

-- Inactive UI elements colors:
local stat_fg = "#656e6e" -- inactive statusline foreground
local linenum = "#404040" -- inactive linenumber foreground
local search =  "#6b6b6b" -- inactive search bg

-- shorthands
local hl = vim.api.nvim_set_hl
local autocmd = vim.api.nvim_create_autocmd

-- Namespaces
local g = 0 -- global

-- Active line
hl(g, "CursorLine",   {})                      -- clear: no cursorline bg
hl(g, "CursorLineNr", { fg = dd_fg, bg = bg }) --    ... only the LineNr highlighted

-- Inactive line
hl(g, "LineNr",       { fg = linenum })
hl(g, "EndOfBuffer",  { fg = linenum })

-- Visual mode inverted colors
hl(g, "Normal", { fg = fg, bg = bg })
hl(g, "Visual", { fg = bg, bg = fg })

-- Search
hl(g, "Search",     { fg = bg, bg = search }) -- cursor not in result
hl(g, "CurSearch",  { fg = bg, bg = fg     }) -- cursor in result
hl(g, "IncSearch",  { fg = bg, bg = fg     })

-- vim-sneak
hl(g, "Sneak",      { link = "Search" })
hl(g, "SneakScope", { link = "None"   })

-- Diff highlighting
hl(g, "DiffAdd",     { fg = bg,    bg = green  })
hl(g, "DiffChange",  { fg = bg,    bg = d_fg   })
hl(g, "DiffDelete",  { fg = bg,    bg = red    })
hl(g, "DiffText",    { fg = bg,    bg = green  })
hl(g, "DiffAdded",   { fg = green, bg = bg     })
hl(g, "DiffRemoved", { fg = red,   bg = bg     })
hl(g, "DiffLine",    { fg = cyan,  bg = bg     })

-- Manpage buffer
hl(g, "manItalic",         { fg = red }) -- in `less` manpage, this is underlined
hl(g, "manHeader",         { link = "None" })
hl(g, "manSectionHeading", { link = "None" })
hl(g, "manSubHeading",     { link = "None" })
hl(g, "manReference",      { link = "None" })
hl(g, "manOptionDesc",     { link = "None" })

-- Error/Warn
hl(g, "ErrorMsg",     { fg = red,     bg = bg   })
hl(g, "Error",        { fg = bg,      bg = red  })
hl(g, "WarningMsg",   { fg = yellow             })

-- Editor UI
hl(g, "StatusLine",   { fg = fg,      bg = l_bg })
hl(g, "StatusLineNC", { fg = stat_fg, bg = l_bg })
hl(g, "WinSeparator", { fg = l_bg,    bg = l_bg })
hl(g, "PMenu",        { fg = fg,      bg = l_bg })
hl(g, "PMenuSel",     { fg = l_bg,    bg = fg   })
hl(g, "TabLine",      { fg = comment, bg = l_bg })
hl(g, "TabLineFill",  { fg = comment, bg = l_bg })
hl(g, "TabLineSel",   { fg = green,   bg = l_bg })
hl(g, "WildMenu",     { fg = l_bg               })

-- Editor colors
hl(g, "Debug",        { link = "None" })
hl(g, "Directory",    { link = "None" })
hl(g, "Exception",    { link = "None" })
hl(g, "FoldColumn",   { link = "None" })
hl(g, "Folded",       { link = "None" })
hl(g, "MoreMsg",      { link = "None" })
hl(g, "Question",     { link = "None" })
hl(g, "SpecialKey",   { link = "None" })
hl(g, "TooLong",      { link = "None" })
hl(g, "Title",        { link = "None" })
hl(g, "NonText",      { link = "None" })
hl(g, "SignColum",    { link = "None" })
hl(g, "ColorColumn",  { link = "None" })
hl(g, "CursorColumn", { link = "None" })
hl(g, "QuickFixLine", { link = "None" })

-- Syntax highlighting
hl(g, "Character",    { link = "None" })
hl(g, "Comment",      { link = "None" })
hl(g, "Conditional",  { link = "None" })
hl(g, "Constant",     { link = "None" })
hl(g, "Define",       { link = "None" })
hl(g, "Delimiter",    { link = "None" })
hl(g, "Float",        { link = "None" })
hl(g, "Function",     { link = "None" })
hl(g, "Identifier",   { link = "None" })
hl(g, "Include",      { link = "None" })
hl(g, "Keyword",      { link = "None" })
hl(g, "Label",        { link = "None" })
hl(g, "Number",       { link = "None" })
hl(g, "Operator",     { link = "None" })
hl(g, "PreProc",      { link = "None" })
hl(g, "Repeat",       { link = "None" })
hl(g, "Special",      { link = "None" })
hl(g, "SpecialChar",  { link = "None" })
hl(g, "Statement",    { link = "None" })
hl(g, "StorageClass", { link = "None" })
hl(g, "String",       { link = "None" })
hl(g, "Structure",    { link = "None" })
hl(g, "Tag",          { link = "None" })
hl(g, "Type",         { link = "None" })
hl(g, "Typedef",      { link = "None" })

-- Stuff that insists on being annoying
hl(g, "MatchParen", { link = "None" })
hl(g, "Conceal",    { link = "None" })
hl(g, "Todo",       { link = "None" })

-- Anything else that comes up
hl(g, "Underlined", { link = "None" })
