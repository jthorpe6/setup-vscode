#!/bin/bash

function install_vscode(){
    if type brew &>/dev/null
    then
        brew install --cask visual-studio-code
    else
        echo -e "brew not found, not installing vscode"
        exit
    fi
}

function install_extension(){
    code --install-extension "$@" --force
}

#- check for vscode
if [ ! -d "/Applications/Visual Studio Code.app" ]
then
    install_vscode
fi

#- with vscode installed, lets install the plugins
if [ -f "./plugins.sh" ]
then 
    source "./plugins.sh"
    for plugin in ${plugins[*]}
    do
        install_extension "$plugin"
    done
else
    echo -e "noting to install"
fi

# copy settings over
if [ -f "./settings.json" ]
then
    cp $(dirname "$0")/settings.json "$HOME/Library/Application Support/Code/User/settings.json"
else
    echo -e "no settings found"
fi