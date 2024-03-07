#!/bin/bash

export EDITOR=nvim
export VISUAL=nvim
export PAGER=nvimpager

# If the running shell is not an interactive shell, return without doing anything
[[ $- != *i* ]] && return

# Disable Ctrl+s and Ctrl+q freeze/unfreeze
# Enables Ctrl+s i-search in its place (Ctrl+r opposite direction)
stty -ixon

# If in tty2 console, don't use unrenderable symbols (unicode, nerdfont)
if [ "$TERM" = "linux" ]; then
        PS1="\[\e[0;32m\]$ \[\e[0m\]"
        PS2="\[\e[0;32m\]> \[\e[0m\]"
else
        PS1="\[\e[0;32m\] \[\e[0m\]"
        PS2="\[\e[0;32m\]󱞩 \[\e[0m\]"
fi

prompt_cmd() {
        history -a # Add previous command to ~/.bash_history
                   # (so that new session has access to this session's command history)

        if [[ "$TERM" =~ tmux* ]]; then
                tmux refresh-client -S # Redraw tmux status bar
        fi
        title=$(basename "$(dirs +0)")
        echo -ne "\033]0;${title}\007" # Set window title; in tmux title is set in .tmux.conf

        # If python-virtualenv activated, print venv name on a separate line before PS1
        if [[ -n "$VIRTUAL_ENV" ]]; then
                venv=$(basename "$VIRTUAL_ENV")
                echo -e "\e[0;32m(${venv})\e[0m"
        fi
}

# Right before drawing prompt, this function is executed:
PROMPT_COMMAND=prompt_cmd

# Aliases:

alias l="ls --color=always --group-directories-first"
alias e="nvim"
alias g="grep"
alias q="exit"

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
alias cb="NO_COLOR='please' cb"

alias drag="blobdrop -p"

alias tn="tmux new -s"
alias ta="tmux attach -t"
alias tl="tmux ls"
alias tk="tmux kill-session -t"

alias cfg='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias gr='cd $(git rev-parse --show-toplevel) && p' # Go to root of current git repo, if any. Else goes to ~.
alias todo='nvim ~/projects/todo.txt'

alias sudo="sudo -v; sudo "
alias sudoreset='faillock --reset --user $USER'
alias update-grub="grub-mkconfig -o /boot/grub/grub.cfg"
alias pac="pacman"
alias srcinfo="makepkg --printsrcinfo > .SRCINFO"
alias sauce="source ~/.bashrc"
alias hist="cleandups; history -r" # Read history, in case you want commands from another session
alias page="nvimpager"

alias py="python"
alias jl="julia"
alias sc="shellcheck"
alias vg="valgrind"

alias ff="firefox"
alias vivaldi-stable="vivaldi-stable --class=Vivaldi"
alias vivaldi="vivaldi-stable"
alias grip="grip -b"
alias tmr="transmission-remote"
alias fp="papis open"

alias reset-dunst="killall dunst; notify-send monkey monkey"
alias reset-polybar="killall -q polybar; polybar bar1 2>&1 & disown"

alias whereami='echo $HOSTNAME'
alias gnu="neofetch -L --ascii_distro GNU"

# for gtts-cli and translate-shell: get list of all language tags (works well with grep)
alias langtags="gtts-cli --all"

# show charging status and battery percentage
alias battery="upower -i /org/freedesktop/UPower/devices/battery_BAT0 \
                        | grep 'state:\|percentage:' \
                        | tr -d ' ' \
                        | cut -d ':' -f 2"

# Functions:

cleandups() {
        uniq ~/.bash_history | sponge ~/.bash_history
}

grayprint_path() {
        grayscale_243=$'\e[38;5;243m' # #767676
        reset=$'\e[0m'
        echo "${grayscale_243}$1${reset}"
}

p() {
        grayprint_path "$(dirs +0)"
}

pl() {
        grayprint_path "${OLDPWD/#$HOME/\~}"
}

c() {
        builtin cd "$@" > /dev/null \
                && p \
                && l
}

mc() {
        mkdir "$@" && c "$@"
}

eval "$(zoxide init bash)" # https://github.com/ajeetdsouza/zoxide
z() {
        __zoxide_z "$@" \
                && p \
                && l
}

# ls long listing
#       - sed removes first line (example: "total 4.0K")
ll() {
        l -oh --time-style=long-iso "$@" \
                | sed -r '/^total [0-9]+\.?[0-9]*[BKMGT]?$/d'
}

# tree with the box-drawing characters and end report turned into a dimmed fg color
tree() {
        grayscale_238=$'\e[38;5;238m' # #444444
        grayscale_243=$'\e[38;5;240m' # #585858
        reset=$'\e[0m'
        /usr/bin/tree -C "$@" \
                | sed -r -e "s/[├└│─]/${grayscale_238}&${reset}/g" \
                         -e "s/[0-9]+ directories, [0-9]+ files/${grayscale_243}&${reset}/g"
}

m() {
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

# === Bash command history ===

cleandups # Clean up in case multiple sessions have created unwanted history dups
export HISTCONTROL=ignoredups
export HISTSIZE=5000

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

export VIRTUAL_ENV_DISABLE_PROMPT=1 # Use custom venv-prompt in prompt_cmd
export PYTHONSTARTUP="$HOME/.pyrc" # Config (startup script) for py interactive shell

# Flags for less: case insensitive search and colors
export LESS='-iR'

# Colorize manpages
export LESS_TERMCAP_us=$'\e[31m'        # Underlined: red (and no underline)
export LESS_TERMCAP_so=$'\e[30;47m'     # Standout: bg on fg
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export GROFF_NO_SGR=1

# https://github.com/junegunn/fzf
# Enable fzf keybindings:
#       Ctrl-R  command history fzf overwrite
#       Ctrl-T  add fzf search result to command
#       Alt-C   cd to fzf search result (folder)
source /usr/share/fzf/key-bindings.bash

# https://github.com/junegunn/fzf#fuzzy-completion-for-bash-and-zsh
# fzf tab completion on **
source /usr/share/fzf/completion.bash

# Change fzf colors and icons, refer to: https://vitormv.github.io/fzf-themes/
# Todo: fzf would be a useful tool in tty2, but can't show these icons and some of the colors (e.g. green)
#       However, it's still usable, and this is a very niche use case...
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
        --color=fg:#767676,bg:#0f0f0f,hl:#d0d0d0
        --color=fg+:#d0d0d0,bg+:#0f0f0f,hl+:#c36060
        --color=prompt:#a7bd68,pointer:#c36060,marker:#c36060
        --color=info:#444444,spinner:#444444,border:#444444,header:#7d9fbd
        --prompt=" " --pointer="" --marker="" --separator=""
'
