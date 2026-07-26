#!/bin/bash
# @help gv: open a fuzzy-found repo file in neovim
gv() {
    git ls-files | fzf --query "$1" --bind "enter:become(nvim {})" --preview "batcat --color=always {}"
}

# @help gcd: cd to a fuzzy-found repo file
gcd() {
    local root dir
    root=$(git rev-parse --show-toplevel) || return
    dir=$(git -C "$root" ls-files | xargs -n1 dirname | sort -u \
        | fzf --query "$1" --preview "ls --color=always \"$root/{}\"")
    if [ -n "$dir" ]; then
        cd "$root/$dir" || return
    fi
}

# @help ghome: cd to the repo's base directory
ghome() {
    cd "$(git rev-parse --show-toplevel)" || return
}

