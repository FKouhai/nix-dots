_: {
  flake.nixosModules.udev = _: {
    users.groups.plugdev = { };

    services.udev = {
      enable = true;
      extraRules = ''
        # ── ZSA Keyboards ──────────────────────────────────────────────────────

        # Rules for Oryx web flashing and live training
        KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
        KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"

        # Legacy rules for live training over webusb (Not needed for firmware v21+)
        SUBSYSTEM=="usb", ATTR{idVendor}=="3297", GROUP="plugdev"
        SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", GROUP="plugdev"
        SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="1307", GROUP="plugdev"
        SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="6060", GROUP="plugdev"

        # Wally Flashing rules for the Ergodox EZ
        ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
        ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
        KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"

        # Keymapp / Wally Flashing rules for the Moonlander and Planck EZ
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE:="0666", SYMLINK+="stm32_dfu"
        # Keymapp Flashing rules for the Voyager
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="3297", MODE:="0666", SYMLINK+="ignition_dfu"

        # ── Gamepads & Controllers ─────────────────────────────────────────────

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

        # PowerA Wireless Controller for Nintendo Switch
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

        # NVIDIA Shield Portable (2013)
        KERNEL=="hidraw*", ATTRS{idVendor}=="0955", ATTRS{idProduct}=="7203", MODE="0660", TAG+="uaccess", ENV{ID_INPUT_JOYSTICK}="1", ENV{ID_INPUT_MOUSE}=""

        # NVIDIA Shield Controller (2015)
        KERNEL=="hidraw*", ATTRS{idVendor}=="0955", ATTRS{idProduct}=="7210", MODE="0660", TAG+="uaccess", ENV{ID_INPUT_JOYSTICK}="1", ENV{ID_INPUT_MOUSE}=""

        # NVIDIA Shield Controller (2017)
        KERNEL=="hidraw*", KERNELS=="*0955:7214*", MODE="0660", TAG+="uaccess"

        # Astro C40
        KERNEL=="hidraw*", ATTRS{idVendor}=="9886", ATTRS{idProduct}=="0025", MODE="0660", TAG+="uaccess"

        # Thrustmaster eSwap Pro
        KERNEL=="hidraw*", ATTRS{idVendor}=="044f", ATTRS{idProduct}=="d00e", MODE="0660", TAG+="uaccess"

        # Performance Designed Products Victrix Pro FS-12 for PS4 & PS5
        KERNEL=="hidraw*", ATTRS{idVendor}=="0e6f", ATTRS{idProduct}=="020c", MODE="0660", TAG+="uaccess"

        # ── Keyboard joystick suppression (fixes Sekiro/DS2 controller detection) ──

        # ZSA Moonlander Mark I
        SUBSYSTEM=="input", ATTRS{idVendor}=="3297", ATTRS{idProduct}=="1969", ENV{ID_INPUT_JOYSTICK}=""

        # MTKB W-SOFLE
        SUBSYSTEM=="input", ATTRS{idVendor}=="55d4", ATTRS{idProduct}=="0664", ENV{ID_INPUT_JOYSTICK}=""

        # ── QMK / Vial ─────────────────────────────────────────────────────────

        # Vial udev rule
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"

        # Via udev rule
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
      '';
    };
  };
}
