fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit

function virtualenv_info {
	[ $VIRTUAL_ENV ] && echo "%F{242}(py-env:${VIRTUAL_ENV:t})"
}

zstyle :prompt:pure:git:stash show yes
prompt pure
PROMPT="%(?.%F{magenta}❯.%F{red}❌)%f "
PROMPT="%(1j.%F{242}[%j]%f .)$PROMPT"

precmd_pipestatus() {
  RPROMPT="${(j.|.)pipestatus}"
  if [[ $RPROMPT = 0 ]]; then
    RPROMPT=""
  else
    RPROMPT=" %(?.%F{242}[$RPROMPT].%F{red}[$RPROMPT])%f"
  fi

  RPROMPT="$(virtualenv_info)$RPROMPT"
}
add-zsh-hook precmd precmd_pipestatus

autoload -U compinit
compinit

source ~/.zkbd/$TERM
bindkey -e
bindkey "${key[Home]}"       beginning-of-line
bindkey "${key[End]}"        end-of-line
bindkey "${key[Delete]}"     delete-char
bindkey "${key[CtrlLeft]}"   emacs-backward-word
bindkey "${key[CtrlRight]}"  emacs-forward-word

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

export EDITOR=vim
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

alias ls='ls --color=auto'

