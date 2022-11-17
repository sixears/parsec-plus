{
  description = "Parsecable class, with file-reading functions";

  inputs = {
    nixpkgs.url      = "github:nixos/nixpkgs/be44bf67"; # nixos-22.05 2022-10-15
    build-utils.url  = "github:sixears/flake-build-utils/r1.0.0.11";

    base1t.url           = "github:sixears/base1t/r0.0.5.14";
    fpath.url            = "github:sixears/fpath/r1.3.2.14";
    monaderror-io.url    = "github:sixears/monaderror-io/r1.2.5.11";
    monadio-plus.url     = "github:sixears/monadio-plus/r2.5.1.16";
    parsec-plus-base.url = "github:sixears/parsec-plus-base/r1.0.5.12";
  };

  outputs = { self, nixpkgs, build-utils
            , base1t, fpath, monaderror-io, monadio-plus, parsec-plus-base }:
    build-utils.lib.hOutputs self nixpkgs "parsec-plus" {
      deps = {
        inherit base1t fpath monaderror-io monadio-plus parsec-plus-base;
      };
      ghc = p: p.ghc8107; # for tfmt
    };
}
