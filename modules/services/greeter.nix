_: {
  flake.nixosModules.greeter =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      sddm-astronaut = pkgs.sddm-astronaut.override (_: {
        embeddedTheme = "japanese_aesthetic";
      });
    in
    {
      config = lib.mkMerge [
        (lib.mkIf (config.host.greeter == "greetd") {
          services.greetd = {
            enable = true;
            settings.default_session.command = "${pkgs.tuigreet}/bin/tuigreet --xsessions ${config.services.displayManager.sessionData.desktops}/share/xsessions --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --remember --remember-user-session --user-menu --user-menu-min-uid 1000 --asterisks --power-shutdown 'shutdown -P now' --power-reboot 'shutdown -r now'";
          };
        })

        (lib.mkIf (config.host.greeter == "noctalia-greet") {
          programs.noctalia-greeter.enable = true;
        })

        (lib.mkIf (config.host.greeter == "sddm") {
          services.displayManager.sddm = {
            enable = true;
            wayland.enable = true;
            theme = lib.mkForce "sddm-astronaut-theme";
            extraPackages = [ sddm-astronaut ];
            settings.Theme.Current = "sddm-astronaut-theme";
          };
          environment.systemPackages = [ sddm-astronaut ];
        })
      ];
    };
}
