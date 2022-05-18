" goodnight.vim colorscheme by tuurep (github.com/tuurep)
" This colorscheme is based on Base16-Tomorrow-Night by Chris Kempson (github.com/chriskempson)

highlight clear
syntax reset

set background=dark
let g:colors_name="goodnight"

" ====== Terminal Colors ======
"
" Expects colors to be set in the terminal emulator
" Terminal needs to be able to set colors 0-23 as:
"
" Color00: #171818
" Color01: #cc6666
" Color02: #a7bd68
" Color03: #f0c674
" Color04: #81a2be
" Color05: #b294bb
" Color06: #8abeb7
" Color07: #d0d0d0
" Color08: #5f6160
" Color09: (unused)
" Color10: (unused)
" Color11: (unused)
" Color12: (unused)
" Color13: (unused)
" Color14: (unused)
" Color15: #ffffff
" Color16: #de935f
" Color17: #a3685a
" Color18: #222525
" Color19: #313438
" Color20: #909090
" Color21: #eaeaea
" Color22: #656e6e
" Color23: #404040

" Default background and foreround:
let s:bg = "00"
let s:fg = "07"

" The six basic (ANSI) colors:
let s:red = "01"
let s:green = "02"
let s:yellow = "03"
let s:blue = "04"
let s:magenta = "05"
let s:cyan = "06"

" More colors (orange most common):
let s:orange = "16"
let s:bright_white = "15"
let s:brown = "17"

" Mostly greyish, important colors for statusbars, borders and such:
let s:comment = "08"
let s:selection_bg = "19"
let s:light_bg = "18"
let s:dark_fg = "20"
let s:light_fg = "21"
let s:statusln_fg = "22"
let s:line_number = "23"


" Highlighting function
function! H(group, ctermfg, ctermbg, cterm)
    if a:ctermfg != ""
        exec "hi " . a:group . " ctermfg=" . a:ctermfg
    endif
    if a:ctermbg != ""
        exec "hi " . a:group . " ctermbg=" . a:ctermbg
    endif
    if a:cterm != ""
        exec "hi " . a:group . " cterm=" . a:cterm
    endif
endfunction

" No cursorline background, but still need current line number highlighted
hi clear CursorLine
call H("CursorLineNr", s:fg, s:bg, "none")
call H("LineNr",       s:line_number, "", "")

" Vim editor colors
call H("Normal",       s:fg, s:bg, "")
call H("Bold",         "", "", "bold")
call H("Debug",        s:red, "", "")
call H("Directory",    s:blue, "", "")
call H("Error",        s:bg, s:red, "")
call H("ErrorMsg",     s:red, s:bg, "")
call H("Exception",    s:red, "", "")
call H("FoldColumn",   s:cyan, s:light_bg, "")
call H("Folded",       s:comment, s:light_bg, "")
call H("Italic",       "", "", "none")
call H("Macro",        s:red, "", "")
call H("MatchParen",   "", s:comment, "")
call H("MoreMsg",      s:green, "", "")
call H("Question",     s:green, "", "")
call H("Search",       s:bg, s:yellow, "")
call H("IncSearch",    s:orange, s:bg, "")
call H("CurrentSearch",s:bg, s:orange, "")        " WARNING: requires plugin qxxxb/vim-searchhi
call H("SearchCursor", s:orange, s:bg, "")        " WARNING: requires plugin qxxxb/vim-searchhi
call H("Substitute",   s:bg, s:yellow, "none")
call H("SpecialKey",   s:comment, "", "")
call H("TooLong",      s:red, "", "")
call H("Underlined",   s:red, "", "")
call H("Visual",       s:bg, s:fg, "")
call H("VisualNOS",    s:red, "", "")
call H("WarningMsg",   s:red, "", "")
call H("WildMenu",     s:light_bg, "", "")
call H("Title",        s:blue, "", "none")
call H("Conceal",      s:blue, s:bg, "")
call H("Cursor",       s:bg, s:fg, "")
call H("NonText",      s:comment, "", "")
call H("EndOfBuffer",  s:line_number, "", "")
call H("SignColum",    s:comment, s:bg, "")
call H("StatusLine",   s:fg, s:light_bg, "none")
call H("StatusLineNC", s:statusln_fg, s:light_bg, "none")
call H("VertSplit",    s:light_bg, s:light_bg, "none")
call H("ColorColumn",  "", s:light_bg, "none")
call H("CursorColumn", "", s:light_bg, "none")
call H("QuickFixLine", "", s:light_bg, "none")
call H("PMenu",        s:fg, s:light_bg, "none")
call H("PMenuSel",     s:light_bg, s:fg, "") 
call H("TabLine",      s:comment, s:light_bg, "none")
call H("TabLineFill",  s:comment, s:light_bg, "none")
call H("TabLineSel",   s:green, s:light_bg, "none")

" Standard syntax highlighting
call H("Character",    s:red, "", "")
call H("Comment",      s:comment, "", "italic")
call H("Todo",         s:yellow, s:bg, "italic")
call H("Conditional",  s:magenta, "", "")
call H("Constant",     s:orange, "", "")
call H("Define",       s:magenta, "", "none")
call H("Delimiter",    s:brown, "", "")
call H("Float",        s:orange, "", "")
call H("Function",     s:blue, "", "")
call H("Identifier",   s:red, "", "none")
call H("Include",      s:blue, "", "")
call H("Keyword",      s:magenta, "", "")
call H("Label",        s:yellow, "", "")
call H("Number",       s:orange, "", "")
call H("Operator",     s:fg, "", "none")
call H("PreProc",      s:yellow, "", "")
call H("Repeat",       s:yellow, "", "")
call H("Special",      s:cyan, "", "")
call H("SpecialChar",  s:brown, "", "")
call H("Statement",    s:red, "", "")
call H("StorageClass", s:yellow, "", "")
call H("String",       s:green, "", "")
call H("Structure",    s:magenta, "", "")
call H("Tag",          s:yellow, "", "")
call H("Type",         s:yellow, "", "none")
call H("Typedef",      s:yellow, "", "")

" C highlighting
call H("cOperator",   s:cyan, "", "")
call H("cPreCondit",  s:magenta, "", "")

" C# highlighting
call H("csClass",                 s:yellow, "", "")
call H("csAttribute",             s:yellow, "", "")
call H("csModifier",              s:magenta, "", "")
call H("csType",                  s:red, "", "")
call H("csUnspecifiedStatement",  s:blue, "", "")
call H("csContextualStatement",   s:magenta, "", "")
call H("csNewDecleration",        s:red, "", "")

" CSS highlighting
call H("cssBraces",      s:fg, "", "")
call H("cssClassName",   s:magenta, "", "")
call H("cssColor",       s:cyan, "", "")

" Diff highlighting
call H("DiffAdd",      s:bg, s:green, "")
call H("DiffChange",   s:bg, s:magenta, "")
call H("DiffDelete",   s:bg, s:red, "")
call H("DiffText",     s:blue, s:bg, "")
call H("DiffAdded",    s:green, s:bg, "")
call H("DiffFile",     s:red, s:bg, "")
call H("DiffNewFile",  s:green, s:bg, "")
call H("DiffLine",     s:blue, s:bg, "")
call H("DiffRemoved",  s:red, s:bg, "")

" Git highlighting
call H("gitcommitOverflow",       s:red, "", "")
call H("gitcommitSummary",        s:green, "", "")
call H("gitcommitComment",        s:comment, "", "")
call H("gitcommitUntracked",      s:comment, "", "")
call H("gitcommitDiscarded",      s:comment, "", "")
call H("gitcommitSelected",       s:comment, "", "")
call H("gitcommitHeader",         s:magenta, "", "")
call H("gitcommitSelectedType",   s:blue, "", "")
call H("gitcommitUnmergedType",   s:blue, "", "")
call H("gitcommitDiscardedType",  s:blue, "", "")
call H("gitcommitBranch",         s:orange, "", "bold")
call H("gitcommitUntrackedFile",  s:yellow, "", "")
call H("gitcommitUnmergedFile",   s:red, "", "bold")
call H("gitcommitDiscardedFile",  s:red, "", "bold")
call H("gitcommitSelectedFile",   s:green, "", "bold")

" GitGutter highlighting
call H("GitGutterAdd",            s:green, s:light_bg, "")
call H("GitGutterChange",         s:blue, s:light_bg, "")
call H("GitGutterDelete",         s:red, s:light_bg, "")
call H("GitGutterChangeDelete",   s:magenta, s:light_bg, "")

" Undotree highlighting
call H("UndoTreeNodeCurrent",   s:fg, "", "")
call H("UndoTreeCurrent",       s:fg, "", "")
call H("UndoTreeHead",          s:green, "", "")
call H("UndotreeSavedSmall",    s:green, "", "")
call H("UndoTreeSavedBig",      s:bg, s:green, "")

" HTML highlighting
call H("htmlBold",    s:yellow, "", "")
call H("htmlItalic",  s:magenta, "", "")
call H("htmlEndTag",  s:fg, "", "")
call H("htmlTag",     s:fg, "", "")

" JavaScript highlighting
call H("javaScript",        s:fg, "", "")
call H("javaScriptBraces",  s:fg, "", "")
call H("javaScriptNumber",  s:orange, "", "")

" pangloss/vim-javascript highlighting
call H("jsOperator",          s:blue, "", "")
call H("jsStatement",         s:magenta, "", "")
call H("jsReturn",            s:magenta, "", "")
call H("jsThis",              s:red, "", "")
call H("jsClassDefinition",   s:yellow, "", "")
call H("jsFunction",          s:magenta, "", "")
call H("jsFuncName",          s:blue, "", "")
call H("jsFuncCall",          s:blue, "", "")
call H("jsClassFuncName",     s:blue, "", "")
call H("jsClassMethodType",   s:magenta, "", "")
call H("jsRegexpString",      s:cyan, "", "")
call H("jsGlobalObjects",     s:yellow, "", "")
call H("jsGlobalNodeObjects", s:yellow, "", "")
call H("jsExceptions",        s:yellow, "", "")
call H("jsBuiltins",          s:yellow, "", "")

" Mail highlighting
call H("mailQuoted1",  s:yellow, "", "")
call H("mailQuoted2",  s:green, "", "")
call H("mailQuoted3",  s:magenta, "", "")
call H("mailQuoted4",  s:cyan, "", "")
call H("mailQuoted5",  s:blue, "", "")
call H("mailQuoted6",  s:yellow, "", "")
call H("mailURL",      s:blue, "", "")
call H("mailEmail",    s:blue, "", "")

" Markdown highlighting
call H("markdownCode",              s:green, "", "")
call H("markdownError",             s:fg, s:bg, "")
call H("markdownCodeBlock",         s:green, "", "")
call H("markdownHeadingDelimiter",  s:blue, "", "")

" Fern highlighting
call H("FernSpinner",    "", s:bg, "")

" NERDTree highlighting
call H("NERDTreeDirSlash",  s:blue, "", "")
call H("NERDTreeExecFile",  s:fg, "", "")

" PHP highlighting
call H("phpMemberSelector",  s:fg, "", "")
call H("phpComparison",      s:fg, "", "")
call H("phpParent",          s:fg, "", "")
call H("phpMethodsVar",      s:cyan, "", "")

" Python highlighting
call H("pythonOperator",  s:magenta, "", "")
call H("pythonRepeat",    s:magenta, "", "")
call H("pythonInclude",   s:magenta, "", "")
call H("pythonStatement", s:magenta, "", "")

" Ruby highlighting
call H("rubyAttribute",               s:blue, "", "")
call H("rubyConstant",                s:yellow, "", "")
call H("rubyInterpolationDelimiter",  s:brown, "", "")
call H("rubyRegexp",                  s:cyan, "", "")
call H("rubySymbol",                  s:green, "", "")
call H("rubyStringDelimiter",         s:green, "", "")

" SASS highlighting
call H("sassidChar",     s:red, "", "")
call H("sassClassChar",  s:orange, "", "")
call H("sassInclude",    s:magenta, "", "")
call H("sassMixing",     s:magenta, "", "")
call H("sassMixinName",  s:blue, "", "")

" Signify highlighting
call H("SignifySignAdd",     s:green, s:light_bg, "")
call H("SignifySignChange",  s:blue, s:light_bg, "")
call H("SignifySignDelete",  s:red, s:light_bg, "")

" Spelling highlighting
call H("SpellBad",     "", "", "undercurl")
call H("SpellLocal",   "", "", "undercurl")
call H("SpellCap",     "", "", "undercurl")
call H("SpellRare",    "", "", "undercurl")

" Startify highlighting
call H("StartifyBracket",  s:comment, "", "")
call H("StartifyFile",     s:bright_white, "", "")
call H("StartifyFooter",   s:comment, "", "")
call H("StartifyHeader",   s:green, "", "")
call H("StartifyNumber",   s:orange, "", "")
call H("StartifyPath",     s:comment, "", "")
call H("StartifySection",  s:magenta, "", "")
call H("StartifySelect",   s:cyan, "", "")
call H("StartifySlash",    s:comment, "", "")
call H("StartifySpecial",  s:comment, "", "")

" Java highlighting
call H("javaOperator",     s:blue, "", "")

" Remove color variables
unlet s:bg s:fg s:red s:green s:yellow s:blue s:magenta s:cyan s:bright_white s:orange s:brown s:light_bg s:selection_bg s:comment s:dark_fg s:light_fg s:statusln_fg s:line_number
