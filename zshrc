fpath+=($HOME/.zsh/pure)

autoload -U promptinit; promptinit

function virtualenv_info {
	[ $VIRTUAL_ENV ] && echo "%F{242}(py-env:${VIRTUAL_ENV:t})"
}

zstyle :prompt:pure:git:stash show yes
prompt pure

# Function to format pipe statuses: red for errors, normal for 0
show_pipe_errors() {
  # Save pipestatus immediately before it's cleared by other commands
  local statuses=("${pipestatus[@]}")

  # Hide if everything succeeded (all zeros)
  if [[ ${(j..)${statuses:#0}} == "" ]]; then
    return
  fi

  local out=()
  for code in $statuses; do
    if [[ $code -ne 0 ]]; then
      out+="%F{red}$code%f"
    else
      out+="0"
    fi
  done

  # Output the formatted list inside brackets
  echo "[${(j.|.)out}]"
}

# Set the Right-Hand Prompt to show the errors
RPROMPT='$(show_pipe_errors)'

autoload -U compinit
compinit

source ~/.zkbd/$TERM
bindkey -e
bindkey "${key[Home]}"       beginning-of-line
bindkey "${key[End]}"        end-of-line
bindkey "${key[Delete]}"     delete-char
bindkey "${key[CtrlLeft]}"   emacs-backward-word
bindkey "${key[CtrlRight]}"  emacs-forward-word

source $HOME/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

export EDITOR=vim
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export PATH="$PATH:$HOME/devel/go/bin:$HOME/.local/bin:$PATH"

if [ $(hostnamectl hostname) = "i7v2" ]; then
  export GTK_IM_MODULE=fcitx
  export QT_IM_MODULE=fcitx
  export XMODIFIERS=@im=fcitx
fi

alias ls='ls --color=auto'

