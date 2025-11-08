{
  lib,
  config,
  ...
}:
{
  options = {
    companion.enable = lib.mkEnableOption "Enable code companion nixvim plugin module";
  };
  config = lib.mkIf config.cmp.enable {
    programs.nixvim = {
      plugins = {
        codecompanion = {
          enable = true;
          lazyLoad.enable = false;
          settings = {
            adapters = {
              ollama = {
                __raw = ''
                  function()
                    return require('codecompanion.adapters').extend('ollama', {
                        env = {
                            url = "http://127.0.0.1:11434",
                        },
                        schema = {
                            model = {
                                default = 'qwen2.5-coder:14b',
                            },
                            num_ctx = {
                                default = 32768,
                            },
                        },
                    })
                  end
                '';
              };

            };
            opts = {
              log_level = "DEBUG";
              send_code = true;
              use_default_actions = true;
              use_default_prompts = true;
            };
            strategies = {
              agent = {
                adapter = "ollama";
              };
              chat = {
                adapter = "ollama";
              };
              inline = {
                adapter = "ollama";
              };
            };
          };
        };
      };
    };
  };
}
