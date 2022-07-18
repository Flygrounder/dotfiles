{ lib, ... }:
rec {
  mapModulesRec = dir: fn:
    let
      files = builtins.readDir dir;
      modules = lib.mapAttrsToList (file: type:
        let
          path = dir + "/${file}";
          defaultPath = path + /default.nix;
        in
        if type == "regular" && lib.hasSuffix ".nix" file && file != "default.nix"
        then fn path
        else if type == "directory" && lib.pathExists defaultPath then fn defaultPath
        else if type == "directory" then (mapModulesRec path fn)
        else []) files;
    in
      lib.flatten modules;
}
