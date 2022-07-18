{ lib, ... }:
let
  modules = import ./modules.nix { inherit lib; };
  allModules = modules.mapModulesRec ./. (m: import m { inherit lib; });
  result = lib.foldl' (x: y: x // y) {} allModules;
in
result
