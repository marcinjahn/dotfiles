set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx PAGER less
set -gx LESS -eiRMX

# set -gx DOCKER_HOST unix:///run/user/1000/podman/podman.sock
# set -gx NVM_LAZY_LOAD true
# set -gx NVM_COMPLETION true
set -gx DOTNET_CLI_TELEMETRY_OPTOUT 1
set -gx DOTNET_UPGRADEASSISTANT_TELEMETRY_OPTOUT 1
set -gx FUNCTIONS_CORE_TOOLS_TELEMETRY_OPTOUT 1
set -gx DOTNET_ROOT $HOME/.dotnet
set -gx ASDF_GOLANG_MOD_VERSION_ENABLED true
set -gx ASDF_NODEJS_LEGACY_FILE_DYNAMIC_STRATEGY latest_installed
set -gx OPENCODE_DISABLE_CLAUDE_CODE_SKILLS true
set -gx OPENCODE_EXPERIMENTAL_LSP_TOOL true
# set -gx MONO_GAC_PREFIX /home/linuxbrew/.linuxbrew

set -U fish_greeting
# set --universal nvm_default_version v18

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Always ensure shims are first, removing any existing entry first
set -gx PATH (string match -v -- $_asdf_shims $PATH)
set -gx --prepend PATH $_asdf_shims
set --erase _asdf_shims
# END OF ASDF

fish_add_path ~/bin
# fish_add_path ~/bin/distrobox
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
fish_add_path ~/bin/netcoredbg
fish_add_path ~/bin/vicinae/bin
fish_add_path ~/.npm-global/bin

if status is-interactive
    alias v="nvim"
    alias ghostty="/home/mnj/AppImages/ghostty.appimage"
    abbr --add wifilist nmcli device wifi list
    abbr --add wificonnect nmcli device wifi connect
end

# starship init fish | source
COMPLETE=fish jj | source
