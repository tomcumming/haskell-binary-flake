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
            url = https://downloads.haskell.org/~ghc/9.6.3/ghc-9.6.3-aarch64-apple-darwin.tar.xz;
          in
          pkgs.stdenv.mkDerivation {
            name = "ghc96";
            src = pkgs.fetchurl {
              url = url;
              sha256 = "4c30WJJrLq9S0qgofZmpZQQP+QURcfXDt0ZwSc8OshM=";
            };
            sourceRoot = "ghc-9.6.3-aarch64-apple-darwin";
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
        hls25ghc96 =
          let
            url = https://downloads.haskell.org/~hls/haskell-language-server-2.5.0.0/haskell-language-server-2.5.0.0-aarch64-apple-darwin.tar.xz;
          in
          pkgs.stdenv.mkDerivation {
            name = "hls25ghc96";
            src = pkgs.fetchurl {
              url = url;
              sha256 = "LlCD6/f8ndPFqjEFn5M2vsRAf/+yG5OiDey0npz4gKQ=";
            };
            sourceRoot = "haskell-language-server-2.5.0.0";
            dontPatch = true;
            dontBuild = true;
            dontStrip = true;
            dontConfigure = true;
            installPhase = ''
              mkdir -p $out/bin
              mkdir -p $out/lib/9.6.3
              cp bin/haskell-language-server-9.6.3 bin/haskell-language-server-wrapper $out/bin/
              cp lib/9.6.3/*.dylib $out/lib/9.6.3/
              for f in ${ghc96}/lib/aarch64-osx-ghc-9.6.3/*.dylib
              do
                ln -s $f $out/lib/9.6.3/
              done
            '';
          };
        hls25ghc98 =
          let
            url = https://downloads.haskell.org/~hls/haskell-language-server-2.5.0.0/haskell-language-server-2.5.0.0-aarch64-apple-darwin.tar.xz;
          in
          pkgs.stdenv.mkDerivation {
            name = "hls25ghc98";
            src = pkgs.fetchurl {
              url = url;
              sha256 = "LlCD6/f8ndPFqjEFn5M2vsRAf/+yG5OiDey0npz4gKQ=";
            };
            sourceRoot = "haskell-language-server-2.5.0.0";
            dontPatch = true;
            dontBuild = true;
            dontStrip = true;
            dontConfigure = true;
            installPhase = ''
              mkdir -p $out/bin
              mkdir -p $out/lib/9.8.1
              cp bin/haskell-language-server-9.8.1 bin/haskell-language-server-wrapper $out/bin/
              cp lib/9.8.1/*.dylib $out/lib/9.8.1/
              for f in ${ghc98}/lib/aarch64-osx-ghc-9.8.1/*.dylib
              do
                ln -s $f $out/lib/9.8.1/
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
