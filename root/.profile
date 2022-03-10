#!/bin/bash
# cspell:ignore apsc gcra pcau drmi
# Please note the .profile is supposed to loaded by all shells (bash, zsh,...) don't use fancy syntax
# This file should add private environment variables, do not add it to SCM
# https://github.com/robbyrussell/oh-my-zsh/issues/1282
# Prefer US English and use UTF-8.
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}

# Measures to avoid cluttering home directory
export CCACHE_DIR=$HOME/.cache/ccache
export GILT_CACHE_DIRECTORY=$HOME/.cache/gilt
export GOPATH=$HOME/.cache/go
export LESSHISTFILE=$HOME/.cache/.lesshst
export MYPY_CACHE_DIR=$HOME/.cache/mypy
export PYLINTHOME=$HOME/.cache/.pylint.d
export PYTHONPYCACHEPREFIX="$HOME/.cache/cpython/"

# === PYTHON ===
# export PYTHONSTARTUP=~/.local/bin/pythonstartup.py
export PYTHONBREAKPOINT=ipdb.set_trace
# export PYTHONDONTWRITEBYTECODE=1
export PY_COLORS=1
export PYTEST_ADDOPTS="--ff -p no:pytest_cov -p no:pytest_xdist"
# --verbosity=0"
#"--maxfail=10 -s --color=yes --no-cov --pdb --pdbcls=IPython.terminal.
export PYTHONIOENCODING='UTF-8'; # Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
# export PYTHONIOENCODING=utf-8 # see https://stackoverflow.com/a/4027726/99834
#export PY_COLORS=1

export OPEN_SOURCE_CONTRIBUTOR=true

export PRE_COMMIT_COLOR=always
export PRE_COMMIT_ALLOW_NO_CONFIG=1
# export LOG_CONFIG=

# export MOLECULE_PARALLEL=1
# export MOLECULE_DESTROY=never
# export MOLECULE_NO_LOG=0
# export MOLECULE_CONTAINERS_BACKEND=docker
# export ANSIBLE_STRATEGY=debug

# RMUX, RTOX:
# export HOSTS="cloud-user@n0"
export HOSTS="ssbarnea@leno"
# export HOSTS="ssbarnea@leno"
# export HOSTS="root@n0"
export RMUX_REMOTE_DIR="rmux"

# Configure default editor and diff tool
export EDITOR="edit"
export VISUAL="$EDITOR"
export DIFFTOOL=bcomp

# tmux:
export DISABLE_AUTO_TITLE="true"

export NETRC=~/.netrc

# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY=~/.node_history;
# Allow 32³ entries; the default is 1000.
export NODE_REPL_HISTORY_SIZE='32768';
# Use sloppy mode by default, matching web browsers.
export NODE_REPL_MODE='sloppy';

# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='32768';
export HISTFILESIZE="${HISTSIZE}";
# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth';

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow:-}";

# Don't clear the screen after quitting a manual page.
export MANPAGER='less -X'

# Configure xz to use all CPU cores
export XZ_DEFAULTS='-T 0'

#set -x

# fix for ctrl-o https://apple.stackexchange.com/questions/3253/ctrl-o-behavior-in-terminal-app
if [[ $- == *i* ]]; then
    stty discard undef
fi
# adding PATHs to the beginning of the PATH
# "${HOME}/dev/jira/jira-libs.hg/sdk/apache-maven/bin"
# KEEP ~/bin the last one so it will be the first one to look into, that's essential

MANPATH="/usr/local/opt/make/libexec/gnuman:$MANPATH"
export MANPATH

# adding PATHs to the beginning of the PATH
# "${HOME}/dev/jira/jira-libs.hg/sdk/apache-maven/bin"
# KEEP ~/bin the last one so it will be the first one to look into, that's essential
for MYPATH in \
    "$M2_HOME/bin" \
    "/usr/local/sbin" \
    /usr/local/opt/gettext/bin \
    /usr/local/opt/nss/bin \
    /usr/local/opt/python/libexec/bin \
    "${HOME}/.local/bin" \
    "${HOME}/bin"
do
    if [[ ! ":$PATH:" == *":$MYPATH:"* ]] && [ -d "$MYPATH" ]; then
        echo "adding ${MYPATH}"
        export PATH=${MYPATH}:$PATH
    fi
done
unset MYPATH

# rpmbuild:
# cspell:disable-next-line
export QA_RPATHS=$(( 0x0001|0x0010 ))

# https://github.com/direnv/direnv/issues/23
export DIRENV_ALLOW=$HOME

alias cat='bat -p --pager=never'
alias cloc="pygount --format=summary"

alias rmcache='find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf'
alias e='code -r -a'  # add to current projects
alias edit='code -r -a'  # add to current projects
alias tox='python -m tox'
alias gpg='gpg2'
alias ducks='du -cks * | sort -rn | head'
alias grep='grep -a --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias ww='fc -ln -1 >> ~/history.sh'
alias timeout='gtimeout'

alias rg='rg --hidden --no-follow --max-columns 255 --no-heading --column -F'
alias rgf='rg --files | rg'

alias gh-up="gh pr create --draft"
alias gr="git-review"

alias apsc="ansible-playbook --syntax-check"
alias al="ansible-lint"
alias ap="ansible-playbook"
alias asc="asciinema"
alias ls="/usr/local/bin/gls --color -h --group-directories-first"
alias lg='lazygit'

# https://github.com/cli/cli/issues/2300#issuecomment-991871579
alias gh-pr-reset="git config --local --get-regexp '\.gh-resolved$' | cut -f1 -d' ' | xargs -L1 git config --unset"

alias gca="git commit --amend -a"
alias gcra="git commit --amend --author='\$\(git config --global user.name\) <\$\(git config --global user.email\)>'"
alias grd="git-review -D"
alias grr="git stash save --include-untracked && git review && git stash pop"
alias gp="git push --force-with-lease"
alias git-who="git shortlog -s -n | head -n10"

unalias gr 2>/dev/null
alias gr="git review"

alias gt='fork -C $(git rev-parse --show-toplevel) #'
alias git-get-tags='git tag -l | xargs git tag -d && git fetch --tags'
#alias jjb="jenkins-jobs"
alias pep8="pycodestyle"
alias zbench="env ZSH_PROF= zsh -ic zprof"

alias pco="pytest -p no:pytest_cov --collect-only"
alias pcau="pre-commit autoupdate"
alias pc="pre-commit run -a"
# test pc="-f .pre-commit-config.yaml && pre-commit run -a || tox -e linters"

# http://klimer.eu/2015/05/01/use-midnight-commander-like-a-pro/
if [[ -f /usr/local/opt/midnight-commander/libexec/mc/mc-wrapper.sh ]]; then
    alias mc='/usr/local/opt/midnight-commander/libexec/mc/mc-wrapper.sh'
fi
alias npm-exec='PATH=$(npm bin):$PATH'

alias pyclean="find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete"

alias ncdu='ncdu --color=dark -xq'

if [[ -f /usr/local/bin/rsync ]]; then
    alias rsync='/usr/local/bin/rsync'
fi

# see http://ptspts.blogspot.co.uk/2010/01/how-to-make-midnight-commander-exit-to.html
if [ -f /usr/local/libexec/mc/mc-wrapper.sh ]; then
    alias mc=". /usr/local/libexec/mc/mc-wrapper.sh"
fi
alias waf='$PWD/waf'

# getting current script directory in a cross-platform compatible way by resolving symlinks
# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
if [ "$SHELL" = "/bin/bash" ]; then
    SOURCE="${BASH_SOURCE[0]}"
    while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
        DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
        SOURCE="$(readlink "$SOURCE")"
        [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    done

    if [ "$OS" = 'darwin' ]; then
        if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
            # shellcheck source=/dev/null
            . "$(brew --prefix)/etc/bash_completion"
        fi
    fi

else
    SOURCE=$0
fi

function drmi {
    docker images | grep "$1" |  xargs docker rmi
}

lowercase(){
    echo "$1" | sed "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/"
}

function readlink {
    greadlink "$@"
}
export readlink

# http://stackoverflow.com/questions/71069/can-maven-be-made-less-verbose
# cspell:disable-next-line
export MAVEN_OPTS="-Dorg.slf4j.simpleLogger.log.org.apache.maven.cl‌​i.transfer.Slf4jMave‌​nTransferListener=wa‌​rn"

#echo "INFO: os=$OS login took $(($SECONDS - $START_TIME))s"

function start_agent {
    echo "INFO: Initializing new SSH agent..."
    #/usr/bin/ssh-agent | sed 's/^echo/#echo/' > "$SSH_AGENT_CONFIG"
    /usr/bin/ssh-agent > "$SSH_AGENT_CONFIG"
    #echo succeeded
    if [ -e "$SSH_AUTH_SOCK" ]; then
        chmod 600 "${SSH_ENV}"
        # shellcheck source=/dev/null
        . "${SSH_ENV}"
    fi
    #/usr/bin/ssh-add;
    # -K is essential on mac in order to add the key to the keychain
    # find ~/.ssh -maxdepth 1 -name "*rsa*" \
    #   ! -name "*.pub" \
    #   ! -name '*.ppk' -print0 | \
    #   xargs -0 /usr/bin/ssh-add -K
}

if [[ ! -e "$SSH_AUTH_SOCK" || $(ssh-add -l | wc -l) -lt 1 ]]; then
    start_agent
fi

unset start_agent
# load default key in the agent
# "ssh-add -A" loads all keys already stored in KeyChain without password prompt
ssh-add -l >/dev/null || APPLE_SSH_ADD_BEHAVIOR=1 ssh-add -A

# if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
#     source /usr/local/bin/virtualenvwrapper.sh
# fi

# function style_term() {
# # this would colorize tab of the iTerm2 based on the hostname
# if [[ $- == *i* ]] # only in interactive mode
# then
#   #set | grep ITERM
#   #if [ -z "$ITERM_SESSION_ID" ]; then
#   if [ "$1" != 'localhost' ]; then

#     #echo ">>> $($1)"
#     MD5="md5sum"
#     if [[ $OS == 'darwin' ]]; then MD5="md5" ; fi
#     #HASH=`hostname -s | ${MD5}`
#     HASH=`echo $1 | ${MD5}`
#     # it is better to use the first localhost IP that is not 127.0.0.1 because this will be more
#     #HASH=`/sbin/ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | ${MD5}`
#     #HASH=$(echo "$1" | ${MD5})
#     echo -n -e "\033]6;1;bg;red;brightness;$((0x${HASH:0:2}))\a\033]6;1;bg;green;brightness;$((0x${HASH:2:2}))\a\033]6;1;bg;blue;brightness;$((0x${HASH:4:2}))\a"
#     echo -e "\033];$(hostname)``\007"
#     unset MD5
#     unset HASH
#   else
#     echo -e "\033]6;1;bg;red;brightness;128\a\033]6;1;bg;green;brightness;128\a\033]6;1;bg;blue;brightness;128\a\033];$(hostname)``\007"
#   fi
# fi
# }

# this will use screen to provide persistency when you call ssh with only the server name
function ssh2 {
    if [ "$#" == "1" ]; then
        #echo "ssh wrapper"
        if [ "${1:0:1}" != "-" ]; then
            #echo "..."
            style_term "$1"
            #echo "Using SSH wrapper..."
            eval last_arg=\$$#
            #screen -t "$last_arg" /usr/bin/ssh "$@";
            /usr/bin/ssh "$@";
            #echo "Ending SSH wrapper"
            style_term localhost
        else
            /usr/bin/ssh "$@";
        fi
    else
        /usr/bin/ssh "$@";
    fi
}

# export NVM_DIR="$HOME/.nvm"
# . "/usr/local/opt/nvm/nvm.sh" --no-use

# https://gist.githubusercontent.com/scarolan/f93a8f9b362c4d3a4436/raw/04aa224a9ab54d16f0f65448f6e38e697006aaaa/gistfile1.sh
function set_iterm_title {
    echo -ne "\e]1;$1\a"
}

function git_branch {
    (
    set -e
    BRANCH_REFS=$(git symbolic-ref HEAD 2>/dev/null) || return
    GIT_BRANCH="${BRANCH_REFS#refs/heads/}"
    [ -n "$GIT_BRANCH" ] && echo "$GIT_BRANCH "
    )
}

function precmd {
    set_iterm_title "${PWD//*\//} $(git_branch)"
    #PROMPT="%c %{$fg[cyan]%}$(git_branch)%{$reset_color%}%# "
}

# function git()
# {
#   if [[ $1 == "merge" ]] || [[ $1 == "rebase" ]] || [[ $1 == "pull" ]]; then
#     command hub "$@"
#     rc=$?
#     if [[ $rc == 1 ]]; then
#       echo "There are conflicts, better run git-mergetool!!!"
#       # There might be some other condition that returns a '1',
#       # if so you can add another check like this:
#       # if grep Conflicts $(git --git-dir)/MERGE_MSG;
#       command hub mergetool
#     fi
#   else
#     command hub "$@"
#   fi
# }

function sea {
    "$@" 2>&1 | seashells
}


# NEVER, EVER, USE export on CDPATH -- see https://bosker.wordpress.com/2012/02/12/bash-scripters-beware-of-the-cdpath/
export CDPATH=.:~/c:~/c/os:~/c/a:~

# shellcheck source=/dev/null
source ~/.config/secrets.sh
echo "done .profile"
