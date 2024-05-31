function base64url --wraps=basenc\ --base64url\ \|\ tr\ -d\ \'\\n\' --description alias\ base64url=basenc\ --base64url\ \|\ tr\ -d\ \'\\n\'
  basenc --base64url | tr -d '\n' $argv
        
end
