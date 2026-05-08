import QtQuick
import qs.Common
import qs.Modules.Plugins
import qs.Widgets

PluginSettings {
    id: root
    pluginId: "cloudflareWarp"

    StyledText {
        width: parent.width
        text: "Cloudflare WARP"
        font.pixelSize: Theme.fontSizeLarge
        font.weight: Font.Bold
        color: Theme.surfaceText
    }

    StyledText {
        width: parent.width
        text: "Click the bar pill to toggle WARP. The plugin starts warp-svc on connect and stops it on disconnect, so the daemon does not run unless you need it."
        font.pixelSize: Theme.fontSizeSmall
        color: Theme.surfaceVariantText
        wrapMode: Text.WordWrap
    }

    StyledText {
        width: parent.width
        text: "Requires: passwordless 'systemctl start/stop warp-svc.service' (polkit rule) and warp-cli already configured."
        font.pixelSize: Theme.fontSizeSmall
        color: Theme.warningText
        wrapMode: Text.WordWrap
    }

    SliderSetting {
        settingKey: "refreshInterval"
        label: "Refresh interval"
        description: "How often to poll WARP status (seconds)."
        defaultValue: 5
        minimum: 1
        maximum: 600
        unit: "sec"
        leftIcon: "schedule"
    }

    ToggleSetting {
        settingKey: "hideWhenInactive"
        label: "Hide pill when disconnected"
        description: "Only show the bar icon while WARP is connected."
        defaultValue: false
    }
}
