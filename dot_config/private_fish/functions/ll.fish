function ll --wraps=ls --wraps='exa -aglFh --git' --description 'alias ll=exa -aglFh --git'
    eza -aglh --git $argv

end
