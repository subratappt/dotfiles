if [ -f $HOME/.local/bin/zsh ] &&  [[ ! $ZSH_VERSION == (5.<1->*|<6->.*) ]] ; then
    exec $HOME/.local/bin/zsh
fi

