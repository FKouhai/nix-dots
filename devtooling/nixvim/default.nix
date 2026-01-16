{
  lib,
  config,
  inputs,
  ...
}:
{
  options = {
    nixvim.enable = lib.mkEnableOption "Enable nixvim module";
  };

  config = lib.mkIf config.nixvim.enable {
    programs.nixvim = {
      _module.args.inputs = inputs;
      enable = true;
      imports = [
        inputs.frostvim.nixvimModules.default
      ];

      plugins = {
        jdtls.enable = true;
        avante = {
          enable = true;
          settings = {
            provider = "opencode";
            acp_providrs = {
              opencode = {
                command = "opencode";
                args = [ "acp" ];
              };
            };
          };
        };

        minuet = {
          enable = false;
          settings = {
            lsp = {
              enabled_ft = [
                "go"
                "yaml"
                "elixir"
              ];
              enabled_auto_trigger_ft = [
                "go"
                "yaml"
                "elixir"
              ];
            };
            provider = "gemini";
            provider_options = {
              api_key = "GEMINI_API_KEY";
              end_point = "https://generativelanguage.googleapis.com/v1beta/models";
              model = "gemini-flash-latest";
              stream = true;
              optional = {
                max_tokens = 256;
                thinkingConfig = {
                  thinkingBudget = 0;
                };
                safetySettings = {
                  threshold = "BLOCK_ONLY_HIGH";
                  category = "HARM_CATEGORY_DANGEROUS_CONTENT";
                };
              };
            };
          };
        };
      };
    };
  };
}
