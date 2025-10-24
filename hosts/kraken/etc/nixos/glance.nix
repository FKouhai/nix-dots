{
  config,
  lib,
  pkgs,
  inputs,
  extra-types,
  ...
}:
{
  services.glance = {
    enable = true;
    settings = {
      server = {
        host = "0.0.0.0";
        port = 8080;
      };
      # Kanagawa dark theme
      theme = {
        background-color = "240 13 14";
        primary-color = "51 33 68";
        contrast-multiplier = 1.2;
        negative-color = "358 100 68";
      };
      pages = [
        {
          columns = [
            {
              size = "small";
              widgets = [
                {
                  type = "calendar";
                }
                {
                  location = "Madrid, Spain";
                  type = "weather";
                }
              ];
            }
            {
              size = "full";
              widgets = [
                {
                  type = "rss";
                  limit = 40;
                  collapse-after = 15;
                  cache = "12h";
                  feeds = [
                    {
                      url = "https://news.ycombinator.com/rss";
                      name = "hackernews";
                    }
                    {
                      url = "https://feeds.arstechnica.com/arstechnica/index/";
                      name = "arstechnica";
                    }
                  ];
                }
              ];
            }
            {
              size = "full";
              widgets = [
                {
                  type = "group";
                  widgets = [
                    {
                      type = "reddit";
                      subreddit = "sre";
                    }
                    {
                      type = "reddit";
                      subreddit = "kubernetes";
                    }
                    {
                      type = "reddit";
                      subreddit = "golang";
                    }
                    {
                      type = "reddit";
                      subreddit = "unixporn";
                      show-thumbnails = true;
                    }
                  ];
                  collapse-after = 15;
                  cache = "12h";
                }
                {
                  type = "lobsters";
                  sort-by = "hot";
                  tags = [
                    "go"
                    "linux"
                    "devops"
                  ];
                  limit = 15;
                  collapse-after = 5;
                }
              ];
            }
          ];
          name = "Home";
        }
      ];
    };
    openFirewall = true;
  };
}
