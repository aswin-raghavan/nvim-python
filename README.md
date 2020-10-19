# nvim-python

Dockerized dev environment using neovim and language server protocol.

This project supercedes [vim-python](https://gitlab.sarnoff.com/aswin.raghavan/vim-python)

- [x] LSP based autocomplete using pygls and lua completion-nvim
- [x] Treesitter based semantic highlighting
- [x] Treesitter based refactor - smart rename
- [x] Tabnine based completions
- [x] Various convenience plugins
- [ ] Snippets
- [ ] reduce lag by autoimport

Build:
```
git clone <this repo>
cd <this repo>
docker build -t <img name> .
docker run -ti --rm <img name>
```

Launch neovim using `nvim`

(Optional) Install plugins: `:PlugInstall` inside `nvim`

