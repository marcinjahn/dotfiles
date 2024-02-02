default:
  just --list

init:
  stow .

restow:
  stow -R .

remove-all:
  stow -D .

adopt:
  stow --adopt -v .
