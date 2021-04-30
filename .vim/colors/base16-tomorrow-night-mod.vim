" Modified from Base16-tomorrow-night by tuurep (github.com/tuurep)
" Base16-tomorrow-night by Chris Kempson (github.com/chriskempson)
" Only works on terminal Vim to keep this file small and easily adjustable

highlight clear
if exists("syntax_on")
    syntax reset
endif

set background=dark
let g:colors_name="base16-tomorrow-night-mod"

" Terminal color definitions: Colors are correct only on a 256-color terminal
let s:b00 = "00"
let s:b01 = "18"
let s:b02 = "19"
let s:b03 = "08"
let s:b04 = "20"
let s:b05 = "07"
let s:b06 = "21"
let s:b07 = "15"
let s:b08 = "01"
let s:b09 = "16"
let s:b0A = "03"
let s:b0B = "02"
let s:b0C = "06"
let s:b0D = "04"
let s:b0E = "05"
let s:b0F = "17"

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

" Vim editor colors
call H("Normal",       s:b05, s:b00, "")
call H("Bold",         "", "", "bold")
call H("Debug",        s:b08, "", "")
call H("Directory",    s:b0D, "", "")
call H("Error",        s:b00, s:b08, "")
call H("ErrorMsg",     s:b08, s:b00, "")
call H("Exception",    s:b08, "", "")
call H("FoldColumn",   s:b0C, s:b01, "")
call H("Folded",       s:b03, s:b01, "")
call H("Italic",       "", "", "none")
call H("Macro",        s:b08, "", "")
call H("MatchParen",   "", s:b03, "")
call H("MoreMsg",      s:b0B, "", "")
call H("Question",     s:b0D, "", "")
call H("Search",       s:b02, s:b0A, "")
call H("IncSearch",    s:b02, s:b0A, "")
call H("Substitute",   s:b02, s:b0A, "none")
call H("SpecialKey",   s:b03, "", "")
call H("TooLong",      s:b08, "", "")
call H("Underlined",   s:b08, "", "")
call H("Visual", "",   s:b02, "")
call H("VisualNOS",    s:b08, "", "")
call H("WarningMsg",   s:b08, "", "")
call H("WildMenu",     s:b08, "", "")
call H("Title",        s:b0D, "", "none")
call H("Conceal",      s:b0D, s:b00, "")
call H("Cursor",       s:b00, s:b05, "")
call H("NonText",      s:b03, "", "")
call H("LineNr",       s:b03, "", "")
call H("SignColum",    s:b03, s:b00, "")
call H("StatusLine",   s:b04, s:b01, "none")
call H("StatusLineNC", s:b03, s:b01, "none")
call H("VertSplit",    s:b01, s:b01, "none")
call H("ColorColumn",  "", s:b01, "none")
call H("CursorColumn", "", s:b01, "none")
call H("CursorLine",   "", s:b00, "none")
call H("CursorLineNr", s:b04, s:b00, "none")
call H("QuickFixLine", "", s:b01, "none")
call H("PMenu",        s:b05, s:b01, "none")
call H("PMenuSel",     s:b01, s:b05, "") 
call H("TabLine",      s:b03, s:b01, "none")
call H("TabLineFill",  s:b03, s:b01, "none")
call H("TabLineSel",   s:b0B, s:b01, "none")

" Standard syntax highlighting
call H("Character",    s:b08, "", "")
call H("Comment",      s:b03, "", "italic")
call H("Conditional",  s:b0E, "", "")
call H("Constant",     s:b09, "", "")
call H("Define",       s:b0E, "", "none")
call H("Delimiter",    s:b0F, "", "")
call H("Float",        s:b09, "", "")
call H("Function",     s:b0D, "", "")
call H("Identifier",   s:b08, "", "none")
call H("Include",      s:b0D, "", "")
call H("Keyword",      s:b0E, "", "")
call H("Label",        s:b0A, "", "")
call H("Number",       s:b09, "", "")
call H("Operator",     s:b05, "", "none")
call H("PreProc",      s:b0A, "", "")
call H("Repeat",       s:b0A, "", "")
call H("Special",      s:b0C, "", "")
call H("SpecialChar",  s:b0F, "", "")
call H("Statement",    s:b08, "", "")
call H("StorageClass", s:b0A, "", "")
call H("String",       s:b0B, "", "")
call H("Structure",    s:b0E, "", "")
call H("Tag",          s:b0A, "", "")
call H("Todo",         s:b0A, s:b01, "")
call H("Type",         s:b0A, "", "none")
call H("Typedef",      s:b0A, "", "")

" C highlighting
call H("cOperator",   s:b0C, "", "")
call H("cPreCondit",  s:b0E, "", "")

" C# highlighting
call H("csClass",                 s:b0A, "", "")
call H("csAttribute",             s:b0A, "", "")
call H("csModifier",              s:b0E, "", "")
call H("csType",                  s:b08, "", "")
call H("csUnspecifiedStatement",  s:b0D, "", "")
call H("csContextualStatement",   s:b0E, "", "")
call H("csNewDecleration",        s:b08, "", "")

" CSS highlighting
call H("cssBraces",      s:b05, "", "")
call H("cssClassName",   s:b0E, "", "")
call H("cssColor",       s:b0C, "", "")

" Diff highlighting
call H("DiffAdd",      s:b0B, s:b01, "")
call H("DiffChange",   s:b03, s:b01, "")
call H("DiffDelete",   s:b08, s:b01, "")
call H("DiffText",     s:b0D, s:b01, "")
call H("DiffAdded",    s:b0B, s:b00, "")
call H("DiffFile",     s:b08, s:b00, "")
call H("DiffNewFile",  s:b0B, s:b00, "")
call H("DiffLine",     s:b0D, s:b00, "")
call H("DiffRemoved",  s:b08, s:b00, "")

" Git highlighting
call H("gitcommitOverflow",       s:b08, "", "")
call H("gitcommitSummary",        s:b0B, "", "")
call H("gitcommitComment",        s:b03, "", "")
call H("gitcommitUntracked",      s:b03, "", "")
call H("gitcommitDiscarded",      s:b03, "", "")
call H("gitcommitSelected",       s:b03, "", "")
call H("gitcommitHeader",         s:b0E, "", "")
call H("gitcommitSelectedType",   s:b0D, "", "")
call H("gitcommitUnmergedType",   s:b0D, "", "")
call H("gitcommitDiscardedType",  s:b0D, "", "")
call H("gitcommitBranch",         s:b09, "", "bold")
call H("gitcommitUntrackedFile",  s:b0A, "", "")
call H("gitcommitUnmergedFile",   s:b08, "", "bold")
call H("gitcommitDiscardedFile",  s:b08, "", "bold")
call H("gitcommitSelectedFile",   s:b0B, "", "bold")

" GitGutter highlighting
call H("GitGutterAdd",            s:b0B, s:b01, "")
call H("GitGutterChange",         s:b0D, s:b01, "")
call H("GitGutterDelete",         s:b08, s:b01, "")
call H("GitGutterChangeDelete",   s:b0E, s:b01, "")

" HTML highlighting
call H("htmlBold",    s:b0A, "", "")
call H("htmlItalic",  s:b0E, "", "")
call H("htmlEndTag",  s:b05, "", "")
call H("htmlTag",     s:b05, "", "")

" JavaScript highlighting
call H("javaScript",        s:b05, "", "")
call H("javaScriptBraces",  s:b05, "", "")
call H("javaScriptNumber",  s:b09, "", "")
" pangloss/vim-javascript highlighting
call H("jsOperator",          s:b0D, "", "")
call H("jsStatement",         s:b0E, "", "")
call H("jsReturn",            s:b0E, "", "")
call H("jsThis",              s:b08, "", "")
call H("jsClassDefinition",   s:b0A, "", "")
call H("jsFunction",          s:b0E, "", "")
call H("jsFuncName",          s:b0D, "", "")
call H("jsFuncCall",          s:b0D, "", "")
call H("jsClassFuncName",     s:b0D, "", "")
call H("jsClassMethodType",   s:b0E, "", "")
call H("jsRegexpString",      s:b0C, "", "")
call H("jsGlobalObjects",     s:b0A, "", "")
call H("jsGlobalNodeObjects", s:b0A, "", "")
call H("jsExceptions",        s:b0A, "", "")
call H("jsBuiltins",          s:b0A, "", "")

" Mail highlighting
call H("mailQuoted1",  s:b0A, "", "")
call H("mailQuoted2",  s:b0B, "", "")
call H("mailQuoted3",  s:b0E, "", "")
call H("mailQuoted4",  s:b0C, "", "")
call H("mailQuoted5",  s:b0D, "", "")
call H("mailQuoted6",  s:b0A, "", "")
call H("mailURL",      s:b0D, "", "")
call H("mailEmail",    s:b0D, "", "")

" Markdown highlighting
call H("markdownCode",              s:b0B, "", "")
call H("markdownError",             s:b05, s:b00, "")
call H("markdownCodeBlock",         s:b0B, "", "")
call H("markdownHeadingDelimiter",  s:b0D, "", "")

" Fern highlighting
call H("FernSpinner",    "", s:b00, "")

" NERDTree highlighting
call H("NERDTreeDirSlash",  s:b0D, "", "")
call H("NERDTreeExecFile",  s:b05, "", "")

" PHP highlighting
call H("phpMemberSelector",  s:b05, "", "")
call H("phpComparison",      s:b05, "", "")
call H("phpParent",          s:b05, "", "")
call H("phpMethodsVar",      s:b0C, "", "")

" Python highlighting
call H("pythonOperator",  s:b0E, "", "")
call H("pythonRepeat",    s:b0E, "", "")
call H("pythonInclude",   s:b0E, "", "")
call H("pythonStatement", s:b0E, "", "")

" Ruby highlighting
call H("rubyAttribute",               s:b0D, "", "")
call H("rubyConstant",                s:b0A, "", "")
call H("rubyInterpolationDelimiter",  s:b0F, "", "")
call H("rubyRegexp",                  s:b0C, "", "")
call H("rubySymbol",                  s:b0B, "", "")
call H("rubyStringDelimiter",         s:b0B, "", "")

" SASS highlighting
call H("sassidChar",     s:b08, "", "")
call H("sassClassChar",  s:b09, "", "")
call H("sassInclude",    s:b0E, "", "")
call H("sassMixing",     s:b0E, "", "")
call H("sassMixinName",  s:b0D, "", "")

" Signify highlighting
call H("SignifySignAdd",     s:b0B, s:b01, "")
call H("SignifySignChange",  s:b0D, s:b01, "")
call H("SignifySignDelete",  s:b08, s:b01, "")

" Spelling highlighting
call H("SpellBad",     "", "", "undercurl")
call H("SpellLocal",   "", "", "undercurl")
call H("SpellCap",     "", "", "undercurl")
call H("SpellRare",    "", "", "undercurl")

" Startify highlighting
call H("StartifyBracket",  s:b03, "", "")
call H("StartifyFile",     s:b07, "", "")
call H("StartifyFooter",   s:b03, "", "")
call H("StartifyHeader",   s:b0B, "", "")
call H("StartifyNumber",   s:b09, "", "")
call H("StartifyPath",     s:b03, "", "")
call H("StartifySection",  s:b0E, "", "")
call H("StartifySelect",   s:b0C, "", "")
call H("StartifySlash",    s:b03, "", "")
call H("StartifySpecial",  s:b03, "", "")

" Java highlighting
call H("javaOperator",     s:b0D, "", "")

" Remove color variables
unlet s:b00 s:b01 s:b02 s:b03 s:b04 s:b05 s:b06 s:b07 s:b08 s:b09 s:b0A s:b0B s:b0C s:b0D s:b0E s:b0F
