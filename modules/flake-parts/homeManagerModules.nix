{ lib, ... }: let
  featuresDir = ../features;
  entries = builtins.readDir featuresDir;

  isFeatureDir = name: type:
    type == "directory" && builtins.pathExists (featuresDir + "/${name}/default.nix");

  topFeatures = lib.filterAttrs isFeatureDir entries;

  getSubFeatures = parentName: let
    parentDir = featuresDir + "/${parentName}";
    subEntries = builtins.readDir parentDir;
    subFeatureDirs = lib.filterAttrs
      (n: t: t == "directory" && builtins.pathExists (parentDir + "/${n}/default.nix"))
      subEntries;
  in lib.mapAttrs (name: _: import (parentDir + "/${name}")) subFeatureDirs;

  mkFeature = name:
    (import (featuresDir + "/${name}")) // (getSubFeatures name);
in {
  flake.homeManagerModules = lib.mapAttrs (name: _: mkFeature name) topFeatures;
}
