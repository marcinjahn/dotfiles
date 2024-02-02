function ll --wraps=ls --wraps='exa -aglFh --git' --description 'alias ll=exa -aglFh --git'
  exa -aglFh --git $argv
        
end
