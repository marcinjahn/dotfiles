# dotfiles

This repository contains dotfiles of various apps I use.
The approach is borrowed from [Attlassian](https://www.atlassian.com/git/tutorials/dotfiles).

## Usage

```sh
echo ".dotfiles" >> .gitignore
git clone --bare https://github.com/marcinjahn/dotfiles $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout
```

