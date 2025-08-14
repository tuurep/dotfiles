" Workaround for removed lua comments and diffOldFile being ambiguous:
"
"     --- a/.config/nvim/init.lua
" vs.
"     --- Comment to remove
"
" We want to highlight the removed comment as diffRemoved, but it would get diffOldFile.


" Remove the too greedy hl group
syntax clear diffOldFile

" Match any triple-dash line (including empty ones) as diffRemoved
syntax match diffRemoved "^---\( .*\)\?$"

" Quick hack to limit diffOldFile to a typical diffOldFile line
"
" Not robust, for example if you have this lua comment being removed:
" -- /dev/null
"
" But this is a big improvement
syntax match diffOldFile "^--- \([ab]/.*\|/dev/null\)"


" Create a new group for unmatched lines in the header block
" The idea is for everything in it to be a dimmed fg color
syntax match diffMetadata "^new file mode .*"
syntax match diffMetadata "^deleted file mode .*"
syntax match diffMetadata "^old mode .*"
syntax match diffMetadata "^new mode .*"
syntax match diffMetadata "^similarity index .*"
syntax match diffMetadata "^rename from .*"
syntax match diffMetadata "^rename to .*"
syntax match diffMetadata "^copy from .*"
syntax match diffMetadata "^copy to .*"
