{ pkgs, ... }:

{
  programs.virt-manager.enable = true;

  virtualisation.libvirtd.enable = true;

  users.groups.libvirt = {};

  environment.systemPackages = with pkgs; [
    virt-viewer
    spice-gtk
    virtiofsd
  ];
}
