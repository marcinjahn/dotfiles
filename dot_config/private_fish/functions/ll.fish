function ll --wraps=ls --wraps='exa -aglFh --git' --description 'alias ll=exa -aglFh --git'
  exa -aglh --git $argv
        
end
