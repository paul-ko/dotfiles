#!/bin/bash
# @help gv: open a fuzzy-found repo file in neovim
gv() {
    local root file
    root=$(git rev-parse --show-toplevel) || return
    file=$(git -C "$root" ls-files | fzf --query "$1" --preview "batcat --color=always \"$root\"/{}")
    if [ -n "$file" ]; then
        nvim "$root/$file"
    fi
}

# @help gcd: cd to a fuzzy-found repo file
gcd() {
    local root dir
    root=$(git rev-parse --show-toplevel) || return
    dir=$(git -C "$root" ls-files | xargs -n1 dirname | sort -u |
        fzf --query "$1" --preview "ls --color=always $root/{}")
    if [ -n "$dir" ]; then
        cd "$root/$dir" || return
    fi
}

# @help ghome: cd to the repo's base directory
ghome() {
    cd "$(git rev-parse --show-toplevel)" || return
}

# @help grg: ripgrep in the current repo
grg() {
    local root
    root=$(git rev-parse --show-toplevel) || return
    (cd "$root" && rg "$@")
}

# @help pca: run pre-commit against all files
alias pca="pre-commit run --all-files"
