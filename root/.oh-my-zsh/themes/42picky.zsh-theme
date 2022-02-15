ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}⚡"
ZSH_THEME_GIT_PROMPT_CLEAN=""

function prompt_char {
	if [ $UID -eq 0 ]; then echo "%{$fg[red]%}#%{$reset_color%}"; else echo $; fi
}

# https://github.com/direnv/direnv/wiki/Python
show_virtual_env() {
  if [ -n "$VIRTUAL_ENV" ]; then
    echo " $fg_bold[magenta]$(basename $VIRTUAL_ENV)$reset_color"
  fi
}
# export -f show_virtual_env
# PS1='$(show_virtual_env)'$PS1
# export VIRTUAL_ENV_DISABLE_PROMPT=

PROMPT='%(?, ,%{$fg[red]%}FAIL: $?%{$reset_color%}
)
%{$fg[magenta]%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$reset_color%}: %{$fg_bold[blue]%}%~%{$reset_color%}$(show_virtual_env)$(git_prompt_info)
%_$(prompt_char) '

# $(show_virtual_env)
# RPROMPT='%{$fg[green]%}[%*]%{$reset_color%}'
