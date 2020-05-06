autoload -U promptinit; promptinit

zstyle :prompt:pure:git:stash show yes
prompt pure
PROMPT='%(?.%F{magenta}❯.%F{red}❌)%f '
PROMPT="%(1j.%F{242}[%j]%f .)$PROMPT"

precmd_pipestatus() {
  RPROMPT="${(j.|.)pipestatus}"
  if [[ $RPROMPT = 0 ]]; then
    RPROMPT=""
  else
    RPROMPT="%(?.%F{242}[$RPROMPT].%F{red}[$RPROMPT])%f"
  fi
}
add-zsh-hook precmd precmd_pipestatus

autoload -U compinit
compinit

source ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
bindkey -e
bindkey "${key[Home]}"       beginning-of-line
bindkey "${key[End]}"        end-of-line
bindkey "${key[Delete]}"     delete-char
bindkey "${key[CtrlLeft]}"  emacs-backward-word
bindkey "${key[CtrlRight]}"  emacs-forward-word

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

