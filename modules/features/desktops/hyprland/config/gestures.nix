{ lib }:
{
  gesture = [
    { fingers = 3; direction = "horizontal"; action = "workspace"; }
    { fingers = 3; direction = "down"; action = "close"; }
    {
      fingers = 3;
      direction = "up";
      action = lib.generators.mkLuaInline ''function() hl.exec_cmd("noctalia-shell ipc call launcher toggle") end'';
    }
  ];
}
