{
  description = "CappaOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
  let
    modules = [
      "base"
      "base-graphical"
      "chrome"
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
      "openvpn"
      "posy-cursors"
      "school"
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
    
    nixConfigurations = {
      iso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./iso.nix

          ./cinnamon.nix
          ./lightdm.nix

          ./base.nix
          ./base-graphical.nix
        ];
      };
    };
  };
}
