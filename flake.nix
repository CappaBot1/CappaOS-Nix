{
  description = "CappaOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
  let
    modules = [
      "base"
      "cappaos"
      "cinnamon"
      "copyq"
      "creator"
      "development"
      "flameshot"
      "gaming"
      "i3"
      "inside-virtual-machine"
      "lightdm"
      "ly"
      "posy-cursor"
      "virtualization"
    ];
  in {
    nixosModules = builtins.listToAttrs
      (
        map
          (name: {
            inherit name;
            value = import ./${name}.nix;
          })
          modules
      );
  };
}
