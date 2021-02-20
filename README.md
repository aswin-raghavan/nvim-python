# nvim-python

Dockerized dev environment using neovim and language server protocol.


- [x] LSP based autocomplete using pygls and lua completion-nvim
- [x] Treesitter based semantic highlighting
- [x] Treesitter based refactor - smart rename
- [ ] Tabnine based completions (Removed)
- [x] Various convenience plugins
- [ ] Snippets
- [x] Various deep learning packages
- [x] Debugger support for python: run/debug python code within nvim
- [x] Breakpoints, step in, step over, virtual text updates values of variables


Build:
```
git clone <this repo>
cd <this repo>
docker build -t <img name> .
docker run -ti --rm <img name>
```

Launch neovim using `nvim`

(Optional) Install plugins: `:PlugInstall` inside `nvim`
