#!/bin/zsh

export EDITOR=nvim
export VISUAL=nvim
export PAGER=nvimpager

# Disable Ctrl+s and Ctrl+q freeze/unfreeze
# Enables Ctrl+s i-search in its place (Ctrl+r opposite direction)
stty -ixon

# === Prompt ===

# If in tty2 console, don't use unrenderable symbols (unicode, nerdfont)
if [ "$TERM" = "linux" ]; then
    PS1="%F{green}$ %f"
    PS2="%F{green}> %f"
else
    PS1="%F{green} %f"     # nf-fa-caret_right
    PS2="%F{green}󱞩 %f"     # nf-md-arrow_right_bottom
fi

precmd() {
    title=$(basename "${PWD/#$HOME/~}")
    echo -ne "\033]0;${title}\007" # Set WM window title

    # If python-virtualenv activated, print venv name on a separate line before PS1
    if [[ -n "$VIRTUAL_ENV" ]]; then
        venv=$(basename "$VIRTUAL_ENV")
        echo -e "\e[0;32m(${venv})\e[0m"
    fi
}

# Symbol shown on 'partial lines'
# 1. when starting to type faster than prompt draws
# 2. lines without newline at the end like: `printf foo`
PROMPT_EOL_MARK=$'%{\e[90m%}%{\e[0m%}'  # nf-cod-circle_small_filled

# === Tab completion ===

# Path for custom completion scipts
# felipec/git-completion is here (default zsh git completions are very slow)
fpath=(~/.config/zsh/completions $fpath)

autoload -U compinit && compinit

# Make completion as close as possible to bash's "show-all-if-unmodified"
setopt NO_AUTO_MENU             # Don't start cycling anything
setopt NO_ALWAYS_LAST_PROMPT    # "Print" the completion list and redraw prompt

setopt LIST_PACKED # Makes completion list a little more compact - definitely nice

# Complete in the middle for example: prefix-|.mp4 Unfortunately moves the cursor to the
# end of the whole word after, which especially sucks for paths.
# Still better than nothing.
# Todo: any way to move cursor to the end of the completed part only?
setopt COMPLETE_IN_WORD

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # Smartcase tab completion

# === Aliases ===

alias l="ls --group-directories-first"
alias e="nvim"
alias d="clear"
alias g="grep"
alias q="exit"
alias n="nmcli"
alias m="mullvad"

# Google translate CLI
# With no flags, can give word definitions too
alias t="trans"

# Reset password timeout, space at end: allow using sudo with aliased commands
alias s="sudo "

alias ..="c .."
alias -- -="c -" # -- required to alias dash

alias mk="mkdir"

alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

alias ls="ls --color=auto"
alias grep="grep --color=auto -i" # Case insensitive
alias rg="rg --smart-case --colors 'path:fg:blue'"
alias diff="diff --color=auto"

alias lg="l -A | grep"
alias llg="ll -A | grep" # See function `ll`

alias drag="blobdrop -p"

alias cf='command git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias todo='nvim ~/projects/todo.txt'
alias eclean="nvim --clean -nu ~/.config/nvim/test/minimal-init.lua"
alias paqsync="nvim -l ~/.config/nvim/lua/update/plugins.lua"
alias tsupdate="nvim -l ~/.config/nvim/lua/update/ts-parsers.lua"

# Use in case of diff `\ No newline at end of file` to prevent diff noise
# https://salferrarello.com/remove-newline-at-end-of-text-file/
alias chompeof="perl -pi -e 'chomp if eof'"

alias pac="pacman"
alias srcinfo="makepkg --printsrcinfo > .SRCINFO"
alias update-grub="grub-mkconfig -o /boot/grub/grub.cfg"
alias sauce="source ~/.zshrc"
alias page="nvimpager"

alias py="python"
alias jl="julia"
alias sc="shellcheck"
alias vg="valgrind"
alias pipx="USE_EMOJI=0 pipx"

alias ff="firefox"
alias vivaldi-stable="vivaldi-stable --class=Vivaldi"
alias vivaldi="vivaldi-stable"
alias yt-dlp="yt-dlp --cookies-from-browser firefox"

alias ncu="nmcli connection up 11t" # n c u 11t

# Workaround `isbnlib` deprecation warning every time command is ran
export PYTHONWARNINGS="ignore"
alias pap="papis"

alias whereami="echo $HOST"

ascii_gnu=$(
cat << 'EOF'
    _-`````-,           ,- '- .
  .'   .- - |          | - -.  `.
 /.'  /                     `.   \
:/   :      _...   ..._      ``   :
::   :     /._ .`:'_.._\.    ||   :
::    `._ ./  ,`  :    \ . _.''   .
`:.      /   |  -.  \-. \\_      /
  \:._ _/  .'   .@)  \@) ` `\ ,.'
     _/,--'       .- .\,-.`--`.
       ,'/''     (( \ `  )
        /'/'  \    `-'  (
         '/''  `._,-----'
          ''/'    .,---'
           ''/'      ;:
             ''/''  ''/
               ''/''/''
                 '/'/'
                  `;
EOF
)
alias gnu='echo "$ascii_gnu"'

# for gtts-cli and translate-shell: get list of all language tags (works well with grep)
alias langtags="gtts-cli --all"

# show charging status and battery percentage
alias battery="upower -i /org/freedesktop/UPower/devices/battery_BAT0 \
                        | grep 'state:\|percentage:' \
                        | tr -d ' ' \
                        | cut -d ':' -f 2"

# Show fan RPM and CPU celsius
alias heat="sensors | grep 'fan\|CPU' | tr -d ' ' | cut -d ':' -f 2"

# === Functions ===

autoload -U zmv # Mass-rename command provided by zsh

# Refresh sudo timeout every time sudo is used
sudo() {
    command sudo -v
    command sudo "$@"
}

# pwd but home as tilde
p() {
    local cwd="${PWD/#$HOME/~}"
    echo "$cwd"
}

# Echo previous working dir
pl() {
    echo "${OLDPWD/#$HOME/~}"
}

# Echo git current branch
b() {
    local branch="$(git branch --show-current 2>/dev/null)"
    if [[ -n $branch ]]; then
        echo "󰘬 $branch"
        return
    fi

    local detached_branch="$(git name-rev --name-only HEAD 2>/dev/null)"
    if [[ -n $detached_branch ]]; then
        echo "󰘬 detached at ${detached_branch#remotes/}"
        return
    fi
}

# Do `p` and `b` but in ANSI bright black
# This is called by commands that change directory, mainly `c` and `z`
echo_cwd_and_branch() {
    echo $'\e[90m'"$(p && b)"$'\e[0m'
}

# ls long listing
# sed removes first line (example: "total 4.0K")
ll() {
    local color
    if [[ -t 1 ]]; then
        # stdout is a terminal - keep color
        color="always"
    else
        # stdout is being piped — disable color
        color="never"
    fi
    l --color="$color" -oh --time-style=long-iso "$@" \
        | sed -r '/^total [0-9]+\.?[0-9]*[BKMGT]?$/d'
}

c() {
    builtin cd "$@" > /dev/null \
        && echo_cwd_and_branch \
        && l
}

# Go to the root of current git repository
# Do nothing if not in a repo
r() {
    local git_root
    git_root="$(git rev-parse --show-toplevel 2>/dev/null)" || return
    c "$git_root"
}

mc() {
    mkdir "$@" && c "$@"
}

eval "$(zoxide init zsh --no-cmd)" # https://github.com/ajeetdsouza/zoxide
z() {
    __zoxide_z "$@" \
        && echo_cwd_and_branch \
        && l
}
zi() {
    # Reimplement default `zi` (zoxide interactive)

    # Improvements:
    #       - Replace $HOME with ~
    #       - Don't show frecency score on the left (still sorted by it)
    #       - "Exact" matching feels better for filepaths

    list=$(zoxide query -l | sed "s|^$HOME|~|")
    for subword in "$@"; do
        list=$(command grep -i "$subword" <<< "$list")
    done

    if [[ -z $list ]]; then
        echo "zoxide: no match found"
        return
    fi

    target=$(fzf --height=~40% --no-sort --exact --select-1 <<< "$list")
    c "${target/#\~/$HOME}"
}

clone() {
    case $# in
        1)
            git clone "git@github.com:$1.git"
            ;;
        2)
            git clone "git@github.com:$1.git" "$2"
            ;;
        *)
            echo "Usage: clone <author>/<reponame> [<directory>]"
            ;;
    esac
}

# tree with the box-drawing characters and end report turned into a dimmed fg color
tree() {
    if [[ ! -t 1 ]]; then
        # if stdout is being piped, no color
        command tree "$@"
        return
    fi
    grayscale_237=$'\e[38;5;237m' # #3a3a3a
    grayscale_240=$'\e[38;5;240m' # #585858
    reset=$'\e[0m'
    command tree -C "$@" \
        | sed -r -e "s/[├└│─]/${grayscale_237}&${reset}/g" \
                 -e "s/[0-9]+ director(y|ies), [0-9]+ files?/${grayscale_240}&${reset}/g"
}

mp() {
    mpv --no-terminal "$@" & disown
}

zat() {
    zathura "$@" &> /dev/null & disown
}

v() {
    nsxiv "$@" &> /dev/null & disown
}

o() {
    for file in "$@"; do
        xdg-open "$file" &> /dev/null & disown
    done
}

# Text-to-speech with Google Translate's API
# use -l for different language (defaults to english)
# use alias langtags to find correct tags
# use -s for slower speech
say() {
    # English accent is chosen by location - choose US English with .us top-level domain
    # Pass -t co.uk to override to British English
    gtts-cli -t us "$@" | mpv --really-quiet -
}

# === Function completions ===

compdef _ls ll
compdef _cd c
compdef _mkdir mc
# compdef _mpv mp
compdef _zathura zat
compdef __zoxide_z z # Completes flags, but not dirs
                     # Todo: would prefer both, but couldn't figure out how (yet)
# Todo:
#   zi can't use flags, all args are treated as subwords
#   mp flag completion fails with:
#       _mpv_generate_if_changed:zstat:7: mp: no such file or directory

# Works without compdef:
#   tree

# No special completions:
#   nsxiv
#   xdg-open
#   gtts-cli

# === ZLE ===

bindkey -e # Emacs/readline style

setopt INTERACTIVE_COMMENTS # Ignore comments
setopt NO_AUTO_REMOVE_SLASH # Don't remove trailing slash when moving left
setopt MARK_DIRS            # Globbed dirs have trailing slash
setopt NO_CASE_GLOB         # Glob case insensitively

# History completion with typed string as prefix
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^[[A" up-line-or-beginning-search   # up
bindkey "^[[B" down-line-or-beginning-search # down

bindkey "^[k" up-line-or-beginning-search   # Alt + k
bindkey "^[j" down-line-or-beginning-search # Alt + j
bindkey "^K"  up-line   # Ctrl + k
bindkey "^J"  down-line # Ctrl + j

bindkey "^[h" emacs-backward-word # Alt + h
bindkey "^[ " emacs-forward-word  # Alt + Space
bindkey "^[l" emacs-forward-word  # Alt + l

bindkey "^[H" beginning-of-line # Shift + Alt + h
bindkey "^[L" end-of-line       # Shift + Alt + l

bindkey "^H"  backward-char # Ctrl + h
bindkey "^L"  forward-char  # Ctrl + l

bindkey "^[w" backward-kill-word # Alt  + w
bindkey "^W"  kill-word          # Ctrl + w
bindkey "^[u" backward-kill-line # Alt  + u
bindkey "^U"  kill-line          # Ctrl + u
bindkey "^[U" kill-whole-line    # Shfit + Alt + u

bindkey "^[[3~" vi-delete-char  # Del

autoload -U edit-command-line
zle -N edit-command-line
bindkey "^[i" edit-command-line # Alt + i

# Debug completion functions: press F1 instead of Tab at completion point
bindkey "^[OP" _complete_help # F1

# Autopair-like binds consistent with neovim insert/command mode
# Insert given surroundings to the left and right of the cursor
register-surround-bind() {
    eval "
        insert-$4() {
            LBUFFER+=\"$1\"
            RBUFFER=\"$2\$RBUFFER\"
        }
    "
    zle -N insert-$4
    bindkey "$3" insert-$4
}
register-surround-bind '(' ')' "^[e" "parens"   # Alt + e
register-surround-bind '{' '}' "^[d" "braces"   # Alt + d
register-surround-bind '[' ']' "^[a" "brackets" # Alt + a
register-surround-bind '<' '>' "^[<" "angles"   # Alt + <

register-surround-bind '( ' ' )' "^[E" "parens-with-spaces"   # Shift + Alt + e
register-surround-bind '{ ' ' }' "^[D" "braces-with-spaces"   # Shift + Alt + d
register-surround-bind '[ ' ' ]' "^[A" "brackets-with-spaces" # Shift + Alt + a
register-surround-bind '< ' ' >' "^[>" "angles-with-spaces"   # Shift + Alt + <

register-surround-bind '\"' '\"' "^[q" "quotes"    # Alt + q
register-surround-bind \'   \'   "^[r" "ticks"     # Alt + r
register-surround-bind '\`' '\`' "^[z" "backticks" # Alt + x

register-surround-bind '\"\"\"' '\"\"\"' "^[Q" "triple-quotes"    # Shift + Alt + q
register-surround-bind '\`\`\`' '\`\`\`' "^[Z" "triple-backticks" # Shift + Alt + x

register-surround-bind '*'  '*'  "^['" "asterisks"        # Alt + '
register-surround-bind '**' '**' "^[*" "double-asterisks" # Shift + Alt + '

register-surround-bind ' ' ' ' "^@" "spaces" # Shift + Alt + '

# Non-surrounding inserts of frequent, hard-to-type chars
register-surround-bind '~/' '' "^[1" "tilde-path"
register-surround-bind '&'  '' "^[2" "ampersand"

# === History ===

export HISTSIZE=5000
export SAVEHIST=5000
export HISTFILE=~/.zsh_history
setopt INC_APPEND_HISTORY
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_ALL_DUPS

# === PATH ===

export PATH="$HOME/.local/bin:$PATH"

# === Settings for tools ===
source ~/.ls_colors                 # Sets and exports LS_COLORS env variable
export SYSTEMD_COLORS=16            # Prevent systemctl from using colors outside of my colorscheme
export VIRTUAL_ENV_DISABLE_PROMPT=1 # Use custom venv-prompt in prompt_cmd
export PYTHONSTARTUP="$HOME/.pyrc"  # Config (startup script) for py interactive shell
source <(fzf --zsh)                 # Set up fzf key bindings and fuzzy completion

# Change fzf colors and icons, refer to: https://vitormv.github.io/fzf-themes/
# Todo: fzf would be a useful tool in tty2, but can't show these icons and some of the colors (e.g. green)
#       However, it's still usable, and this is a very niche use case...
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#767676,bg:#0d0d0d,hl:#d0d0d0
    --color=fg+:#d0d0d0,bg+:#0d0d0d,hl+:#c36060
    --color=selected-fg:#d0d0d0,selected-hl:#c36060
    --color=prompt:#a7bd68,pointer:#a7bd68,marker:#a7bd68
    --color=info:#444444,spinner:#444444,border:#444444,header:#7d9fbd
    --prompt=" " --pointer="│" --marker="" --wrap-sign="        󱞩 "
    --separator=" " --info=inline-right
    --bind alt-j:down,alt-k:up,§:toggle-wrap
    --bind alt-w:backward-kill-subword,ctrl-w:kill-subword
    --bind alt-u:unix-line-discard,ctrl-u:kill-line,alt-U:clear-query
    --bind alt-h:backward-subword,alt-l:forward-subword,ctrl-h:backward-char,ctrl-l:forward-char
    --bind alt-H:beginning-of-line,alt-L:end-of-line
'
export _ZO_FZF_OPTS=$FZF_DEFAULT_OPTS'
    --height=~40% --no-sort --select-1 --exit-0
'
