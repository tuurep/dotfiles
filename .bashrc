export EDITOR=vim
export VISUAL=vim

# If the running shell is not an interactive shell, return without doing anything
[[ $- != *i* ]] && return

PS1="\[\e[0;32m\] \[\e[0m\]"
PS2="\[\e[0;32m\]﬌ \[\e[0m\]"

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
alias zathura="GTK_THEME=Adwaita zathura"
alias zat="zathura"
alias vivaldi-stable="vivaldi-stable --class=Vivaldi"
alias viv="vivaldi-stable"
alias sauce="source ~/.bashrc"
alias q="exit"
alias tn="tmux new -s"
alias ta="tmux attach -t"
alias tls="tmux ls"
alias tkill="tmux kill-session -t"
alias cfg="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias ipy="ipython"


# === Add stuff to PATH ===

# https://github.com/junegunn/fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Python3 wants this
export PATH="$PATH:$HOME/.local/bin"

# Originally for vimgolf
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"

# cargo install destination
export PATH="$PATH:$HOME/.cargo/bin"


# === Settings for tools ===

# Flags for less: case insensitive search and colors
export LESS='-iR'
export LESS_TERMCAP_md=$'\e[32m'        # Bold: green
export LESS_TERMCAP_us=$'\e[34m'        # Underlined: blue
export LESS_TERMCAP_so=$'\e[30;47m'     # Standout: fg on bg
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'

# zoxide: go quickly to frequently visited dir with z <substring-of-path>
# https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init bash)"

# Changes fzf colors, see https://github.com/junegunn/fzf/wiki/Color-schemes
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#5f6160,bg:#171919,hl:#d3d3d3
    --color=fg+:#d3d3d3,bg+:#171919,hl+:#cc6666
    --color=info:#f0c674,prompt:#b294bb,pointer:#cc6666
    --color=marker:#b294bb,spinner:#f0c674,header:#5f6160
'
