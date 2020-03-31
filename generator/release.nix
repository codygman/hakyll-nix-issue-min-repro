with import <nixpkgs> {};
let myHaskellPackages = pkgs.haskellPackages.override {
      overrides = self: super: with pkgs.haskell.lib;
        { hakyll = doJailbreak (appendConfigureFlag super.hakyll "-f previewServer"); };
    }; in myHaskellPackages.callPackage ./default.nix {}
