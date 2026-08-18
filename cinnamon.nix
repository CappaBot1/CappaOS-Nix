{ pkgs, lib, ... }:

{
  imports = [
    ./copyq.nix # cool clipboard manager
    ./flameshot.nix # superb screenshot tool
    ./posy-cursors.nix
  ];

  environment.systemPackages = with pkgs; [
    hydrapaper # wonderful wallpaper manager (not needed for single monitor)

    # TODO: theme dmenu so it doesn't look like aah
    bemoji
    dmenu
  ];

  services.xserver = {
    enable = true;
    desktopManager.cinnamon.enable = true;
  };

  environment.etc."cappaos-defaults/spices/calendar.json".source = ./default-configs/spices/calendar.json;
  environment.etc."cappaos-defaults/spices/multicore-sys-monitor.json".source = ./default-configs/spices/multicore-sys-monitor.json;

  systemd.user.services.cappaos-cinnamon-theme-init = {
    description = "Install CappaOS Cinnamon configuration";

    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];

    serviceConfig = {
      Type = "oneshot";
    };

    script = ''
      set -euo pipefail

      echo "[CappaOS] Installing Cinnamon configuration"

      install -d \
        "$HOME/.config/cinnamon/spices/calendar@cinnamon.org" \
        "$HOME/.config/cinnamon/spices/multicore-sys-monitor@ccadeptic23"

      # Cinnamon applet configs
      cp -f \
        /etc/cappaos-defaults/spices/calendar.json \
        "$HOME/.config/cinnamon/spices/calendar@cinnamon.org/12.json"

      cp -f \
        /etc/cappaos-defaults/spices/multicore-sys-monitor.json \
        "$HOME/.config/cinnamon/spices/multicore-sys-monitor@ccadeptic23/multicore-sys-monitor@ccadeptic23.json"

      soundCfg="$HOME/.config/cinnamon/spices/sound@cinnamon.org/sound@cinnamon.org.json"

      if [ -f "$soundCfg" ]; then
        current="$(${pkgs.jq}/bin/jq -r '.keyOpen.value' "$soundCfg")"

        if [ "$current" = "<Shift><Super>s" ]; then
          echo "[CappaOS] Removing conflicting sound applet shortcut"

          tmp="$(mktemp)"

          ${pkgs.jq}/bin/jq \
            '.keyOpen.value = "::"' \
            "$soundCfg" > "$tmp"

          mv "$tmp" "$soundCfg"
        fi
      fi
    '';
  };

  # cinnamon theming for CappaOS
  programs.dconf.profiles.user.databases = [
    {
      settings = {
        "org/gnome/terminal/legacy" = {
          default-show-menubar = false;
        };

        "org/cinnamon" = {
          enabled-applets = [
            "panel1:left:0:menu@cinnamon.org:0"
            "panel1:left:1:grouped-window-list@cinnamon.org:1"
            "panel1:right:0:systray@cinnamon.org:2"
            "panel1:right:1:xapp-status@cinnamon.org:3"
            "panel1:right:2:notifications@cinnamon.org:4"
            "panel1:right:3:printers@cinnamon.org:5"
            "panel1:right:4:removable-drives@cinnamon.org:6"
            "panel1:right:5:keyboard@cinnamon.org:7"
            "panel1:right:6:favorites@cinnamon.org:8"
            "panel1:right:7:network@cinnamon.org:9"
            "panel1:right:8:sound@cinnamon.org:10"
            "panel1:right:9:power@cinnamon.org:11"
            "panel1:right:19:calendar@cinnamon.org:12"
          ];

          panel-zone-symbolic-icon-sizes = "[{\"panelId\": 1, \"left\": 28, \"center\": 28, \"right\": 16}]";

          #startup-animation = false;
        };

        "/org/x/apps/portal" = {
          color-scheme = "prefer-dark";
        };
        
        "org/cinnamon/desktop/interface" = {
          cursor-blink-time = lib.gvariant.mkInt32 1200;

          cursor-theme = "Posy_Cursor_Black";
          cursor-size = lib.gvariant.mkInt32 24;

          gtk-theme = "Mint-Y-Dark-Blue";
          icon-theme = "Mint-Y-Blue";
        };

        "org/cinnamon/theme" = {
          name = "Mint-Y-Dark-Blue";
        };

        "org/cinnamon/desktop/keybindings" = {
          custom-list = [
            "custom0"
            "custom1"
            "custom2"
            "custom3"
            "custom4"
            "__dummy__"
          ];
        };

        "org/cinnamon/desktop/keybindings/custom-keybindings/custom0" = {
          binding = [ "<Super>v" ];
          command = "copyq menu";
          name = "CopyQ menu";
        };

        "org/cinnamon/desktop/keybindings/custom-keybindings/custom1" = {
          binding = [ "<Shift><Super>e" ];
          command = "bemoji";
          name = "Emoji picker";
        };

        "org/cinnamon/desktop/keybindings/custom-keybindings/custom2" = {
          binding = [
            "Print"
            "<Primary><Super><Shift>s"
          ];
          command = "flameshot full";
          name = "Screenshot full";
        };

        "org/cinnamon/desktop/keybindings/custom-keybindings/custom3" = {
          binding = [
            "<Shift>Print"
            "<Shift><Super>s"
          ];
          command = "flameshot gui";
          name = "Screenshot area";
        };

        "org/cinnamon/desktop/keybindings/custom-keybindings/custom4" = {
          binding = [ "<Shift><Super>d" ];
          command = "gnome-terminal --title=\"Deno REPL\" -- /usr/bin/env deno repl";
          name = "Deno REPL";
        };

        "org/cinnamon/desktop/peripherals/keyboard" = {
          delay = lib.gvariant.mkInt32 500;
          repeat-interval = lib.gvariant.mkInt32 30;
        };

        "org/cinnamon/desktop/keybindings/media-keys" = {
          screenshot = [ "" ];
          area-screenshot = [ "" ];
          terminal = [
            "<Primary><Alt>t"
            "<Super>Return"
          ];
        };

        "org/cinnamon/desktop/wm/preferences" = {
          mouse-button-modifier = "<Super>";
        };

        "org/cinnamon/sounds" = {
          login-enabled = false;
          logout-enabled = false;
          switch-enabled = false;
          tile-enabled = false;
        };
      };
    }
  ];
}

