[[ -f ~/.bashrc ]] && . ~/.bashrc

# Originally for vimgolf
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"

# cargo install destination
export PATH="$PATH:/home/tuure/.cargo/bin"
