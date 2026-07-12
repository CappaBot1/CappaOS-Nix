{ pkgs, ...}:

{
  imports = [
    ./copyq.nix # cool clipboard manager
    ./flameshot.nix # superb screenshot tool
    ./posy-cursors.nix
  ];

  services.xserver = {
    enable = true;
    windowManager.i3 = {
      enable = true;
    };
  };

  services.dunst = {
    enable = true; # dunst notifications
  };

  #xdg.portal = {
  #  enable = true; # enable this for flameshot
  #  #extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  #};

  environment.systemPackages = with pkgs; [
    dex # autostart things like copyq and flameshot
    xdg-desktop-portal # make flameshot work #probably doesn't work?
    kitty
  ];
}
