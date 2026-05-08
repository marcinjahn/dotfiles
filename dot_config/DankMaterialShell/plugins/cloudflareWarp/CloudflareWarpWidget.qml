import QtQuick
import qs.Common
import qs.Services
import qs.Widgets
import qs.Modules.Plugins
import Quickshell.Io

PluginComponent {
    id: root
    layerNamespacePlugin: "cloudflare-warp"

    property bool serviceActive: false
    property bool isConnected: false
    property bool busy: false
    property string statusText: "Unknown"
    property int refreshInterval: pluginData.refreshInterval || 5
    property bool hideWhenInactive: pluginData.hideWhenInactive === true

    Timer {
        interval: root.refreshInterval * 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: serviceCheck.running = true
    }

    Process {
        id: serviceCheck
        command: ["systemctl", "is-active", "warp-svc.service"]

        stdout: StdioCollector {
            onStreamFinished: {
                root.serviceActive = this.text.trim() === "active"
                if (root.serviceActive) {
                    statusCheck.running = true
                } else {
                    root.isConnected = false
                    root.statusText = "Service stopped"
                }
            }
        }
    }

    Process {
        id: statusCheck
        command: ["warp-cli", "-j", "status"]

        property string caller: ""

        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const data = JSON.parse(this.text)
                    root.statusText = data.status || "Unknown"
                    root.isConnected = data.status === "Connected"
                } catch (e) {
                    root.isConnected = false
                    root.statusText = "Parse error"
                }
            }
        }

        onExited: {
            if (caller === "toggle") {
                ToastService.showInfo("Cloudflare WARP: " + root.statusText)
            }
            caller = ""
        }
    }

    // Sequenced commands so we can chain start-service -> connect, or disconnect -> stop-service.
    Process {
        id: cmdRunner
        property var queue: []

        function enqueue(cmds) {
            queue = cmds
            runNext()
        }

        function runNext() {
            if (queue.length === 0) {
                root.busy = false
                statusCheck.caller = "toggle"
                serviceCheck.running = true
                return
            }
            const next = queue.shift()
            command = next
            running = true
        }

        onExited: (code, status) => {
            runNext()
        }
    }

    function toggleWarp() {
        if (root.busy) return
        root.busy = true
        if (root.isConnected) {
            cmdRunner.enqueue([
                ["warp-cli", "disconnect"],
                ["systemctl", "stop", "warp-svc.service"]
            ])
        } else {
            cmdRunner.enqueue([
                ["systemctl", "start", "warp-svc.service"],
                // give the daemon a brief moment to come up before connect
                ["sh", "-c", "for i in 1 2 3 4 5; do warp-cli status >/dev/null 2>&1 && break; sleep 0.3; done"],
                ["warp-cli", "connect"]
            ])
        }
    }

    horizontalBarPill: Component {
        MouseArea {
            implicitWidth: contentRow.implicitWidth
            implicitHeight: contentRow.implicitHeight
            cursorShape: Qt.PointingHandCursor
            visible: !root.hideWhenInactive || root.isConnected
            onClicked: root.toggleWarp()

            Row {
                id: contentRow
                spacing: Theme.spacingS

                DankIcon {
                    name: root.isConnected ? "cloud_done" : (root.busy ? "cloud_sync" : "cloud_off")
                    size: Theme.iconSize - 6
                    color: root.isConnected ? Theme.primary : Theme.surfaceText
                    opacity: root.busy ? 0.6 : 1.0
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }

    verticalBarPill: Component {
        MouseArea {
            implicitWidth: contentCol.implicitWidth
            implicitHeight: contentCol.implicitHeight
            cursorShape: Qt.PointingHandCursor
            visible: !root.hideWhenInactive || root.isConnected
            onClicked: root.toggleWarp()

            Column {
                id: contentCol
                spacing: Theme.spacingS

                DankIcon {
                    name: root.isConnected ? "cloud_done" : (root.busy ? "cloud_sync" : "cloud_off")
                    size: Theme.iconSize - 6
                    color: root.isConnected ? Theme.primary : Theme.surfaceText
                    opacity: root.busy ? 0.6 : 1.0
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }

    popoutContent: Component {
        PopoutComponent {
            id: popout
            headerText: "Cloudflare WARP"
            detailsText: root.statusText + (root.serviceActive ? "" : " · daemon stopped")
            showCloseButton: true

            Item {
                width: parent.width
                implicitHeight: toggleBtn.implicitHeight + Theme.spacingL

                Rectangle {
                    id: toggleBtn
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: Theme.spacingM
                    width: Math.min(parent.width - Theme.spacingL * 2, 240)
                    implicitHeight: 44
                    radius: Theme.cornerRadius
                    color: root.isConnected ? Theme.primary : Theme.surfaceContainerHigh
                    opacity: root.busy ? 0.6 : 1.0

                    Row {
                        anchors.centerIn: parent
                        spacing: Theme.spacingS

                        DankIcon {
                            name: root.isConnected ? "cloud_done" : "cloud_off"
                            size: Theme.iconSize - 4
                            color: root.isConnected ? Theme.onPrimary : Theme.surfaceText
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        StyledText {
                            text: root.busy ? "Working…" : (root.isConnected ? "Disconnect" : "Connect")
                            font.pixelSize: Theme.fontSizeMedium
                            color: root.isConnected ? Theme.onPrimary : Theme.surfaceText
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: root.busy ? Qt.ArrowCursor : Qt.PointingHandCursor
                        enabled: !root.busy
                        onClicked: root.toggleWarp()
                    }
                }
            }
        }
    }

    popoutWidth: 320
    popoutHeight: 180
}
