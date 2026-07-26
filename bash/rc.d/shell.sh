#!/bin/bash

# Basic convenience and shell configuration

alias nv=nvim
alias bat=batcat

gv() {
    git ls-files | fzf --query "$1" --bind "enter:become(nvim {})" --preview "batcat --color=always {}"
}

# fzf shell completion, etc.
eval "$(fzf --bash)"

