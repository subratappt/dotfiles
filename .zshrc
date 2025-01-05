# if [ -f $HOME/.local/bin/zsh ] && [[ $(echo $ZSH_VERSION | awk -F. '{print $1"."$2}') < "5.1" ]]; then
if [ -f $HOME/.local/bin/zsh ] &&  [[ ! $ZSH_VERSION == (5.<1->*|<6->.*) ]] ; then
    exec $HOME/.local/bin/zsh
    echo $ZSH_VERSION
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
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

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
alias ls='ls --color=auto'

# Shell integration
# source <(fzf --zsh)

#############################################
export PATH=$HOME/.homebrew/bin:$PATH
export PATH=$HOME/apps/local/bin:$PATH
export PATH=$HOME/apps/texlive/bin/x86_64-linux:$PATH
export PATH=$HOME/.local/bin:$PATH
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH
export MANPATH=$HOME/.local/share/man:$MANPATH



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/subrata/apps/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
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

export INOTIFY_USER_WATCHES=524288

PATH="$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;

# function ls with lolcat
function lls() { 
    if [[ -t 1 ]] ; then COLUMNS="$COLUMNS" command ls -C "$@" | lolcat ; else command ls "$@" ; fi
}
# telegram send
alias tg="telegram-send"
function tgp() {
    telegram-send --image "$1" --caption "$2"
}
function tgf() {
    telegram-send --file "$1" --caption "$2"
}
function tgv() {
    telegram-send --video "$1" --caption "$2"
}


# For PETsc
export PETSC_DIR=/home/subrata/apps/petsc
export PETSC_ARCH=arch-linux-c-debug
export PYTHONPATH=/home/subrata/apps/petsc/${PETSC_ARCH}/lib:${PYTHONPATH}

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


