#!/bin/bash
set -euo pipefail

declare -A options=(
  [cursorline]=true    # local to window
  [copyindent]=true    # local to buffer
  [confirm]=true        # global
  [scrolloff]=1         # global or local to window
  [path]=".,,**"        # global or local to buffer
)
setters=(wo bo o opt_local go)
checks=(tabnew enew)
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

filter_setter="" filter_option="" filter_check=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --setter) filter_setter="$2"; shift 2 ;;
    --option) filter_option="$2"; shift 2 ;;
    --check)  filter_check="$2"; shift 2 ;;
    *) echo "Unknown arg: $1" >&2; exit 1 ;;
  esac
done

echo "scope,setter,option,value,check,global_before,global_after,effective_value,status,error"
for opt in "${!options[@]}"; do
  [[ -n "$filter_option" && "$opt" != "$filter_option" ]] && continue
  for setter in "${setters[@]}"; do
    [[ -n "$filter_setter" && "$setter" != "$filter_setter" ]] && continue
    for check in "${checks[@]}"; do
      [[ -n "$filter_check" && "$check" != "$filter_check" ]] && continue
      nvim --clean -l "${dir}/test-option.lua" "$setter" "$opt" "${options[$opt]}" "$check"
    done
  done
done
