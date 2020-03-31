{ stdenv
, glibcLocales
, generator ? import ./generator/release.nix
}:
let ignores = [ "_cache" "_site" "result" ];
in stdenv.mkDerivation rec {
	name = "codygman-blog";
	version = "1";
	src = builtins.filterSource
		(path: _: builtins.foldl' (acc: el: acc && builtins.baseNameOf path != el) true ignores)
		./.;

  configureFlags = "-f watchServer -f previewServer";
	phases = "unpackPhase buildPhase";
	buildInputs = [ generator glibcLocales ];
	buildPhase = ''
				export LANG=en_US.UTF-8
				chmod -R u+w *
				site rebuild
				mkdir $out
				cp -r _site/* $out
		'';

	meta = {
		license = stdenv.lib.licenses.gpl3;
	};
}
