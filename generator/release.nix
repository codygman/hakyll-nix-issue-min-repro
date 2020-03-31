with import <nixpkgs> {};
let myHaskellPackages = pkgs.haskellPackages.override {
          overrides = self: super: with pkgs.haskell.lib;
            { hakyll = addBuildDepend (appendConfigureFlag super.hakyll "-f previewServer") [self.warp]; }; };
    in myHaskellPackages.callPackage ./default.nix {}
