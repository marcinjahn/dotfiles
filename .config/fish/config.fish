set -gx EDITOR vim
set -gx VISUAL vim
set -gx PAGER less

set -gx DOCKER_HOST unix:///run/user/1000/podman/podman.sock
# set -gx NVM_LAZY_LOAD true
# set -gx NVM_COMPLETION true
set -gx DOTNET_CLI_TELEMETRY_OPTOUT 1
set -gx FUNCTIONS_CORE_TOOLS_TELEMETRY_OPTOUT 1
set -gx DOTNET_ROOT $HOME/.dotnet

set -U fish_greeting
# set --universal nvm_default_version v18

fish_add_path ~/bin
fish_add_path ~/bin/distrobox
fish_add_path ~/sbin
fish_add_path ~/scripts
fish_add_path ~/opt/homebrew/bin
fish_add_path ~/opt/homebrew/sbin
fish_add_path ~/opt/local/bin
fish_add_path ~/opt/local/sbin
fish_add_path ~/.bun/bin
fish_add_path ~/.local/share/JetBrains/Toolbox/scripts
fish_add_path ~/.dotnet
fish_add_path ~/.dotnet/tools
fish_add_path ~/.cargo/bin

source ~/.asdf/asdf.fish


if status is-interactive

end

starship init fish | source