{ config, pkgs, ... }:

{
  imports = [
    ./base.nix # base packages
    ./cinnamon.nix # default cinnamon desktop environment and styling
    #./development.nix # development programs
    #./gaming.nix # gaming programs
    #./creator.nix # creator programs
    #./virtualization.nix # virtualization programs
    ./inside-virtual-machine.nix # use this if you are inside a virtual machine
  ];

  nixpkgs.config.allowUnfree = true;
}

