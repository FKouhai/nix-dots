{
  config,
  lib,
  pkgs,
  inputs,
  extra-types,
  ...
}:
{
  services.udev = {
    enable = true;
    extraRules = ''
            # Valve USB devices
      SUBSYSTEM=="usb", ATTRS{idVendor}=="28de", MODE="0660", TAG+="uaccess"

      # Steam Controller udev write access
      KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess", OPTIONS+="static_node=uinput"

      # Valve HID devices over USB hidraw
      KERNEL=="hidraw*", ATTRS{idVendor}=="28de", MODE="0660", TAG+="uaccess"

      # Valve HID devices over bluetooth hidraw
      KERNEL=="hidraw*", KERNELS=="*28DE:*", MODE="0660", TAG+="uaccess"

      # DualShock 3 over USB hidraw
      KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0268", MODE="0660", TAG+="uaccess"

      # DualShock 3 over bluetooth hidraw
      KERNEL=="hidraw*", KERNELS=="*054C:0268*", MODE="0660", TAG+="uaccess"

      # DualShock 4 over USB hidraw
      KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="05c4", MODE="0660", TAG+="uaccess"

      # DualShock 4 wireless adapter over USB hidraw
      KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0ba0", MODE="0660", TAG+="uaccess"

      # DualShock 4 Slim over USB hidraw
      KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="09cc", MODE="0660", TAG+="uaccess"

      # DualShock 4 over bluetooth hidraw
      KERNEL=="hidraw*", KERNELS=="*054C:05C4*", MODE="0660", TAG+="uaccess"

      # DualShock 4 Slim over bluetooth hidraw
      KERNEL=="hidraw*", KERNELS=="*054C:09CC*", MODE="0660", TAG+="uaccess"

      # PS5 DualSense controller over USB hidraw
      KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0ce6", MODE="0660", TAG+="uaccess"

      # PS5 DualSense controller over bluetooth hidraw
      KERNEL=="hidraw*", KERNELS=="*054C:0CE6*", MODE="0660", TAG+="uaccess"

      # Nintendo Switch Pro Controller over USB hidraw
      KERNEL=="hidraw*", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="2009", MODE="0660", TAG+="uaccess"

      # Nintendo Switch Pro Controller over bluetooth hidraw
      KERNEL=="hidraw*", KERNELS=="*057E:2009*", MODE="0660", TAG+="uaccess"

      # Faceoff Wired Pro Controller for Nintendo Switch
      KERNEL=="hidraw*", ATTRS{idVendor}=="0e6f", ATTRS{idProduct}=="0180", MODE="0660", TAG+="uaccess"

      # PDP Wired Fight Pad Pro for Nintendo Switch
      KERNEL=="hidraw*", ATTRS{idVendor}=="0e6f", ATTRS{idProduct}=="0185", MODE="0660", TAG+="uaccess"

      # PowerA Wired Controller for Nintendo Switch
      KERNEL=="hidraw*", ATTRS{idVendor}=="20d6", ATTRS{idProduct}=="a711", MODE="0660", TAG+="uaccess"
      KERNEL=="hidraw*", ATTRS{idVendor}=="20d6", ATTRS{idProduct}=="a713", MODE="0660", TAG+="uaccess"

      # PowerA Wireless Controller for Nintendo Switch we have to use
      # ATTRS{name} since VID/PID are reported as zeros. We use /bin/sh
      # instead of udevadm directly becuase we need to use '*' glob at the
      # end of "hidraw" name since we don't know the index it'd have.
      #
      KERNEL=="input*", ATTRS{name}=="Lic Pro Controller", RUN{program}+="/bin/sh -c 'udevadm test-builtin uaccess /sys/%p/../../hidraw/hidraw*'"

      # Afterglow Deluxe+ Wired Controller for Nintendo Switch
      KERNEL=="hidraw*", ATTRS{idVendor}=="0e6f", ATTRS{idProduct}=="0188", MODE="0660", TAG+="uaccess"

      # Nacon PS4 Revolution Pro Controller
      KERNEL=="hidraw*", ATTRS{idVendor}=="146b", ATTRS{idProduct}=="0d01", MODE="0660", TAG+="uaccess"

      # Razer Raiju PS4 Controller
      KERNEL=="hidraw*", ATTRS{idVendor}=="1532", ATTRS{idProduct}=="1000", MODE="0660", TAG+="uaccess"

      # Razer Raiju 2 Tournament Edition
      KERNEL=="hidraw*", ATTRS{idVendor}=="1532", ATTRS{idProduct}=="1007", MODE="0660", TAG+="uaccess"

      # Razer Panthera EVO Arcade Stick
      KERNEL=="hidraw*", ATTRS{idVendor}=="1532", ATTRS{idProduct}=="1008", MODE="0660", TAG+="uaccess"

      # Razer Raiju PS4 Controller Tournament Edition over bluetooth hidraw
      KERNEL=="hidraw*", KERNELS=="*1532:100A*", MODE="0660", TAG+="uaccess"

      # Razer Raiju Ultimate over USB
      KERNEL=="hidraw*", ATTRS{idVendor}=="1532", ATTRS{idProduct}=="1004", MODE="0660", TAG+="uaccess"

      # Razer Raiju Ultimate over PC Bluetooth
      KERNEL=="hidraw*", KERNELS=="*1532:1009*", MODE="0660", TAG+="uaccess"

      # Razer Panthera Arcade Stick
      KERNEL=="hidraw*", ATTRS{idVendor}=="1532", ATTRS{idProduct}=="0401", MODE="0660", TAG+="uaccess"

      # Mad Catz - Street Fighter V Arcade FightPad PRO
      KERNEL=="hidraw*", ATTRS{idVendor}=="0738", ATTRS{idProduct}=="8250", MODE="0660", TAG+="uaccess"

      # Mad Catz - Street Fighter V Arcade FightStick TE S+
      KERNEL=="hidraw*", ATTRS{idVendor}=="0738", ATTRS{idProduct}=="8384", MODE="0660", TAG+="uaccess"

      # Brooks Universal Fighting Board
      KERNEL=="hidraw*", ATTRS{idVendor}=="0c12", ATTRS{idProduct}=="0c30", MODE="0660", TAG+="uaccess"

      # EMiO Elite Controller for PS4
      KERNEL=="hidraw*", ATTRS{idVendor}=="0c12", ATTRS{idProduct}=="1cf6", MODE="0660", TAG+="uaccess"

      # ZeroPlus P4 (hitbox)
      KERNEL=="hidraw*", ATTRS{idVendor}=="0c12", ATTRS{idProduct}=="0ef6", MODE="0660", TAG+="uaccess"

      # HORI RAP4
      KERNEL=="hidraw*", ATTRS{idVendor}=="0f0d", ATTRS{idProduct}=="008a", MODE="0660", TAG+="uaccess"

      # HORIPAD 4 FPS
      KERNEL=="hidraw*", ATTRS{idVendor}=="0f0d", ATTRS{idProduct}=="0055", MODE="0660", TAG+="uaccess"

      # HORIPAD 4 FPS Plus
      KERNEL=="hidraw*", ATTRS{idVendor}=="0f0d", ATTRS{idProduct}=="0066", MODE="0660", TAG+="uaccess"

      # HORIPAD for Nintendo Switch
      KERNEL=="hidraw*", ATTRS{idVendor}=="0f0d", ATTRS{idProduct}=="00c1", MODE="0660", TAG+="uaccess"

      # HORIPAD mini 4
      KERNEL=="hidraw*", ATTRS{idVendor}=="0f0d", ATTRS{idProduct}=="00ee", MODE="0660", TAG+="uaccess"

      # Armor Armor 3 Pad PS4
      KERNEL=="hidraw*", ATTRS{idVendor}=="0c12", ATTRS{idProduct}=="0e10", MODE="0660", TAG+="uaccess"

      # STRIKEPAD PS4 Grip Add-on
      KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="05c5", MODE="0660", TAG+="uaccess"

      # NVIDIA Shield Portable (2013 - NVIDIA_Controller_v01.01 - In-Home Streaming only)
      KERNEL=="hidraw*", ATTRS{idVendor}=="0955", ATTRS{idProduct}=="7203", MODE="0660", TAG+="uaccess", ENV{ID_INPUT_JOYSTICK}="1", ENV{ID_INPUT_MOUSE}=""

      # NVIDIA Shield Controller (2015 - NVIDIA_Controller_v01.03 over USB hidraw)
      KERNEL=="hidraw*", ATTRS{idVendor}=="0955", ATTRS{idProduct}=="7210", MODE="0660", TAG+="uaccess", ENV{ID_INPUT_JOYSTICK}="1", ENV{ID_INPUT_MOUSE}=""

      # NVIDIA Shield Controller (2017 - NVIDIA_Controller_v01.04 over bluetooth hidraw)
      KERNEL=="hidraw*", KERNELS=="*0955:7214*", MODE="0660", TAG+="uaccess"

      # Astro C40
      KERNEL=="hidraw*", ATTRS{idVendor}=="9886", ATTRS{idProduct}=="0025", MODE="0660", TAG+="uaccess"

      # Thrustmaster eSwap Pro
      KERNEL=="hidraw*", ATTRS{idVendor}=="044f", ATTRS{idProduct}=="d00e", MODE="0660", TAG+="uaccess"

      # Performance Designed Products Victrix Pro FS-12 for PS4 & PS5
      KERNEL=="hidraw*", ATTRS{idVendor}=="0e6f", ATTRS{idProduct}=="020c", MODE="0660", TAG+="uaccess"
      # Vial udev rule
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
      # Via udev rule
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
    '';
  };
}
