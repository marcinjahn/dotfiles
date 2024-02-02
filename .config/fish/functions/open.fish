function open --wraps='xdg-open &>/dev/null' --description 'alias open=xdg-open &>/dev/null'
  xdg-open &>/dev/null $argv
        
end
