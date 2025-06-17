# The following parts is added to .zprofile
if [ -f $HOME/.local/bin/zsh ] &&  [[ ! $ZSH_VERSION == (5.<1->*|<6->.*) ]] ; then
    exec $HOME/.local/bin/zsh
    # echo "Switched to zsh version: $ZSH_VERSION"
fi

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# Source/Load zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d $ZINIT_HOME ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Add Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -U compinit && compinit


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# set LS_COLORS
# for mac
# export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

# Key bindings
bindkey '^f' autosuggest-accept
bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_find_no_dups


# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:"*"' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath' 

# Aliases
[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases

# Shell integration
# source <(fzf --zsh)

#############################################

export PATH=$HOME/apps/local/bin:$PATH
export PATH=$HOME/apps/bin:$PATH
export PATH=$HOME/apps/texlive/bin/x86_64-linux:$PATH
# export PATH=$HOME/apps/anaconda3/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH
export MANPATH=$HOME/.local/share/man:$MANPATH

export PATH=$HOME/.scripts:$PATH


export HOMEBREW_CURL_PATH="$HOME/apps/local/bin/curl"
export HOMEBREW_GIT_PATH="/usr/local/bin/git"
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_UPGRADE=1
export PATH=$HOME/.homebrew/bin:$PATH

export PKG_CONFIG_PATH=$HOME/.local/lib/pkgconfig:$PKG_CONFIG_PATH

export INOTIFY_USER_WATCHES=524288

# For PETsc
export PETSC_DIR=/home/subrata/apps/petsc
export PETSC_ARCH=arch-linux-c-debug
# export PYTHONPATH=/home/subrata/apps/petsc/${PETSC_ARCH}/lib:${PYTHONPATH}

# For SLEPc
export SLEPC_DIR=/home/subrata/apps/slepc

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/home/subrata/.juliaup/bin:*)
        ;;

    *)
        export PATH=/home/subrata/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/subrata/apps/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/subrata/apps/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/subrata/apps/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/subrata/apps/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

