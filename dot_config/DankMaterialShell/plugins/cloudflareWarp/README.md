# Cloudflare WARP — DankMaterialShell plugin

Toggle Cloudflare WARP from the DankBar. The plugin starts `warp-svc` on connect
and stops it on disconnect, so the daemon does not run when you don't need it.
The official Cloudflare tray indicator is replaced by a single bar pill.

## What it does

- Bar pill icon reflects state:
  - `cloud_off` — disconnected (daemon stopped or idle)
  - `cloud_done` (primary color) — connected
  - `cloud_sync` — toggling
- Click pill → opens a popout with a Connect/Disconnect button and status text.
  Clicking the pill itself also toggles directly.
- Polls `systemctl is-active warp-svc.service`, then `warp-cli -j status` when
  the service is up.

## One-time system setup

These steps are required because the plugin needs to (a) not fight with the
official tray, and (b) start/stop `warp-svc` without a password prompt.

### 1. Disable the official Cloudflare tray autostart (user-level)

Already done by writing `~/.config/autostart/com.cloudflare.WarpTaskbar.desktop`
with `Hidden=true`. To re-enable later, delete that file.

If a `warp-taskbar` process is currently running:

```fish
pkill -x warp-taskbar
```

### 2. Disable the daemon from auto-starting (root)

```fish
sudo systemctl disable --now warp-svc.service
```

### 3. Allow your user to start/stop `warp-svc` without a password (root)

Create `/etc/polkit-1/rules.d/50-warp-svc-mnj.rules`:

```javascript
polkit.addRule(function (action, subject) {
  if (action.id == "org.freedesktop.systemd1.manage-units") {
    var unit = action.lookup("unit");
    if (
      (unit == "warp-svc.service" || unit == "warp-svc") &&
      subject.user == "mnj"
    ) {
      return polkit.Result.YES;
    }
  }
});
```

Replace `mnj` with your username if installing for a different user. No
service restart is needed; polkit picks up the rule immediately.

### 4. Enable the widget in DMS

Reload DMS (e.g. `pkill -USR1 quickshell`) and add **Cloudflare WARP** to your
bar layout in DMS Settings → DankBar.

## Settings

- **Refresh interval** — how often status is polled (seconds, default 5).
- **Hide pill when disconnected** — only show the icon while WARP is connected.
  Off by default; if you turn it on you'll lose the click target while
  disconnected and will need another way to connect (e.g. `warp-cli connect`
  from a terminal, which will also start the daemon via the polkit rule? — no:
  `warp-cli` talks to an already-running daemon. Run
  `systemctl start warp-svc && warp-cli connect`, or just leave this setting
  off.)

## Files

- `plugin.json` — manifest (type: widget, permissions: process + settings).
- `CloudflareWarpWidget.qml` — bar pill, popout, status polling, toggle logic.
- `CloudflareWarpSettings.qml` — settings panel shown in DMS.

## Toggle logic

Connect:

1. `systemctl start warp-svc.service`
2. Wait for the daemon to accept commands (up to ~1.5 s).
3. `warp-cli connect`

Disconnect:

1. `warp-cli disconnect`
2. `systemctl stop warp-svc.service`

After either sequence the plugin re-polls status and shows a toast.

## Troubleshooting

- **Pill is stuck on `cloud_sync`** — a queued command failed. Check
  `journalctl -u warp-svc` and `warp-cli status` from a terminal. The plugin
  will recover on the next poll.
- **"Authentication required" prompt when toggling** — the polkit rule isn't
  active. Check the username in `50-warp-svc-mnj.rules` and that the file is
  syntactically valid JS (no trailing commas).
- **Connect succeeds but pill stays `cloud_off`** — your org's MDM may have
  set `always_on: false` plus some restriction; run `warp-cli -j status` and
  inspect the `status` field. The pill flips to `cloud_done` only when
  `status === "Connected"`.
- **WARP keeps re-enabling itself on boot** — `always_on` was pushed by MDM.
  This setup avoids it by stopping the daemon entirely; if you ever see WARP
  active right after login, check that `warp-svc.service` is actually
  disabled (`systemctl is-enabled warp-svc`).

## Reverting everything

```fish
# Re-enable Cloudflare's tray
rm ~/.config/autostart/com.cloudflare.WarpTaskbar.desktop

# Re-enable the daemon at boot
sudo systemctl enable --now warp-svc.service

# Drop the polkit rule
sudo rm /etc/polkit-1/rules.d/50-warp-svc-mnj.rules

# Remove the plugin
rm -rf ~/.config/DankMaterialShell/plugins/cloudflareWarp
```
