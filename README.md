# My dotfiles

## Usage

```sh
# Init on a new system
git clone git@github.com:marcinjahn/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
just init

# Add new dotfile(s)
touch .some-dot-file
just restow

# Remove all symlinks
just remove-all
```
