{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nixfmt
    inotify-tools

    vscodium # change this for vscode if you wish

    # not free
    # vscode
  ];
}
