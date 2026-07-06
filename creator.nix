{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    obs-studio
    gimp
    audacity
  ];
}
