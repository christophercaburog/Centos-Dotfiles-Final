#!/usr/bin/env bash

set -e

read os_name os_info <<< `sh ./os_info.sh`

# Install all the basic tools and apps
if [ "$os_name" = "Darwin" ] ; then
    brew update && brew upgrade
    brew bundle --global
    brew linkapps emacs kdiff3
    #brew bundle cleanup --global
    brew cleanup && brew cask cleanup
elif [ "$os_name" = "Linux" ] ; then
    read distro more_info <<<"$os_info"
    if [ "$distro" = "Debian" ] ; then
        sudo apt-get install grc wget -y
        if [ "`which eclipse`" == "" ]; then
            sudo add-apt-repository ppa:ubuntu-desktop/ubuntu-make -y
            sudo apt-get update
            sudo apt-get install ubuntu-make -y
            umake ide eclipse ${HOME}/.local/share/umake/ide/eclipse
        fi
        # TODO: update the list
    #elif [ "$distro" = "RedHat" ] ; then
        #    pkg_mgr='yum'
    else
        echo "Error: Un-expected Linux distribution"
        exit 1
    fi
else
    echo "Error: Un-expected OS"
    exit 1
fi

./install_eclipse_plugins.sh