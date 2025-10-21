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
local bg =      "#0d0d0d"
local fg =      "#d0d0d0"

-- The six basic (ANSI) colors:
local red =     "#c36060"
local green =   "#a7bd68"
local yellow =  "#e8c580"
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
local search =  "#7d7d7d" -- inactive search bg

-- Active line
vim.api.nvim_set_hl(0, "CursorLine",   {})                      -- clear: no cursorline bg
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = dd_fg, bg = bg }) --    ... only the LineNr highlighted

-- Inactive line
vim.api.nvim_set_hl(0, "LineNr",       { fg = linenum })
vim.api.nvim_set_hl(0, "EndOfBuffer",  { fg = linenum })

-- Visual mode inverted colors
vim.api.nvim_set_hl(0, "Normal", { fg = fg, bg = bg })
vim.api.nvim_set_hl(0, "Visual", { fg = bg, bg = fg })

-- Search
vim.api.nvim_set_hl(0, "Search",     { fg = bg, bg = search }) -- cursor not in result
vim.api.nvim_set_hl(0, "CurSearch",  { fg = bg, bg = fg     }) -- cursor in result
vim.api.nvim_set_hl(0, "IncSearch",  { fg = bg, bg = fg     })

-- vim-sneak
vim.api.nvim_set_hl(0, "Sneak",        { link = "Search"    })
vim.api.nvim_set_hl(0, "SneakCurrent", { link = "CurSearch" })
vim.api.nvim_set_hl(0, "SneakScope",   { link = "None"      })

-- Diff highlighting
vim.api.nvim_set_hl(0, "DiffAdd",       { fg = bg,    bg = green })
vim.api.nvim_set_hl(0, "DiffChange",    { fg = bg,    bg = d_fg  })
vim.api.nvim_set_hl(0, "DiffDelete",    { fg = bg,    bg = red   })
vim.api.nvim_set_hl(0, "DiffText",      { fg = bg,    bg = green })
vim.api.nvim_set_hl(0, "DiffAdded",     { fg = green             })
vim.api.nvim_set_hl(0, "DiffRemoved",   { fg = red               })
vim.api.nvim_set_hl(0, "DiffLine",      { fg = blue              })
vim.api.nvim_set_hl(0, "DiffSubName",   { fg = blue              })
vim.api.nvim_set_hl(0, "DiffFile",      { fg = dd_fg             })
vim.api.nvim_set_hl(0, "DiffIndexLine", { fg = dd_fg             })
vim.api.nvim_set_hl(0, "DiffOldFile",   { fg = dd_fg             })
vim.api.nvim_set_hl(0, "DiffNewFile",   { fg = dd_fg             })
vim.api.nvim_set_hl(0, "DiffBDiffer",   { fg = dd_fg             })
vim.api.nvim_set_hl(0, "DiffMetaData",  { fg = dd_fg             })

-- Manpage buffer
vim.api.nvim_set_hl(0, "manUnderline",      { fg = green    })
vim.api.nvim_set_hl(0, "manSectionHeading", { fg = blue     })
vim.api.nvim_set_hl(0, "manSubHeading",     { fg = blue     })
vim.api.nvim_set_hl(0, "manHeader",         { link = "None" })
vim.api.nvim_set_hl(0, "manReference",      { link = "None" })
vim.api.nvim_set_hl(0, "manOptionDesc",     { link = "None" })

-- Error/Warn
vim.api.nvim_set_hl(0, "ErrorMsg",   { fg = red,     bg = bg   })
vim.api.nvim_set_hl(0, "Error",      { fg = bg,      bg = red  })
vim.api.nvim_set_hl(0, "WarningMsg", { fg = yellow             })

-- Editor UI
vim.api.nvim_set_hl(0, "StatusLine",   { fg = fg,      bg = l_bg })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = stat_fg, bg = l_bg })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = l_bg,    bg = l_bg })
vim.api.nvim_set_hl(0, "PMenu",        { fg = fg,      bg = l_bg })
vim.api.nvim_set_hl(0, "PMenuSel",     { fg = l_bg,    bg = fg   })
vim.api.nvim_set_hl(0, "TabLine",      { fg = fg,      bg = l_bg })
vim.api.nvim_set_hl(0, "TabLineFill",  { fg = fg,      bg = l_bg })
vim.api.nvim_set_hl(0, "TabLineSel",   { fg = green,   bg = l_bg })
vim.api.nvim_set_hl(0, "WildMenu",     { fg = l_bg               })

-- Editor colors
vim.api.nvim_set_hl(0, "Debug",        { link = "None" })
vim.api.nvim_set_hl(0, "Directory",    { link = "None" })
vim.api.nvim_set_hl(0, "Exception",    { link = "None" })
vim.api.nvim_set_hl(0, "FoldColumn",   { link = "None" })
vim.api.nvim_set_hl(0, "Folded",       { link = "None" })
vim.api.nvim_set_hl(0, "MoreMsg",      { link = "None" })
vim.api.nvim_set_hl(0, "ModeMsg",      { link = "None" })
vim.api.nvim_set_hl(0, "Question",     { link = "None" })
vim.api.nvim_set_hl(0, "SpecialKey",   { link = "None" })
vim.api.nvim_set_hl(0, "TooLong",      { link = "None" })
vim.api.nvim_set_hl(0, "Title",        { link = "None" })
vim.api.nvim_set_hl(0, "NonText",      { link = "None" })
vim.api.nvim_set_hl(0, "SignColum",    { link = "None" })
vim.api.nvim_set_hl(0, "ColorColumn",  { link = "None" })
vim.api.nvim_set_hl(0, "CursorColumn", { link = "None" })
vim.api.nvim_set_hl(0, "QuickFixLine", { link = "None" })
vim.api.nvim_set_hl(0, "QfLineNr",     { link = "None" })
vim.api.nvim_set_hl(0, "qfSeparator",  { link = "None" })

-- Syntax highlighting
vim.api.nvim_set_hl(0, "Character",    { link = "None" })
vim.api.nvim_set_hl(0, "Comment",      { link = "None" })
vim.api.nvim_set_hl(0, "Conditional",  { link = "None" })
vim.api.nvim_set_hl(0, "Constant",     { link = "None" })
vim.api.nvim_set_hl(0, "Define",       { link = "None" })
vim.api.nvim_set_hl(0, "Delimiter",    { link = "None" })
vim.api.nvim_set_hl(0, "Float",        { link = "None" })
vim.api.nvim_set_hl(0, "Function",     { link = "None" })
vim.api.nvim_set_hl(0, "Identifier",   { link = "None" })
vim.api.nvim_set_hl(0, "Include",      { link = "None" })
vim.api.nvim_set_hl(0, "Keyword",      { link = "None" })
vim.api.nvim_set_hl(0, "Label",        { link = "None" })
vim.api.nvim_set_hl(0, "Number",       { link = "None" })
vim.api.nvim_set_hl(0, "Operator",     { link = "None" })
vim.api.nvim_set_hl(0, "PreProc",      { link = "None" })
vim.api.nvim_set_hl(0, "Repeat",       { link = "None" })
vim.api.nvim_set_hl(0, "Special",      { link = "None" })
vim.api.nvim_set_hl(0, "SpecialChar",  { link = "None" })
vim.api.nvim_set_hl(0, "Statement",    { link = "None" })
vim.api.nvim_set_hl(0, "StorageClass", { link = "None" })
vim.api.nvim_set_hl(0, "String",       { link = "None" })
vim.api.nvim_set_hl(0, "Structure",    { link = "None" })
vim.api.nvim_set_hl(0, "Tag",          { link = "None" })
vim.api.nvim_set_hl(0, "Type",         { link = "None" })
vim.api.nvim_set_hl(0, "Typedef",      { link = "None" })

-- Stuff that insists on being annoying
vim.api.nvim_set_hl(0, "MatchParen", { link = "None" })
vim.api.nvim_set_hl(0, "Conceal",    { link = "None" })
vim.api.nvim_set_hl(0, "Todo",       { link = "None" })

-- Anything else that comes up
vim.api.nvim_set_hl(0, "Underlined", { link = "None" })

-- These come up for example in `nmcli device wifi list`
-- NvimPager creates these highlight groups based on escape sequences:
--
-- https://github.com/lucc/nvimpager/blob/da3bbf02fac10fa3f1d5df501f856c2959329ebf/lua/nvimpager/ansi2highlight.lua
--
-- Set the 6 ANSI colors and add more if it comes up
vim.api.nvim_set_hl(0, "NvimPagerFG_red_BG_",     { fg = red     })
vim.api.nvim_set_hl(0, "NvimPagerFG_green_BG_",   { fg = green   })
vim.api.nvim_set_hl(0, "NvimPagerFG_yellow_BG_",  { fg = yellow  })
vim.api.nvim_set_hl(0, "NvimPagerFG_blue_BG_",    { fg = blue    })
vim.api.nvim_set_hl(0, "NvimPagerFG_magenta_BG_", { fg = magenta })
vim.api.nvim_set_hl(0, "NvimPagerFG_cyan_BG_",    { fg = cyan    })
