# nvim-python

Dockerized dev environment using neovim and language server protocol.

- [x] LSP provider [pyls](https://github.com/palantir/python-language-server)
- [x] Fast completion using [HansPinckaers' speed hacks](https://gist.github.com/HansPinckaers/f2a0382fa822aef83976b3e09eff1c46)
- [x] View documentation on hover or documentation as separate vim buffer
- [x] Documentation template generation by pydocstring (using [`doq`](https://github.com/heavenshell/py-doq)) - `numpy` format default
- [x] Debugger support for python: run/debug python code within nvim
    - [x] Toggle breakpoints
    - [x] step into, step over
    - [x] virtual text updates values of variables in comments
- [x] [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) based 
    - [x] semantic highlighting
    - [x] code folding
    - [x] smart rename
- [x] Linting: various providers incl. [pylint](https://www.pylint.org/), flake8, mccabe (code complexity), mypy (typing)
- [x] Various deep learning packages
- [x] [Rope](https://github.com/python-rope/rope/) based python code refactoring via Jedi: quick rename
- [x] Various convenience plugins 
    - [x] Fast motion using [easymotion](https://github.com/easymotion/vim-easymotion)
    - [x] Fuzzy list searching using [fzf](https://github.com/junegunn/fzf)
    - [x] tags support for searching 
    - [x] See tree of changes [undotree](https://github.com/mbbill/undotree)
    - [x] Directory browser using [nerdtree](https://github.com/preservim/nerdtree)
    - [x] Code outline using [Vista](https://github.com/liuchengxu/vista.vim)
- [x] Disabled by default: Multiple choices for completions (Jedi, ALE)
- [ ] Rope based python code refactoring: extract methods, variables, constants
- [ ] Tabnine based completions
- [ ] Multi-select
- [ ] Snippets

## Build:
```
git clone <this repo>
cd <this repo>
docker build -t <img name> .
docker run -ti --rm <img name>
```

## Launch 
Launch neovim using `nvim`

(Optional) Install plugins: `:PlugInstall` inside `nvim`

## TMUX
Does not seem to work well with TMUX currently --- TODO

## Keybindings
TODO

## Colorscheme
TODO

## Screenshots
By default, `<leader>` is `\` (e.g., `<leader>k` is `\k`)

Completion: 

![completion](screenshots/completion.png)

Signature help while filling in function args:

![signature](screenshots/signature.png)

Documentation on hover: Press `K`

![documentation_hover](screenshots/doc_hover.png)

Documentation in a buffer: Press `<leader>k`

![documentation_buf](screenshots/doc_buf.png)

Rename variable: `<leader>rn` when cursor on variable (`a_bp` in this example)

![rename1](screenshots/rename1.png)
![rename2](screenshots/rename2.png)
![rename3](screenshots/rename3.png)

Add docstring template: `<leader>-` for current line

![docstring](screenshots/docstring.png)

Code fixing: long line corrected by `yapf`

![longline](screenshots/longline.png)
![yapf](screenshots/yapf.png)

Ignore type error in import using `# type: ignore` annotation

![typeignore](screenshots/typeignore.png)

Linter catches poor naming convention:

![linter_catch_poor_name](screenshots/linter_catch_poor_name.png)

Code outline press `<leader>t`

![outline](screenshots/outline.png)

Directory browser `<leader>e`

![browser](screenshots/browser.png)

Toggle breakpoint: `<leader>db` for current line 
Start debug: `<leader>dc` and press `1`

![breakpoints](screenshots/breakpoints.png)

Debugger stops are breakpoints (and exceptions/errors usually): (Note comments show values of vars)

![debug1](screenshots/debug1.png)

`Continue` debugged with `<leader>dc` (Note comments show values of vars)

![debug2](screenshots/debug2.png)

Open REPL if you want to interact with debugger using `<leader>dro`

![repl_open](screenshots/repl_open.png)

Switch to the new REPL split per usual, enter insert mode to use it:

![repl_interact](screenshots/repl_interact.png)
![repl_interact2](screenshots/repl_interact2.png)

Hit continue again to finish the run `<leader>dc` - see terminal split (bottom most split) has the output

![dbg_finish](screenshots/dbg_finish.png)

Close REPL and terminal splits

![dbg_close](screenshots/dbg_close.png)

Debugger keymaps in `init.vim`:

![debugger_keymaps](screenshots/debugger_keymaps.png)

Jedi keymaps in `init.vim` (and defaults):

![jedi_keymaps](screenshots/jedi_keymaps.png)

Mappings for FZF: `<leader>o` to find by filename and `<leader>f` to find by tag:

![util_map1](screenshots/util_map1.png)
![fzf_open](screenshots/fzf_open.png)
![fzf_tags](screenshots/fzf_tags.png)

Easymotion trigger is `s` followed by one character

![easymotion1](screenshots/easymotion1.png)
![easymotion2](screenshots/easymotion2.png)

More util mappings: Search buffers: `<leader>bu`; undo tree `<leader>u`

![util2](screenshots/util2.png)
![bufs](screenshots/bufs.png)
![bufs](screenshots/undotree.png)




