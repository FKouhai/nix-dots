_: {
  flake.nixosModules.prometheus =
    { config, ... }:
    {
      services.prometheus.exporters.node = {
        enable = true;
        openFirewall = true;
        enabledCollectors = [
          "systemd"
          "logind"
        ];
      };

      services.alloy = {
        enable = true;
      };

      environment.etc."alloy/config.alloy".text = ''
        loki.relabel "journal" {
          forward_to = []
          rule {
            source_labels = ["__journal__systemd_unit"]
            target_label  = "unit"
          }
        }

        loki.source.journal "read" {
          forward_to    = [loki.write.endpoint.receiver]
          relabel_rules = loki.relabel.journal.rules
          labels        = {job = "systemd-journal", host = "${config.networking.hostName}"}
          max_age       = "12h"
        }

        loki.write "endpoint" {
          endpoint {
            url = "https://loki.fkouhailabs.net/loki/api/v1/push"
            tls_config {
              insecure_skip_verify = true
            }
          }
        }
      '';
    };
}
