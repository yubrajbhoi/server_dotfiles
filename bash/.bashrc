#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#PS1='yubraj@\h:\w\$ '
PS1='┌─[yubraj@server:\w]
└─▪ '


# Aliases
alias ls='ls --color=never'
alias l='ls'
alias la='ls -a'
alias ll='ls -l'
alias dush='du -sh'
alias his='history'
alias webshare='python -m http.server 8080'
alias bb='busybox'
alias mydate='date "+%d.%m.%Y %I:%M:%S %p"'
alias datecommit='git commit -m "$(mydate)"'


# Set some env vars
export PATH=~/bin:$PATH
export PATH=~/.local/bin:$PATH
# Set neovim as default editor
export EDITOR=nvim
export TERM=xterm-256color
# Set up a directory for rlwrap files
export RLWRAP_HOME="$HOME/.local/share/rlwrap"
# Setup unlimited bash history
export HISTSIZE=-1
export HISTFILESIZE=-1
# Setup HISTCONTROL
export HISTCONTROL=ignoreboth:erasedups
# Set less as the default pager
export PAGER=less
# Add timestamps to bash commands history
export HISTTIMEFORMAT="%s "
# For Golang
export GOPATH="$HOME/others/gopath"
# Fix \w in prompt
export PROMPT_DIRTRIM=0
# Mypy cache dir
export MYPY_CACHE_DIR="$HOME/.cache/mypy"
# Set core limit for numpy
export OMP_NUM_THREADS=4
# Default PyOpenCL device
export PYOPENCL_CTX=0


# Functions
# mkcd function does mkdir and cd in one step
function mkcd() {
    mkdir -p "$@"
    cd "$@"
}

# APT clean up
function clean-apt() {
    apt clean
    apt-get clean
    apt-get autoclean
    apt-get autoremove
}

# Shortcuts for python virtualenv
function scidev() {
    source "$HOME/others/venvs/default/bin/activate"
    PS1='┌─(default) [yubraj@\server:\w]
└─▪ '
}

# Disable command not found suggestion
unset command_not_found_handle

# Set some bash options
shopt -s failglob
shopt -s extglob
shopt -s checkwinsize
