# HISTFILE is used by interactive shells only
HISTFILE=$HOME/.cache/zsh_history
# https://apple.stackexchange.com/questions/427561/macos-zsh-sessions-zsh-history-and-setopt-append-history
SHELL_SESSIONS_DISABLE=1

if [[ -v ZSH_PROF ]]; then
    zmodload zsh/zprof
fi

export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/.zcompdump-${HOST/.*/}-${ZSH_VERSION}"


export RPROMPT=""

# zstyle ':completion::complete:git-checkout:*' matcher 'm:{a-z-_}={A-Z_-}' 'r:|=*' 'l:|=* r:|=*'
# zstyle ':completion::complete:git-checkout:*' matcher 'm:{a-z-_}={A-Z_-}' 'l:|=* r:|=*'


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="pygmalion"
#ZSH_THEME="terminalparty"
#ZSH_THEME="trapd00r"
#ZSH_THEME="ys"
#ZSH_THEME="fino"
#ZSH_THEME="gnzh"
#ZSH_THEME="intheloop"
#ZSH_THEME="re5et"
#ZSH_THEME="steeef" # no code
#ZSH_THEME="suvash" # no code

# ZSH_THEME="tjkirch_mod"
ZSH_THEME="42picky"

# ZSH_THEME="powerlevel9k/powerlevel9k"
#ZSH_THEME="Spaceship"

# Report CPU usage for commands running longer than 10 seconds
REPORTTIME=5

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT=true

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# hack to avoid gpg-agent module failure because it fails to find gpg-config
typeset -U path
path=(/usr/local/bin $path[@])
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# colorize broken on prompts
# gpg-agent
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
plugins=(\
    autopep8 \
    git \
    pip \
    python \
    pylint \
    mvn \
    virtualenv \
    git-extras \
    zsh-syntax-highlighting \
    )
# command-time
# autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

#setopt auto_cd
unsetopt correct_all

source_sh () {
    emulate -LR sh
    . "$@"
}

source $HOME/.profile

# enable direnv
eval "$(direnv hook zsh)"

# https://coderwall.com/p/kmchbw/zsh-display-commands-runtime-in-prompt
# function preexec() {
#   timer=${timer:-$SECONDS}
# }
#
# function precmd() {
#   if [ $timer ]; then
#     timer_show=$(($SECONDS - $timer))
#     export RPROMPT="%F{cyan}${timer_show}s %{$reset_color%}"
#     unset timer
#   fi
# }

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

#which rbenv >> /dev/null && eval "$(rbenv init -)"

unsetopt AUTO_CD

# https://github.com/pyenv/pyenv#installation
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# fi
# if [[ ! -d $PYENV_ROOT/plugins/pyenv-update ]]; then
#   git clone https://github.com/pyenv/pyenv-update.git $PYENV_ROOT/plugins/pyenv-update
# fi

#THIS MUST BE AT THE END OF THE FILE FOR JENV TO WORK!!!
#[[ -s "/Users/ssbarnea/.jenv/bin/jenv-init.sh" ]] && source "/Users/ssbarnea/.jenv/bin/jenv-init.sh" && source "/Users/ssbarnea/.jenv/commands/completion.sh"
#export PATH="$HOME/.jenv/bin:$PATH"
#eval "$(jenv init -)"

# opam configuration
# test -r /Users/ssbarnea/.opam/opam-init/init.zsh && . /Users/ssbarnea/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# this adds ~1s, not ok.
# eval "$(_MOLECULE_COMPLETE=source_zsh molecule)"

autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc

# w/o this line shell completions do not work
compinit -D
if [ -e /Users/ssbarnea/.nix-profile/etc/profile.d/nix.sh ]; then
    . /Users/ssbarnea/.nix-profile/etc/profile.d/nix.sh
fi # added by Nix installer

ZSH_HIGHLIGHT_STYLES[line]='bold'

echo "done .zshrc"
