# shellcheck disable=SC2148
# HISTFILE is used by interactive shells only
export HISTFILE=$HOME/.cache/zsh_history
# https://apple.stackexchange.com/questions/427561/macos-zsh-sessions-zsh-history-and-setopt-append-history
export SHELL_SESSIONS_DISABLE=1

export NVM_COMPLETION=true
export NVM_LAZY_LOAD=true


# Disable glob expansion when there are no matches, so commands like below will just work
# pip install foo[bar]
# pytest -k foo[bar]
unsetopt nomatch

if [[ -v ZSH_PROF ]]; then
    zmodload zsh/zprof
fi

export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/.zcompdump-${HOST/.*/}-${ZSH_VERSION}"


export RPROMPT=""

# zstyle ':completion::complete:git-checkout:*' matcher 'm:{a-z-_}={A-Z_-}' 'r:|=*' 'l:|=* r:|=*'
# zstyle ':completion::complete:git-checkout:*' matcher 'm:{a-z-_}={A-Z_-}' 'l:|=* r:|=*'

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
# shellcheck disable=SC2034
ZSH_THEME="42picky"

# Report CPU usage for commands running longer than 10 seconds
# shellcheck disable=SC2034
REPORTTIME=5

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# shellcheck disable=SC2034
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"
# shellcheck disable=SC2034
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
# shellcheck disable=SC2034
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# hack to avoid gpg-agent module failure because it fails to find gpg-config
typeset -U path
# shellcheck disable=SC2034,SC1087,SC2206
path=(/usr/local/bin $path[@])
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# colorize broken on prompts
# gpg-agent
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# shellcheck disable=SC2034
plugins=(\
    autopep8 \
    git \
    git-extras \
    mvn \
    pip \
    pylint \
    python \
    virtualenv \
    zsh-nvm \
    zsh-syntax-highlighting \
    )
# command-time
# autoload -U compinit && compinit

# shellcheck source=/dev/null
source "$ZSH/oh-my-zsh.sh"

#setopt auto_cd
unsetopt correct_all

source_sh () {
    emulate -LR sh
    # shellcheck source=/dev/null
    . "$@"
}

# shellcheck source=/dev/null
source "$HOME/.profile"

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

# shellcheck source=/dev/null
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

#which rbenv >> /dev/null && eval "$(rbenv init -)"

unsetopt AUTO_CD

# https://github.com/pyenv/pyenv#installation
type pyenv >> /dev/null && {
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
}

# fi
# if [[ ! -d $PYENV_ROOT/plugins/pyenv-update ]]; then
#   git clone https://github.com/pyenv/pyenv-update.git $PYENV_ROOT/plugins/pyenv-update
# fi

#THIS MUST BE AT THE END OF THE FILE FOR JENV TO WORK!!!
#[[ -s "/Users/ssbarnea/.jenv/bin/jenv-init.sh" ]] && source "/Users/ssbarnea/.jenv/bin/jenv-init.sh" && source "/Users/ssbarnea/.jenv/commands/completion.sh"
#export PATH="$HOME/.jenv/bin:$PATH"
#eval "$(jenv init -)"

# this adds ~1s, not ok.
# eval "$(_MOLECULE_COMPLETE=source_zsh molecule)"

autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc

# w/o this line shell completions do not work
compinit -D
if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
    # shellcheck source=/dev/null
    .  "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi # added by Nix installer

# shellcheck disable=SC2034,SC2154
ZSH_HIGHLIGHT_STYLES[line]='bold'

echo "done .zshrc"

# Utility to benchmark login time
# https://blog.mattclemente.com/2020/06/26/oh-my-zsh-slow-to-load/
timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

timeplugins() {
    # Load all of the plugins that were defined in ~/.zshrc
    for plugin ($plugins); do
    timer=$(($(gdate +%s%N)/1000000))
    if [ -f $ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh ]; then
        source $ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh
    elif [ -f $ZSH/plugins/$plugin/$plugin.plugin.zsh ]; then
        source $ZSH/plugins/$plugin/$plugin.plugin.zsh
    fi
    now=$(($(gdate +%s%N)/1000000))
    elapsed=$(($now-$timer))
    echo $elapsed":" $plugin
    done
}
