{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.flameshot ];

  environment.etc."cappaos-defaults/flameshot.ini".source =
    ./default-configs/flameshot.ini;

  systemd.user.services.cappaos-flameshot-init = {
    description = "Install CappaOS Flameshot configuration";

    wantedBy = [ "default.target" ];
    after = [ "graphical-session-pre.target" ];

    serviceConfig = {
      Type = "oneshot";
    };

    script = ''
      echo "[CappaOS] Installing Flameshot configuration"

      install -d "$HOME/.config/flameshot"

      if [ ! -f "$HOME/.config/flameshot/flameshot.ini" ]; then
        touch "$HOME/.config/flameshot/cappaos-managed"
      fi

      if [ -f "$HOME/.config/flameshot/cappaos-managed" ]; then
        ${pkgs.gnused}/bin/sed \
          "s|@HOME@|$HOME|g" \
          /etc/cappaos-defaults/flameshot.ini \
          > "$HOME/.config/flameshot/flameshot.ini"
      fi

      echo "[CappaOS] Creating screenshots directory"

      install -d "$HOME/Pictures/Screenshots"
    '';
  };

  environment.etc."xdg/autostart/flameshot.desktop".text = ''
    [Desktop Entry]
    Name=Flameshot
    Name[zh_CN]=火焰截图
    GenericName=Screenshot tool
    GenericName[zh_CN]=屏幕截图工具
    GenericName[pl]=Zrzuty ekranu
    GenericName[fr]=Outil de capture d'écran
    GenericName[nl]=Schermfotoprogramma
    GenericName[nl_NL]=Schermfotoprogramma
    GenericName[ja]=スクリーンショットツール
    GenericName[ru]=Создание скриншотов
    GenericName[sk]=Nástroj na zachytávanie obrazovky
    GenericName[sr]=Снимач екрана
    GenericName[uk]=Інструмент скриншотів
    GenericName[es]=Herramienta de captura de pantalla
    GenericName[pt_BR]=Ferramenta de captura de tela
    Comment=Powerful yet simple to use screenshot software.
    Comment[zh_CN]=强大又易用的屏幕截图软件
    Comment[pl]=Proste w użyciu narzędzie do zrzutów ekranu
    Comment[fr]=Logiciel de capture d'écran puissant et simple d'utilisation.
    Comment[nl]=Een eenvoudig doch krachtig schermfotoprogramma.
    Comment[nl_NL]=Een eenvoudig doch krachtig schermfotoprogramma.
    Comment[ja]=パワフルで使いやすいスクリーンショットソフトウェア。
    Comment[ru]=Простой и функциональный инструмент для создания скриншотов
    Comment[sk]=Mocný, no zároveň jednoduchý softvér na zachytávanie obrazovky.
    Comment[sr]=Једноставан, а моћан алат за снимање екрана
    Comment[uk]=Потужний простий у використанні додаток для створення знімків екрану.
    Comment[es]=Software de captura de pantalla potente y fácil de usar.
    Comment[de]=Schlichte, leistungsstarke Screenshot-Software
    Comment[pt_BR]=Software de captura de tela poderoso, mas simples de usar.
    Keywords=flameshot;screenshot;capture;shutter;
    Keywords[zh_CN]=flameshot;screenshot;capture;shutter;截图;屏幕;
    Keywords[fr]=flameshot;capture d'écran;capter;shutter;
    Keywords[ja]=flameshot;screenshot;capture;shutter;スクリーンショット;キャプチャー;
    Keywords[nl]=flameshot;schermfoto;screenshot;schermafdruk;vastleggen;schermopname;
    Keywords[nl_NL]=flameshot;schermfoto;screenshot;schermafdruk;vastleggen;schermopname;
    Keywords[es]=flameshot;screenshot;capture;shutter;captura;
    Keywords[de]=flameshot;screenshot;Bildschirmfoto;Aufnahme;
    Keywords[pt_BR]=flameshot;screenshot;captura de tela;captura;shutter;
    Icon=org.flameshot.Flameshot
    Terminal=false
    Type=Application
    Categories=Graphics;
    StartupNotify=false
    StartupWMClass=flameshot
    Actions=Configure;Capture;Launcher;
    X-DBUS-StartupType=Unique
    X-DBUS-ServiceName=org.flameshot.Flameshot
    X-KDE-DBUS-Restricted-Interfaces=org.kde.kwin.Screenshot,org.kde.KWin.ScreenShot2
    
    Exec=flameshot
    Hidden=false
    X-GNOME-Autostart-enabled=true
  '';
}

