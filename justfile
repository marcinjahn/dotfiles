default:
  just --list

init:
  stow .

restow:
  stow --adopt -R .

adopt:
  stow --adopt -v .
