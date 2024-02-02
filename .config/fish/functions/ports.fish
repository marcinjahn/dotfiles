function ports --wraps='sudo lsof -i -P -n | grep LISTEN' --description 'alias ports=sudo lsof -i -P -n | grep LISTEN'
  sudo lsof -i -P -n | grep LISTEN $argv
        
end
