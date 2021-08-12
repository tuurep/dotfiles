export EDITOR=vim
export VISUAL=vim

# If the running shell is not an interactive shell, return without doing anything
[[ $- != *i* ]] && return

# Root check
if [[ ${EUID} == 0 ]] ; then
    # (This is never entered coz root doesn't use this .bashrc)
    PS1="\[\e[0;31m\]# \[\e[0m\]"
    PS2="\[\e[0;31m\]﬌ \[\e[0m\]"
else
    PS1="\[\e[0;32m\] \[\e[0m\]"
    PS2="\[\e[0;32m\]﬌ \[\e[0m\]"
fi

prompt_comm() {
    if [[ "$TERM" =~ "tmux*" ]]; then      
        tmux refresh-client -S # Redraw tmux status bar
    fi
    local short_pwd=$(basename $(pwd | sed 's|^$HOME|~|'))
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
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias l="ls"
alias ll="ls -oh" # long format with no group info - human readable size
alias p="pwd | sed 's|^$HOME|~|'"
alias clip="xclip -selection clip" # Pipe anything to clipboard
alias zathura="GTK_THEME=Adwaita zathura"
alias zat="zathura"
alias viv="vivaldi-stable"
alias sauce="source ~/.bashrc"
alias quote="~/scripts/quote-of-the-day/quote-of-the-day.sh" # https://github.com/tuurep/quote-of-the-day.sh
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

# Colored output for less (but doesn't color stdout piped to less)
# Colors manpages for example. bold=green, underlined=blue
export LESS='-R --use-color -Dd+g$Du+b'

# zoxide: go quickly to frequently visited dir with z <substring-of-path>
# https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init bash)"

# Changes fzf colors, see https://github.com/junegunn/fzf/wiki/Color-schemes
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#5f6160,bg:#171919,hl:#d3d3d3
    --color=fg+:#d3d3d3,bg+:#171919,hl+:#cd6a6a
    --color=info:#f0c674,prompt:#b29bbf,pointer:#cd6a6a
    --color=marker:#b29bbf,spinner:#f0c674,header:#5f6160
'
