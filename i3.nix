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

  environment.systemPackages = with pkgs; [
    kitty
  ];
}
