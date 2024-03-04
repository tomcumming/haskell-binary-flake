{
  description = "Haskell binaries";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs }: {
    packages."aarch64-darwin" =
      let pkgs = nixpkgs.legacyPackages."aarch64-darwin";
      in rec {
        ghc98 =
          let
            url = https://downloads.haskell.org/~ghc/9.8.2/ghc-9.8.2-aarch64-apple-darwin.tar.xz;
          in
          pkgs.stdenv.mkDerivation {
            name = "ghc98";
            src = pkgs.fetchurl {
              url = url;
              sha256 = "Z74Ine2+WZ2RHv2PguT5oZIldho4cr5039S1pVf7jho=";
            };
            sourceRoot = "ghc-9.8.2-aarch64-apple-darwin";
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
        hls27ghc98 =
          let
            url = https://downloads.haskell.org/~hls/haskell-language-server-2.7.0.0/haskell-language-server-2.7.0.0-aarch64-apple-darwin.tar.xz;
          in
          pkgs.stdenv.mkDerivation {
            name = "hls27ghc98";
            src = pkgs.fetchurl {
              url = url;
              sha256 = "fKbtTWy4DltIbDNKjVeZJ5eO21a52xupLiyKqJMudQY=";
            };
            sourceRoot = "haskell-language-server-2.7.0.0";
            dontPatch = true;
            dontBuild = true;
            dontStrip = true;
            dontConfigure = true;
            installPhase = ''
              mkdir -p $out/bin
              mkdir -p $out/lib/9.8.2
              cp bin/haskell-language-server-9.8.2 bin/haskell-language-server-wrapper $out/bin/
              cp lib/9.8.2/*.dylib $out/lib/9.8.2/
              for f in ${ghc98}/lib/aarch64-osx-ghc-9.8.2/*.dylib
              do
                ln -s $f $out/lib/9.8.2/
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
