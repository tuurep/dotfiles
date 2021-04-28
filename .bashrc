export EDITOR=vim
export VISUAL=vim

# If the running shell is not an interactive shell, return without doing anything
[[ $- != *i* ]] && return

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
        if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi
        
        alias ls="ls --color=auto"
        alias grep="grep --colour=auto"
        alias egrep="egrep --colour=auto"
        alias fgrep="fgrep --colour=auto"

        # Root check
        if [[ ${EUID} == 0 ]] ; then
                PS1="\[\e[0;31m\]# \[\e[0m\]"
                PS2="\[\e[0;31m\]- \[\e[0m\]"
        else
                PS1="\[\e[0;32m\]> \[\e[0m\]"
                PS2="\[\e[0;32m\]- \[\e[0m\]"
        fi
else
	if [[ ${EUID} == 0 ]] ; then
		PS1="# "
	else
		PS1="> "
	fi
        PS2="- "
fi

unset use_color safe_term match_lhs sh

# I don't know what these do (Manjaro defaults)
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
xhost +local:root > /dev/null 2>&1
complete -cf sudo
shopt -s expand_aliases

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

prompt_comm() {
        tmux refresh-client -S # Redraw tmux status bar
        echo -ne "\033]0;${USER}@${HOSTNAME%%.*}\007" # Set window title, TODO: doesn't work in tmux session (if it was dynamic)
}

# Right before drawing prompt, this function is executed:
PROMPT_COMMAND=prompt_comm

# Aliases:
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias l="ls"
alias ll="ls -ohtr" # in order: long format with no group info - human readable size - sort by time - reverse sort order (newest last)
alias zat="zathura"
alias sauce="source ~/.bashrc"
# https://github.com/tuurep/quote-of-the-day.sh
alias quote="~/scripts/quote-of-the-day/quote-of-the-day.sh"
alias q="exit"
alias tn="tmux new -s"
alias ta="tmux attach -t"
alias tls="tmux ls"
alias tkill="tmux kill-session -t"
alias gits="git status"
alias gita="git add" 
alias gitc="git commit"
alias gitp="git push"
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias confs="config status"
alias confa="config add"
alias confc="config commit"
alias confp="config push"

# Changes fzf colors, see https://github.com/junegunn/fzf/wiki/Color-schemes
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#c5c8c6,bg:#1d1f21,hl:#474847
    --color=fg+:#c5c8c6,bg+:#1d1f21,hl+:#cc6666
    --color=info:#f0c674,prompt:#b294bb,pointer:#cc6666
    --color=marker:#b294bb,spinner:#f0c674,header:#474847
'

# https://github.com/junegunn/fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# For installing Nodejs
source /usr/share/nvm/init-nvm.sh
