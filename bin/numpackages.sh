#!/usr/bin/zsh
yaourt -Qu | wc | awk '{print $1}'
