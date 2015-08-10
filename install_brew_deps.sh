#!/usr/bin/env bash

while read line; do
    brew install $line
done < brew_deps
