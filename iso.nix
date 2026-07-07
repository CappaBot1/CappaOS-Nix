{ pkgs, modulesPath, lib, ... }:

{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-calamares.nix"
  ];

  # copy over cappaos files
  #environment.etc."nixos/cappaos".source = ../cappaos;

  # make iso build faster
  isoImage.squashfsCompression = "gzip -Xcompression-level 1";

  # use the latest Linux kernel
  #boot.kernelPackages = pkgs.linuxPackages_latest;

  systemd.services.cappaos-init = {
    wantedBy = [ "multi-user.target" ];
    after = [ "local-fs.target" ];

    serviceConfig.Type = "oneshot";

    script = ''
      /nix/var/nix/profiles/system/activate
    '';
  };
}

