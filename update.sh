#!/bin/bash

git submodule foreach git pull origin master
vim "+call dein#update()"
