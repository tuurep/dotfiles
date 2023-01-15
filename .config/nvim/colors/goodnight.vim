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
" Color00: #121212
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
call H("ErrorMsg",     s:red, s:bg, "")
call H("Error",        s:bg, s:red, "")
call H("Exception",    s:red, "", "")
call H("FoldColumn",   s:cyan, s:light_bg, "")
call H("Folded",       s:comment, s:light_bg, "")
call H("Italic",       "", "", "none")
call H("MatchParen",   "", s:comment, "")
call H("MoreMsg",      s:fg, "", "")
call H("Question",     s:fg, "", "")
call H("Search",       s:bg, s:brown, "")
call H("IncSearch",    s:yellow, s:bg, "")
call H("CurrentSearch",s:bg, s:yellow, "")        " WARNING: requires plugin qxxxb/vim-searchhi
call H("SearchCursor", s:yellow, s:bg, "")        " WARNING: requires plugin qxxxb/vim-searchhi
call H("Substitute",   s:bg, s:yellow, "none")
call H("SpecialKey",   s:comment, "", "")
call H("TooLong",      s:red, "", "")
call H("Underlined",   s:yellow, "", "none")
call H("Visual",       s:bg, s:fg, "")
call H("VisualNOS",    s:red, "", "")
call H("WarningMsg",   s:red, "", "")
call H("WildMenu",     s:light_bg, "", "")
call H("Title",        s:blue, "", "none")
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

" Diff highlighting
call H("DiffAdd",      s:bg, s:green, "")
call H("DiffChange",   s:bg, s:dark_fg, "")
call H("DiffDelete",   s:bg, s:red, "")
call H("DiffText",     s:bg, s:green, "")
call H("DiffAdded",    s:green, s:bg, "")
call H("DiffRemoved",  s:red, s:bg, "")
call H("DiffLine",     s:blue, s:bg, "")

" Undotree highlighting
call H("UndoTreeNodeCurrent",   s:fg, "", "")
call H("UndoTreeCurrent",       s:fg, "", "")
call H("UndoTreeHead",          s:green, "", "")
call H("UndotreeSavedSmall",    s:green, "", "")
call H("UndoTreeSavedBig",      s:bg, s:green, "")
call H("UndotreeTimeStamp",     s:comment, "", "")

" Fern highlighting
call H("FernSpinner",    "", s:bg, "")

" vimtex
call H("texCmd",                s:red, "", "")
call H("texCmdStyle",           s:red, "", "")
call H("texFileArg",            s:fg, "", "")
call H("texFilesArg",           s:fg, "", "")
call H("texConditionalArg",     s:fg, "", "")
call H("texEnvArgName",         s:fg, "", "")
call H("texTitleArg",           s:fg, "", "")
call H("texPartArgTitle",       s:fg, "", "")
call H("texRefArg",             s:blue, "", "")
call H("texRefConcealedArg",    s:blue, "", "")
call H("texVerbZone",           s:green, "", "")
call H("texVerbZoneInline",     s:green, "", "")


" Treesitter capture groups
" The full list is found here:
" https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md
" Base16 styling guidelines will help in choosing sensible colors:
" https://github.com/chriskempson/base16/blob/main/styling.md
call H("@comment",              s:comment, "", "italic")
call H("@preproc",              s:magenta, "", "")
call H("@define",               s:magenta, "", "")
call H("@operator",             s:fg, "", "")
call H("@punctuation",          s:fg, "", "")
call H("@punctuation.delimiter",s:fg, "", "")
call H("@punctuation.bracket",  s:fg, "", "")
call H("@punctuation.special",  s:cyan, "", "")
call H("@string",               s:green, "", "")
call H("@string.regex",         s:cyan, "", "")
call H("@string.escape",        s:cyan, "", "")
call H("@string.special",       s:cyan, "", "")
call H("@character",            s:green, "", "")
call H("@character.special",    s:cyan, "", "")
call H("@boolean",              s:orange, "", "")
call H("@number",               s:orange, "", "")
call H("@float",                s:orange, "", "")
call H("@function",             s:fg, "", "")
call H("@function.builtin",     s:magenta, "", "")
call H("@function.call",        s:fg, "", "")
call H("@function.macro",       s:fg, "", "")
call H("@method",               s:fg, "", "")
call H("@method.call",          s:fg, "", "")
call H("@constructor",          s:fg, "", "")
call H("@parameter",            s:fg, "", "")
call H("@keyword",              s:magenta, "", "")
call H("@keyword.function",     s:magenta, "", "")
call H("@keyword.operator",     s:magenta, "", "")
call H("@keyword.return",       s:magenta, "", "")
call H("@conditional",          s:magenta, "", "")
call H("@conditional.ternary",  s:magenta, "", "")
call H("@repeat",               s:magenta, "", "")
call H("@debug",                s:magenta, "", "")
call H("@label",                s:magenta, "", "")
call H("@include",              s:magenta, "", "")
call H("@exception",            s:magenta, "", "")
call H("@type",                 s:blue, "", "")
call H("@type.builtin",         s:blue, "", "")
call H("@type.definition",      s:blue, "", "")
call H("@type.qualifier",       s:blue, "", "")
call H("@storageclass",         s:magenta, "", "")
call H("@attribute",            s:orange, "", "")
call H("@field",                s:fg, "", "")
call H("@property",             s:fg, "", "")
call H("@variable",             s:fg, "", "")
call H("@variable.builtin",     s:magenta, "", "")
call H("@constant",             s:fg, "", "")
call H("@constant.builtin",     s:orange, "", "")
call H("@namespace",            s:blue, "", "")
call H("@symbol",               s:blue, "", "")
call H("@text",                 s:fg, "", "")
call H("@text.strong",          s:yellow, "", "")
call H("@text.emphasis",        s:magenta, "", "")
call H("@text.underline",       s:yellow, "", "")
call H("@text.strike",          s:red, "", "")
call H("@text.title",           s:blue, "", "")
call H("@text.literal",         s:green, "", "")
call H("@text.quote",           s:cyan, "", "")
call H("@text.uri",             s:orange, "", "")
call H("@text.reference",       s:red, "", "")
call H("@text.diff.add",        s:green, "", "")
call H("@text.diff.delete",     s:red, "", "")
call H("@tag",                  s:red, "", "")
call H("@tag.attribute",        s:yellow, "", "")
call H("@tag.delimiter",        s:fg, "", "")

" Link for languages that don't have a treesitter parser
" To have somewhat sensible defaults (otherwise Vim's default colorscheme will show)
hi! link Character @character
hi! link Comment @comment
hi! link Conditional @conditional
hi! link Constant @constant
hi! link Define @define
hi! link Delimiter @punctuation.delimiter
hi! link Float @float
hi! link Function @function
hi! link Identifier @text
hi! link Include @include
hi! link Keyword @keyword
hi! link Label @label
hi! link Number @number
hi! link Operator @operator
hi! link PreProc @preproc
hi! link Repeat @repeat
hi! link Special @punctuation.special
hi! link SpecialChar @character.special
hi! link Statement @keyword
hi! link StorageClass @storageclass
hi! link String @string
hi! link Structure @keyword
hi! link Tag @tag
hi! link Type @type
hi! link Typedef @type.definition

" Fine-tuning and pinpointing issues
" XML
hi! link xmlTagName @tag
hi! link xmlProcessingDelim @tag.delimiter
hi! link xmlAttrib @tag.attribute

" Markdown
call H("@punctuation.special.markdown", s:blue, "", "")

" TSPlayground preview window
hi! link markdownHeadingDelimiter @punctuation.special.markdown
hi! link markdownListMarker @punctuation.special.markdown
hi! link markdownOrderedListMarker @punctuation.special.markdown

" :checkhealth OK
call H("healthSuccess", s:bg, s:green, "")

" git commit
call H("@text.reference.gitcommit", s:green, "", "")
call H("@text.uri.gitcommit",       s:fg, "", "")

" Remove color variables
unlet s:bg s:fg s:red s:green s:yellow s:blue s:magenta s:cyan s:bright_white s:orange s:brown s:light_bg s:selection_bg s:comment s:dark_fg s:light_fg s:statusln_fg s:line_number
