{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # you probably want these packages
    # terminal
    vim
    git
    tree
    deno
    btop
    ncdu
    ffmpeg
    fastfetch
    speedtest-cli

    # python bad
    #python3

    hollywood
    taskwarrior3
  ];
}

