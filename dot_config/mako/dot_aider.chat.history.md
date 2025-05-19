
# aider chat started at 2025-05-19 20:00:24

> No git repo found, create one to track aider's changes (recommended)? (Y)es/(N)o [Yes]: n  
> /home/mnj/.local/bin/aider --no-auto-commits --pretty --stream --watch-files --tool-output-color=#8aadf4 --user-input-color=#a6da95 --completion-menu-current-bg-color=#f4dbd6 --completion-menu-current-color=#181926 --completion-menu-bg-color=#24273a --completion-menu-color=#cad3f5 --assistant-output-color=#c6a0f6 --tool-warning-color=#eed49f --tool-error-color=#ed8796  
> Aider v0.83.1  
> Main model: gemini/gemini-2.5-pro-preview-05-06 with diff-fenced edit format  
> Weak model: gemini/gemini-2.5-flash-preview-04-17  
> Git repo: none  
> Repo-map: disabled  
> Added config to the chat  
> Processing your request...  

Okay, I understand the request. You want to configure `mako` to never display the "n more" notification block, and then remove the AI comment.

To prevent the "n more" block, we should change the `max-visible` setting in the global configuration section to `0`. This will make mako display all notifications instead of summarizing them when they exceed a certain count.

Here are the changes:

1.  Modify `max-visible` in the global section.
2.  Remove the AI comment lines.

```
config
<<<<<<< SEARCH
default-timeout=30000
max-visible=1
anchor=top-center
=======
default-timeout=30000
max-visible=0
anchor=top-center
>>>>>>> REPLACE
```
```
config
<<<<<<< SEARCH
[hidden=true]
invisible=1
// AI! This is a config file for mako notifications tool.
Mako displays sometimes additional notification block when multiple notifications
come in, and I don't want it. Is there some way to never display this additional block?
It says "n more" to inform me than n more notifications are available.
=======
[hidden=true]
invisible=1
>>>>>>> REPLACE
```
After applying these changes, you might want to reload mako's configuration. You can usually do this by sending a SIGHUP signal to the mako process or using `makoctl reload`.

```bash
makoctl reload
```

> Tokens: 2.8k sent, 292 received. Cost: $0.0064 message, $0.0064 session.  
> Applied edit to config  
> makoctl reload  
