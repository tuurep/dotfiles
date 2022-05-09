export EDITOR=vim
export VISUAL=vim

# If the running shell is not an interactive shell, return without doing anything
[[ $- != *i* ]] && return

# If in tty2 console, don't use nerdfont icons in PS1 and PS2
if [ "$TERM" = "linux" ]; then
        PS1="\[\e[0;32m\]> \[\e[0m\]"
        PS2="\[\e[0;32m\]\ \[\e[0m\]"
else
        PS1="\[\e[0;32m\] \[\e[0m\]"
        PS2="\[\e[0;32m\]﬌ \[\e[0m\]"
fi

prompt_comm() {
        if [[ "$TERM" =~ "tmux*" ]]; then      
                tmux refresh-client -S # Redraw tmux status bar
        fi
        local short_pwd=$(basename $(p)) # See alias for 'p'
        echo -ne "\033]0;${short_pwd}\007" # Set window title; in tmux title is set in .tmux.conf
}

# Right before drawing prompt, this function is executed:
PROMPT_COMMAND=prompt_comm

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

# Aliases for colored output:
alias ls="ls --color=auto"
alias grep="grep --colour=auto"
alias egrep="egrep --colour=auto"
alias fgrep="fgrep --colour=auto"
alias diff="diff --color=auto"
alias fd="fd --color=never"

# Aliases:
alias sudo="sudo "
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias l="ls"
alias ll="ls -oh" # long format with no group info - human readable size
alias p="pwd | sed 's|^$HOME|~|'"
alias pac="pacman"
alias clip="xclip -selection clip" # Pipe anything to clipboard
alias zat="zathura"
alias vivaldi-stable="vivaldi-stable --class=Vivaldi"
alias viv="vivaldi-stable"
alias sauce="source ~/.bashrc"
alias q="exit"
alias gr='cd $(git rev-parse --show-toplevel)' # Go to root of current git repo, if any. Else goes to ~.
alias tn="tmux new -s"
alias ta="tmux attach -t"
alias tls="tmux ls"
alias tkill="tmux kill-session -t"
alias cfg="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias py="python"
alias whereami="echo $HOSTNAME"
alias reset-dunst="killall dunst; notify-send monkey monkey"
alias battery="upower -i /org/freedesktop/UPower/devices/battery_BAT1"

# Simple commands that can't be aliases because they need arguments:
# cd to where a symlinked file points to
cdl() {
        cd "$(dirname "$(readlink -f "$1")")"
}

# cd to a global executable you want to locate
cdw() {
        cd "$(dirname "$(which "$1")")"
}

# === Add stuff to PATH ===

# User scripts and python (pip) stuff
export PATH="$PATH:$HOME/.local/bin"

# cargo install destination
export PATH="$PATH:$HOME/.cargo/bin"

# Originally for vimgolf
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"


# === Settings for tools ===

# Flags for less: case insensitive search and colors
export LESS='-iR'

# Colorize manpages
export LESS_TERMCAP_md=$'\e[32m'        # Bold: green
export LESS_TERMCAP_us=$'\e[34m'        # Underlined: blue (and no underline)
export LESS_TERMCAP_so=$'\e[30;47m'     # Standout: fg on bg
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'

# zoxide: go quickly to frequently visited dir with z <substring-of-path>
# https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init bash)"

# https://github.com/junegunn/fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Changes fzf colors, see https://github.com/junegunn/fzf/wiki/Color-schemes
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
        --color=fg:#5f6160,bg:#171919,hl:#d3d3d3
        --color=fg+:#d3d3d3,bg+:#171919,hl+:#cc6666
        --color=info:#f0c674,prompt:#b294bb,pointer:#cc6666
        --color=marker:#b294bb,spinner:#f0c674,header:#5f6160
'
