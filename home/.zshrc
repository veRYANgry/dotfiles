# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/

ZSH_THEME="robbyrussell"

plugins=(
  git
  vi-mode
)

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='code -w'
fi

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

# export MOZ_X11_EGL=1 # When firefox is ready this should enable correct video decode on hardware

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
 
# fuzzy matching for ctrl  +  r and others
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
# backspace stuff
bindkey '^H' backward-kill-word
# Set the terminal output standard
export LC_ALL="en_US.UTF-8"
# Set all qt apps to use kvantum theme
export QT_STYLE_OVERRIDE=kvantum
