{ lib }:
{
  gesture = [
    { fingers = 3; direction = "horizontal"; action = "workspace"; }
    { fingers = 3; direction = "down"; action = "close"; }
    {
      fingers = 3;
      direction = "up";
      action = lib.generators.mkLuaInline ''function() hl.exec_cmd("noctalia msg launcher toggle") end'';
    }
  ];
}
