_: {
  flake.nixosModules.themeData =
    { config, ... }:
    let
      themes = {
        kanagawa-dragon = {
          base16Scheme = {
            scheme = "Kanagawa Dragon";
            author = "rebelot";
            base00 = "181616";
            base01 = "1f1c1c";
            base02 = "282727";
            base03 = "625e5a";
            base04 = "a6a69c";
            base05 = "c5c9c5";
            base06 = "c8c093";
            base07 = "dcd7ba";
            base08 = "c4746e";
            base09 = "b6927b";
            base0A = "c4b28a";
            base0B = "8a9a7b";
            base0C = "8ea4a2";
            base0D = "8ba4b0";
            base0E = "a292a3";
            base0F = "c4b28a";
          };
          kittyTheme = "kanagawa_dragon";
          tmuxTheme = "kanagawa/dragon";
          gtk = {
            name = "Kanagawa-B";
            iconName = "Kanagawa";
          };
          ghostty = {
            background = "#181616";
            foreground = "#C5C9C5";
            cursorColor = "#C5C9C5";
            selectionBackground = "#282727";
            selectionForeground = "#C5C9C5";
            palette = [
              "0=#0D0C0C"
              "1=#C4746E"
              "2=#8A9A7B"
              "3=#C4B28A"
              "4=#8BA4B0"
              "5=#A292A3"
              "6=#8EA4A2"
              "7=#C8C093"
              "8=#625E5A"
              "9=#E46876"
              "10=#87A987"
              "11=#E6C384"
              "12=#7FB4CA"
              "13=#938AA9"
              "14=#7AA89F"
              "15=#DCD7BA"
            ];
          };
        };

        kanagawa-wave = {
          base16Scheme = {
            scheme = "Kanagawa Wave";
            author = "rebelot";
            base00 = "1f1f28";
            base01 = "16161d";
            base02 = "2a2a37";
            base03 = "727169";
            base04 = "c8c093";
            base05 = "dcd7ba";
            base06 = "e9e5d0";
            base07 = "f2ecbc";
            base08 = "c34043";
            base09 = "ffa066";
            base0A = "c0a36e";
            base0B = "76946a";
            base0C = "6a9589";
            base0D = "7e9cd8";
            base0E = "957fb8";
            base0F = "d27e99";
          };
          kittyTheme = "kanagawa";
          tmuxTheme = "kanagawa/wave";
          gtk = {
            name = "Kanagawa";
            iconName = "Kanagawa";
          };
          ghostty = {
            background = "#1F1F28";
            foreground = "#DCD7BA";
            cursorColor = "#DCD7BA";
            selectionBackground = "#2A2A37";
            selectionForeground = "#DCD7BA";
            palette = [
              "0=#090618"
              "1=#C34043"
              "2=#76946A"
              "3=#C0A36E"
              "4=#7E9CD8"
              "5=#957FB8"
              "6=#6A9589"
              "7=#C8C093"
              "8=#727169"
              "9=#E82424"
              "10=#98BB6C"
              "11=#E6C384"
              "12=#7FB4CA"
              "13=#938AA9"
              "14=#7AA89F"
              "15=#DCD7BA"
            ];
          };
        };

        kanoxo-wave = {
          base16Scheme = {
            scheme = "Kanoxo Wave";
            author = "FKouhai";
            base00 = "1c1c24";
            base01 = "16161f";
            base02 = "252334";
            base03 = "5f5c78";
            base04 = "c8c4a0";
            base05 = "dcd7ba";
            base06 = "e9e5d0";
            base07 = "f0ece0";
            base08 = "d04870";
            base09 = "e89060";
            base0A = "c8aa72";
            base0B = "5cc070";
            base0C = "38ccc4";
            base0D = "80aaff";
            base0E = "b08cf0";
            base0F = "d880a8";
          };
          kittyTheme = "kanagawa";
          tmuxTheme = "kanagawa/wave";
          gtk = {
            name = "Kanagawa";
            iconName = "Kanagawa";
          };
          ghostty = {
            background = "#1c1c24";
            foreground = "#dcd7ba";
            cursorColor = "#dcd7ba";
            selectionBackground = "#252334";
            selectionForeground = "#dcd7ba";
            palette = [
              "0=#16161f"
              "1=#d04870"
              "2=#5cc070"
              "3=#c8aa72"
              "4=#80aaff"
              "5=#b08cf0"
              "6=#38ccc4"
              "7=#c8c4a0"
              "8=#5f5c78"
              "9=#e05888"
              "10=#72d888"
              "11=#dcc07e"
              "12=#7fb4ca"
              "13=#c49cf8"
              "14=#50d8d0"
              "15=#dcd7ba"
            ];
          };
        };

        kanoxo-dragon = {
          base16Scheme = {
            scheme = "Kanoxo Dragon";
            author = "FKouhai";
            base00 = "181616";
            base01 = "1e1c1c";
            base02 = "272525";
            base03 = "555055";
            base04 = "b8b4ac";
            base05 = "cac8c0";
            base06 = "d0ccb8";
            base07 = "dcd7ba";
            base08 = "cc6080";
            base09 = "c8886a";
            base0A = "c4b08a";
            base0B = "70b870";
            base0C = "48b8b0";
            base0D = "90b0cc";
            base0E = "b098e0";
            base0F = "c88098";
          };
          kittyTheme = "kanagawa_dragon";
          tmuxTheme = "kanagawa/dragon";
          gtk = {
            name = "Kanagawa-B";
            iconName = "Kanagawa";
          };
          ghostty = {
            background = "#181616";
            foreground = "#cac8c0";
            cursorColor = "#cac8c0";
            selectionBackground = "#272525";
            selectionForeground = "#cac8c0";
            palette = [
              "0=#0d0c0c"
              "1=#cc6080"
              "2=#70b870"
              "3=#c4b08a"
              "4=#90b0cc"
              "5=#b098e0"
              "6=#48b8b0"
              "7=#c8c4b8"
              "8=#555055"
              "9=#e07090"
              "10=#88cc88"
              "11=#d4c4a0"
              "12=#7fb4ca"
              "13=#c8a8f0"
              "14=#60c8c0"
              "15=#dcd7ba"
            ];
          };
        };

        kanagawa-aqua = {
          base16Scheme = {
            scheme = "Kanagawa Aqua";
            author = "custom";
            base00 = "12141c";
            base01 = "1a1c24";
            base02 = "252832";
            base03 = "4d5360";
            base04 = "818a90";
            base05 = "b9c6ce";
            base06 = "c8d5dc";
            base07 = "e0eaef";
            base08 = "bb6968";
            base09 = "c28878";
            base0A = "c4a87a";
            base0B = "546876";
            base0C = "7c97a4";
            base0D = "627985";
            base0E = "708995";
            base0F = "9ba8b0";
          };
          kittyTheme = "kanagawa_dragon";
          tmuxTheme = "kanagawa/dragon";
          gtk = {
            name = "Kanagawa-B";
            iconName = "Kanagawa";
          };
          ghostty = {
            background = "#12141c";
            foreground = "#b9c6ce";
            cursorColor = "#b9c6ce";
            selectionBackground = "#12141c";
            selectionForeground = "#b9c6ce";
            palette = [
              "0=#12141c"
              "1=#4D5360"
              "2=#546876"
              "3=#BB6968"
              "4=#627985"
              "5=#708995"
              "6=#7C97A4"
              "7=#b9c6ce"
              "8=#818a90"
              "9=#4D5360"
              "10=#546876"
              "11=#BB6968"
              "12=#627985"
              "13=#708995"
              "14=#7C97A4"
              "15=#b9c6ce"
            ];
          };
        };
      };
    in
    {
      config.host.themeData = themes.${config.host.theme};
    };
}
