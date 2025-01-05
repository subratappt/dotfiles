#!/bin/sh
# Source global definitions
# if [ -f /etc/bashrc ]; then
#     . /etc/bashrc
# fi

##########################################################
PROMPT_DIRTRIM=3
# Path to your oh-my-bash installation.
export OSH=${HOME}/.oh-my-bash
OSH_THEME="moon"
ENABLE_CORRECTION="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
DISABLE_AUTO_UPDATE=true
OMB_PROMPT_SHOW_PYTHON_VENV=true
OMB_USE_SUDO=false
completions=(git)
aliases=(general ls)
plugins=(git bash-preexec)
source "$OSH"/oh-my-bash.sh
##########################################################

export LS_COLORS=$LS_COLORS:'tw=00;33:ow=01;33:'

# export HOMEBREW_CURL_PATH=/home/subrata/.homebrew/bin/curl
export PATH=/home/subrata/.homebrew/bin:$PATH
export PATH=/home/subrata/apps/local/bin:$PATH
# export PATH=/home/subrata/apps/anaconda3/bin:$PATH
export PATH=/home/subrata/apps/nvim/bin:$PATH
export PATH=/home/subrata/.local/bin:$PATH
export PATH=/home/subrata/apps/texlive/bin/x86_64-linux:$PATH

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

PATH="/home/subrata/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/subrata/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/subrata/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/subrata/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/subrata/perl5"; export PERL_MM_OPT;

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

# <<< juliaup initialize <<<
