function base64urld --wraps=basenc\ --base64url\ -d\ \|\ tr\ -d\ \'\\n\' --description alias\ base64urld=basenc\ --base64url\ -d\ \|\ tr\ -d\ \'\\n\'
  basenc --base64url -d | tr -d '\n' $argv
        
end
