with import <nixpkgs> {};
let
  myHaskellPackages = pkgs.haskellPackages.override {
    overrides = self: super: with pkgs.haskell.lib; {
      warp = doJailbreak (super.callHackage "warp" "3.2.28" {});
    };
  };
in myHaskellPackages.callPackage ./default.nix {}
