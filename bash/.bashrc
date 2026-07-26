# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# shellcheck shell=bash

_DOT_FILES=~/git/dot-files
_BASH_CFG="${_DOT_FILES}/bash"
_BASH_RCD="${_BASH_CFG}/rc.d"

_source_if_exists() {
    if [ -f "$1" ]; then
        # shellcheck source=/dev/null
        source "$1"
    else
        printf "Attempted to source nonexistent file '%s'\n" "$1"
    fi
}
_source_if_exists "${_BASH_CFG}/bashrc-defaults.sh"
_source_if_exists "${_BASH_CFG}/core.sh"

for f in "${_BASH_RCD}"/*.sh; do
    _source_if_exists "$f"
done
