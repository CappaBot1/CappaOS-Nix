{ pkgs, ...}:

{
  imports = [
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
