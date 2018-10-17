#!/bin/bash

git submodule foreach git pull origin master
vim +PluginUpdate +qall
