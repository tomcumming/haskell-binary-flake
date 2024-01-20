{
  description = "Haskell binaries";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs }: {
    packages."aarch64-darwin" =
      let pkgs = nixpkgs.legacyPackages."aarch64-darwin";
      in rec {
        ghc96 =
          let
            url = https://downloads.haskell.org/~ghc/9.6.4/ghc-9.6.4-aarch64-apple-darwin.tar.xz;
          in
          pkgs.stdenv.mkDerivation {
            name = "ghc96";
            src = pkgs.fetchurl {
              url = url;
              sha256 = "sha256-Ja/8nOtvIDJwbsG0t7pdFL003ztSI9gGDyEK7OJf7qk=";
            };
            sourceRoot = "ghc-9.6.4-aarch64-apple-darwin";
            dontPatch = true;
            dontBuild = true;
            dontStrip = true;
            configurePhase = ''
              ./configure
              make lib/settings
            '';
            installPhase = ''
              mkdir -p $out
              cp -r bin $out/bin
              cp -r lib $out/lib
            '';
          };
        ghc98 =
          let
            url = https://downloads.haskell.org/~ghc/9.8.1/ghc-9.8.1-aarch64-apple-darwin.tar.xz;
          in
          pkgs.stdenv.mkDerivation {
            name = "ghc98";
            src = pkgs.fetchurl {
              url = url;
              sha256 = "o4uwb2DJLTSOPuknpKiOiEiPh06Z9EDQYkSk5Pnbnjs=";
            };
            sourceRoot = "ghc-9.8.1-aarch64-apple-darwin";
            dontPatch = true;
            dontBuild = true;
            dontStrip = true;
            configurePhase = ''
              ./configure
              make lib/settings
            '';
            installPhase = ''
              mkdir -p $out
              cp -r bin $out/bin
              cp -r lib $out/lib
            '';
          };
        hls26ghc96 =
          let
            url = https://downloads.haskell.org/~hls/haskell-language-server-2.6.0.0/haskell-language-server-2.6.0.0-aarch64-apple-darwin.tar.xz;
          in
          pkgs.stdenv.mkDerivation {
            name = "hls26ghc96";
            src = pkgs.fetchurl {
              url = url;
              sha256 = "sha256-iYxPGIyjvDinz9OoMCNk+wrjXEJScBdwBzgl9olMur8=";
            };
            sourceRoot = "haskell-language-server-2.6.0.0";
            dontPatch = true;
            dontBuild = true;
            dontStrip = true;
            dontConfigure = true;
            installPhase = ''
              mkdir -p $out/bin
              mkdir -p $out/lib/9.6.4
              cp bin/haskell-language-server-9.6.4 bin/haskell-language-server-wrapper $out/bin/
              cp lib/9.6.4/*.dylib $out/lib/9.6.4/
              for f in ${ghc96}/lib/aarch64-osx-ghc-9.6.4/*.dylib
              do
                ln -s $f $out/lib/9.6.4/
              done
            '';
          };
        cabal38 =
          let
            url = https://downloads.haskell.org/cabal/cabal-install-3.10.2.0/cabal-install-3.10.2.0-aarch64-darwin.tar.xz;
          in
          pkgs.stdenv.mkDerivation {
            name = "cabal";
            src = pkgs.fetchurl {
              url = url;
              sha256 = "0r0zbXOXz0t287sNgN6iTKD6BHkD45yDBbE26FUmnXs=";
            };
            sourceRoot = ".";
            dontPatch = true;
            dontBuild = true;
            dontStrip = true;
            dontConfigure = true;
            installPhase = ''
              mkdir -p $out/bin
              cp cabal $out/bin/cabal
            '';
          };
      };

    formatter."aarch64-darwin" = nixpkgs.legacyPackages."aarch64-darwin".nixpkgs-fmt;
  };
}
