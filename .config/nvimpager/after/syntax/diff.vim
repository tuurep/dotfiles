" Workaround for removed lua comments and diffOldFile being ambiguous:
"
"     --- a/.config/nvim/init.lua
" vs.
"     --- Comment to remove
"
" We want to highlight the removed comment as diffRemoved, but it would get diffOldFile.


" Remove the too greedy hl group
syntax clear DiffOldFile

" Match any triple-dash line (including empty ones) as diffRemoved
syntax match DiffRemoved "^---\( .*\)\?$"

" Quick hack to limit diffOldFile to a typical diffOldFile line
"
" Not robust, for example if you have this lua comment being removed:
" -- /dev/null
"
" But this is a big improvement
syntax match DiffOldFile "^--- \([ab]/.*\|/dev/null\)"

" Attempt to fix:
" +++ b/autoload/sneak.vim
" has DiffAdded hl group
" (Create a new group for it)
syntax match DiffNewFile "^+++ \([ab]/.*\|/dev/null\)"


" Create a new group for unmatched lines in the header block
" The idea is for everything in it to be a dimmed fg color
syntax match DiffMetadata "^new file mode .*"
syntax match DiffMetadata "^deleted file mode .*"
syntax match DiffMetadata "^old mode .*"
syntax match DiffMetadata "^new mode .*"
syntax match DiffMetadata "^similarity index .*"
syntax match DiffMetadata "^rename from .*"
syntax match DiffMetadata "^rename to .*"
syntax match DiffMetadata "^copy from .*"
syntax match DiffMetadata "^copy to .*"
