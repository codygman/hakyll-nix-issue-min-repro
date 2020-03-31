# Try adding warp dependency manually with addBuildDepend (based on [help in irc](https://logs.nix.samueldr.com/nixos/2020-03-31#3249351;))

### change

```diff
modified   generator/release.nix
@@ -1,6 +1,5 @@
 with import <nixpkgs> {};
 let myHaskellPackages = pkgs.haskellPackages.override {
           overrides = self: super: with pkgs.haskell.lib;
-            { hakyll = appendConfigureFlag super.hakyll "-f previewServer";
-            }; };
+            { hakyll = addBuildDepend (appendConfigureFlag super.hakyll "-f previewServer") [self.warp]; }; };
     in myHaskellPackages.callPackage ./default.nix {}
```

### output (shell.nix just calls
     [blogDefault.nix](https://github.com/codygman/hakyll-nix-issue-min-repro/blob/master/blogDefault.nix)
     ) which imports [generator/release.nix](https://github.com/codygman/hakyll-nix-issue-min-repro/blob/master/generator/release.nix)

```shell
[cody@nixos:~/code/hakyll-nix-issue-min-repro]$ nix-shell
these derivations will be built:
  /nix/store/1hzq9iqhz8nrzwah5cr8d7snlr91i9vh-hakyll-4.13.2.0.drv
  /nix/store/9lm131dysv70aj01v69jpf22v2kw9sq8-codygman-site-generator-1.drv
...
Setup: Encountered missing or private dependencies:
warp ==3.2.*
...

```


# Issue

```
Setup: Encountered missing or private dependencies:
warp ==3.2.*
```

```
[cody@nixos:~/code/hakyll-nix-issue-min-repro]$ nix-shell
these derivations will be built:
  /nix/store/q12a6bqigicmagwkycivykb2cdwq1g0b-hakyll-4.13.2.0.drv
  /nix/store/83j4h2fcmg4p96ds12chrp0fflf6q58y-codygman-site-generator-1.drv
building '/nix/store/q12a6bqigicmagwkycivykb2cdwq1g0b-hakyll-4.13.2.0.drv'...
setupCompilerEnvironmentPhase
Build with /nix/store/p0fb116qx8had06riiqryf74pk8i6nzi-ghc-8.8.3.
unpacking sources
unpacking source archive /nix/store/llfrbj4zimagjam4nfdp6jp31dfw7vyb-hakyll-4.13.2.0.tar.gz
source root is hakyll-4.13.2.0
setting SOURCE_DATE_EPOCH to timestamp 1583579578 of file hakyll-4.13.2.0/CHANGELOG.md
patching sources
compileBuildDriverPhase
setupCompileFlags: -package-db=/build/setup-package.conf.d -j4 -threaded
[1 of 1] Compiling Main             ( Setup.hs, /build/Main.o )
Linking Setup ...
configuring
configureFlags: --verbose --prefix=/nix/store/nddv6qhag6wypy75n5msw4dk6bfl9jih-hakyll-4.13.2.0 --libdir=$prefix/lib/$compiler --libsubdir=$abi/$libname --datadir=/nix/store/zw1869ghdsqnrq3f29js8b7kq1cag5f1-hakyll-4.13.2.0-data/share/ghc-8.8.3 --docdir=/nix/store/z6f7wa8js0pdnalj58s566n7f83l7xpj-hakyll-4.13.2.0-doc/share/doc/hakyll-4.13.2.0 --with-gcc=gcc --package-db=/build/package.conf.d --ghc-option=-j4 --disable-split-objs --enable-library-profiling --profiling-detail=exported-functions --disable-profiling --enable-shared --disable-coverage --enable-static --disable-executable-dynamic --enable-tests --disable-benchmarks --enable-library-vanilla --disable-library-for-ghci --ghc-option=-split-sections -f previewServer --extra-lib-dirs=/nix/store/pavdj2qj5nhd9dlajva84b5hlp53slgm-ncurses-6.2/lib --extra-lib-dirs=/nix/store/1860ic8dll1yi2dq3v0j52pjrg35kg0m-libffi-3.3/lib --extra-lib-dirs=/nix/store/wb2qndwf6hk4a331nzr9j5lk221xlxxs-gmp-6.2.0/lib
Using Parsec parser
Configuring hakyll-4.13.2.0...
CallStack (from HasCallStack):
  die', called at libraries/Cabal/Cabal/Distribution/Simple/Configure.hs:1022:20 in Cabal-3.0.1.0:Distribution.Simple.Configure
  configureFinalizedPackage, called at libraries/Cabal/Cabal/Distribution/Simple/Configure.hs:475:12 in Cabal-3.0.1.0:Distribution.Simple.Configure
  configure, called at libraries/Cabal/Cabal/Distribution/Simple.hs:625:20 in Cabal-3.0.1.0:Distribution.Simple
  confHook, called at libraries/Cabal/Cabal/Distribution/Simple/UserHooks.hs:65:5 in Cabal-3.0.1.0:Distribution.Simple.UserHooks
  configureAction, called at libraries/Cabal/Cabal/Distribution/Simple.hs:180:19 in Cabal-3.0.1.0:Distribution.Simple
  defaultMainHelper, called at libraries/Cabal/Cabal/Distribution/Simple.hs:116:27 in Cabal-3.0.1.0:Distribution.Simple
  defaultMain, called at Setup.hs:2:8 in main:Main
Setup: Encountered missing or private dependencies:
warp ==3.2.*

builder for '/nix/store/q12a6bqigicmagwkycivykb2cdwq1g0b-hakyll-4.13.2.0.drv' failed with exit code 1
cannot build derivation '/nix/store/83j4h2fcmg4p96ds12chrp0fflf6q58y-codygman-site-generator-1.drv': 1 dependencies couldn't be built
error: build of '/nix/store/83j4h2fcmg4p96ds12chrp0fflf6q58y-codygman-site-generator-1.drv' failed
```

