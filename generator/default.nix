{ mkDerivation, base, directory, filepath, hakyll, stdenv
, unordered-containers, pandoc, warp
}:
mkDerivation {
  pname = "codygman-site-generator";
  version = "1";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  enableSeparateDataOutput = true;
  executableHaskellDepends = [
    base directory filepath hakyll unordered-containers pandoc warp
  ];
  license = stdenv.lib.licenses.mit;
}
