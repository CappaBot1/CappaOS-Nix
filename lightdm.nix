{ pkgs, ...}:

{
  services.xserver = {
    enable = true;
    displayManager.lightdm = {
      enable = true;
      greeters.slick = {
        enable = true;
        cursorTheme.name = "Posy_Cursor_Black";
        extraConfig = "content-align=center";
      };
    };
  };
}

