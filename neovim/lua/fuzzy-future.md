What I want is a matrix of fuzzy finders / greppers:

- File type: code, docs, cofigs, data, all
- Search type: line content, filename

Neither of these are necessarily complete.

My current approach is a leader-based taxonomy, leaning on which-key to aid discovery.

But this will get slow and confusing.

We have:

,s: search
,f: files

Let's say I want live-grep code files: ,sgc
Docs: ,sgd
Configs: ,sgf (I guess - c is code)

I think a better approach could be mixing muscle memory and a "GUI" picker.

,,s: search all
,s: search then picker shows, listing file types

Depending on what UI components are available, it could even theoretically evolve
further.  Maybe the picker pre-popluates filetype options based on what it finds in the
filesystem.  Maybe there are multiple options.

But I think first I want to switch to snacks:

- it supports frecency
- it supports " field searches like `file:lua$ 'function`"
- it supports modified buffer search




```
- <leader>s — search / pickers
  - sf — group: find files
  - sfa / sfc / sfd: all / code / docs
- sg — group: grep (content search)
  - sga / sgc / sgd: type-a-query, all / code / docs
  - sgw / sgW: word / WORD under cursor, all (same c/d suffixes if wanted)
- sh — group: git history pickers
  - sha: full log
  - shb: buffer-scoped log
- sb — search buffers (leaf, no children)
  - sF (uppercase, separate from sf since case makes it a distinct sequence, not a continuation): assisted category-picker fallback for when you don't remember the a/c/d letter
- <leader>f — filesystem / tree (nvim-tree) — not yet implemented, letters TBD
- <leader>g — git, direct actions only (no lists) — not yet implemented, letters TBD
- <leader>d — diagnostics
  - dl: line diagnostics, float (unchanged)
  - da: all diagnostics, quickfix (unchanged)
- <leader>b — buffer management, direct actions only (no lists)
  - bb: back to previous buffer, b# (unchanged)
- <leader><leader> — muscle-memory fast paths, unaffected by the above since they have no children
  - <leader><leader>f: find files (alias of sfa)
  - <leader><leader>g: live grep, code only (alias of scc)
  ```
