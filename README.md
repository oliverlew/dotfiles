# dotfiles
config files

## Environment
- OS: [Archlinux][]
- DE: [Gnome3][]

for vim:
- gnome-terminal/termite

  (found termite works better with powerline glyphs)

- vim8

## Requirement

### fonts

For vim-airline:

- [Hack][]

  (Hack font has better patched powerline glyphs)


### Vundle

```sh
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

TODO: can I do this with github submodule?

[Archlinux]: www.archlinux.org
[Gnome3]: www.gnome.org

### ALE (optional)

ALE is a Asynchronous Lint Engine that can work on neovim or vim8.

linters:
- C
  - cppcheck
  - gcc
- Python
  - pylint
  - autopep8
