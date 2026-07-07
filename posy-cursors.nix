{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.posy-cursors ];

  environment.etc."cappaos-defaults/index.theme".source =
    ./default-configs/index.theme;

  systemd.user.services.cappaos-posy-cursors-init = {
    description = "Install CappaOS Posy Cursors configuration";

    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];

    serviceConfig = {
      Type = "oneshot";
    };

    script = ''
      echo "[CappaOS] Installing Posy Cursors configuration"

      install -d "$HOME/.icons/default/"

      if [ ! -f "$HOME/.icons/default/index.theme" ]; then
        touch "$HOME/.icons/default/cappaos-managed"
      fi

      if [ -f "$HOME/.icons/default/cappaos-managed" ]; then
        cp -f \
          /etc/cappaos-defaults/index.theme \
          "$HOME/.icons/default/index.theme"
      fi
    '';
  };
}
