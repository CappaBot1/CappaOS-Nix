{ pkgs, ... }:

{
  programs.steam.enable = true; # not free

  environment.systemPackages = with pkgs; [

    # not free
    discord
  ];
}
