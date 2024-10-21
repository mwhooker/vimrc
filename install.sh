#!/usr/bin/env bash

if [ "`echo $0 | cut -c1`" = "/" ]; then
    VIM_PATH=`dirname $0`
else
    VIM_PATH=$(dirname `pwd`/`echo $0 | cut -c3-`)
fi

if [ -L ~/.vimrc ]; then
    unlink ~/.vimrc
fi

if [ -L ~/.vim ]; then
    unlink ~/.vim
fi

ln -s ${VIM_PATH}/vimrc ${HOME}/.vimrc
ln -s ${VIM_PATH} ${HOME}/.vim

git submodule update --init
pip3 install --user pynvim --break-system-packages
vim "+call dein#install()"
