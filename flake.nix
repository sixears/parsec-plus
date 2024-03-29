{
  description = "Parsecable class, with file-reading functions";

  inputs = {
    nixpkgs.url      = "github:nixos/nixpkgs/be44bf67"; # nixos-22.05 2022-10-15
    build-utils.url  = github:sixears/flake-build-utils/r1.0.0.13;

    base1t.url           = github:sixears/base1t/r0.0.5.36;
    fpath.url            = github:sixears/fpath/r1.3.2.39;
    monaderror-io.url    = github:sixears/monaderror-io/r1.2.5.20;
    monadio-plus.url     = github:sixears/monadio-plus/r2.5.1.49;
    parsec-plus-base.url = github:sixears/parsec-plus-base/r1.0.5.23;
  };

  outputs = { self, nixpkgs, build-utils
            , base1t, fpath, monaderror-io, monadio-plus, parsec-plus-base }:
    build-utils.lib.hOutputs self nixpkgs "parsec-plus" {
      ghc = p: p.ghc8107; # for tfmt
      callPackage = { mkDerivation, lib, mapPkg, system
                    , base, base-unicode-symbols, data-textual, lens, mtl
                    , parsec }:
        mkDerivation {
          pname = "parsec-plus";
          version = "1.1.1.44";
          src = ./.;
          libraryHaskellDepends = [
            base base-unicode-symbols data-textual lens mtl parsec
          ] ++ mapPkg [
            base1t fpath monaderror-io monadio-plus parsec-plus-base
          ];
          testHaskellDepends = [ base ];
          description = "Parsecable class, with file-reading functions";
          license = lib.licenses.mit;
        };

    };
}
