with import <nixpkgs> {};
let
  oldNixPkgs = builtins.fetchTarball {
    name = "nixos-1909-2020-03-30";
    url = https://github.com/nixos/nixpkgs/archive/d5291756487d70bc336e33512a9baf9fa1788faf.tar.gz;
    # Hash obtained using `nix-prefetch-url --unpack <url>`
    sha256 = "0mhqhq21y5vrr1f30qd2bvydv4bbbslvyzclhw0kdxmkgg3z4c92";
  };
  myHaskellPackages = oldNixPkgs.haskellPackages.override {
      overrides = self: super: with oldNixPkgs.haskell.lib;
        { hakyll = appendConfigureFlag super.hakyll "-f previewServer"; };
    }; in myHaskellPackages.callPackage ./default.nix {}
