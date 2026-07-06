# packages for virt-manager

{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/profiles/qemu-guest.nix")
    ];

  boot.initrd.availableKernelModules = [
    "ata_piix"
    "sr_mod"
  ];

  boot.kernelModules = [ "kvm-intel" ];

  services.spice-vdagentd.enable = true;

  fileSystems."/shared" = {
    device = "shared";
    fsType = "virtiofs";
    options = [
      "nofail"
    ];
  };
}

