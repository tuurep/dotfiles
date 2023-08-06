#!/bin/bash

export EDITOR=nvim
export VISUAL=nvim

# If the running shell is not an interactive shell, return without doing anything
[[ $- != *i* ]] && return

# Disable Ctrl+s and Ctrl+q freeze/unfreeze
# Enables Ctrl+s i-search in its place (Ctrl+r opposite direction)
stty -ixon

# If in tty2 console, don't use nerdfont icons in PS1 and PS2
if [ "$TERM" = "linux" ]; then
        PS1="\[\e[0;32m\]$ \[\e[0m\]"
        PS2="\[\e[0;32m\]> \[\e[0m\]"
else
        PS1="\[\e[0;32m\] \[\e[0m\]"
        PS2="\[\e[0;32m\]﬌ \[\e[0m\]"
fi

prompt_cmd() {
        if [[ "$TERM" =~ tmux* ]]; then      
                tmux refresh-client -S # Redraw tmux status bar
        fi
        local short_pwd
        short_pwd=$(basename "$(p)") # See alias for 'p'
        echo -ne "\033]0;${short_pwd}\007" # Set window title; in tmux title is set in .tmux.conf
}

# Right before drawing prompt, this function is executed:
PROMPT_COMMAND=prompt_cmd

# Enable history appending instead of overwriting
shopt -s histappend
export HISTCONTROL=ignoredups

# Aliases:

alias c="cd"
alias l="ls"
alias p='pwd | sed "s|^$HOME|~|"'
alias e="nvim"
alias v="nsxiv"
alias g="grep"
alias q="exit"

alias pl='echo "$OLDPWD" | sed "s|^$HOME|~|"' # Show previous directory, useful with `cd -`

alias ls="ls --color=auto"
alias grep="grep --color=auto -i" # Case insensitive
alias diff="diff --color=auto"
alias cb="NO_COLOR='please' cb"

alias tn="tmux new -s"
alias ta="tmux attach -t"
alias tl="tmux ls"
alias tk="tmux kill-session -t"

alias cfg='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias gr='cd $(git rev-parse --show-toplevel)' # Go to root of current git repo, if any. Else goes to ~.
alias todo='nvim ~/projects/todo.txt'

alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

alias sudo="sudo -v; sudo "
alias sudoreset='faillock --reset --user $USER'
alias update-grub="grub-mkconfig -o /boot/grub/grub.cfg"
alias pac="pacman"
alias sauce="source ~/.bashrc"

alias py="python"
alias jl="julia"
alias sc="shellcheck"
alias vg="valgrind"

alias zat="zathura"
alias ff="firefox"
alias vivaldi-stable="vivaldi-stable --class=Vivaldi"
alias vivaldi="vivaldi-stable"
alias grip="grip -b"
alias tmr="transmission-remote"

alias whereami='echo $HOSTNAME'
alias reset-dunst="killall dunst; notify-send monkey monkey"
alias reset-polybar="killall -q polybar; polybar bar1 2>&1 & disown"
alias gnu="neofetch -L --ascii_distro GNU"

# for gtts-cli and translate-shell: get list of all language tags (works well with grep)
alias langtags="gtts-cli --all"

# show charging status and battery percentage
alias battery="upower -i /org/freedesktop/UPower/devices/battery_BAT0 \
                        | grep 'state:\|percentage:' \
                        | tr -d ' ' \
                        | cut -d ':' -f 2"

# Simple commands that can't be aliases because they need arguments:

# ls long listing with the first line (example: "total 4.0K") removed
ll() {
        ls -oh --color=always "$@" | sed -r '/^total [0-9]+\.?[0-9]*[BKMGT]?$/d'
}

# cd to where a symlinked file points to
cdl() {
        cd "$(dirname "$(readlink -f "$1")")" || exit
}

# cd to a global executable you want to locate
cdw() {
        cd "$(dirname "$(which "$1")")" || exit
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

# === Add stuff to PATH ===

# User scripts and python (pip) stuff
export PATH="$PATH:$HOME/.local/bin"

# cargo install destination
export PATH="$PATH:$HOME/.cargo/bin"

# Originally for vimgolf
GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"


# === Settings for tools ===

source ~/.ls_colors # Sets and exports LS_COLORS env variable

export SYSTEMD_COLORS=16 # Prevent systemctl from using colors outside of my colorscheme

export PYTHONSTARTUP="$HOME/.pyrc" # Config (startup script) for py interactive shell

# Flags for less: case insensitive search and colors
export LESS='-iR'

# Colorize manpages
export LESS_TERMCAP_md=$'\e[32m'        # Bold: green
export LESS_TERMCAP_us=$'\e[34m'        # Underlined: blue (and no underline)
export LESS_TERMCAP_so=$'\e[30;47m'     # Standout: bg on fg
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'

# zoxide: go quickly to frequently visited dir with z <substring-of-path>
# https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init bash)"

# https://github.com/junegunn/fzf
# Enable fzf keybindings:
#       Ctrl-R  command history fzf overwrite
#       Ctrl-T  add fzf search result to command
#       Alt-C   cd to fzf search result (folder)
source /usr/share/fzf/key-bindings.bash

# https://github.com/junegunn/fzf#fuzzy-completion-for-bash-and-zsh
# fzf tab completion on **
source /usr/share/fzf/completion.bash

# Changes fzf colors, see https://github.com/junegunn/fzf/wiki/Color-schemes
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
        --color=fg:#5f6160,bg:#121212,hl:#d0d0d0
        --color=fg+:#d0d0d0,bg+:#121212,hl+:#cc6666
        --color=info:#f0c674,prompt:#b294bb,pointer:#cc6666
        --color=marker:#b294bb,spinner:#f0c674,header:#5f6160
'
