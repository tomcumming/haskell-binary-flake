{
  description = "Haskell binaries";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
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
        hls24ghc96 =
          let
            url = https://downloads.haskell.org/~hls/haskell-language-server-2.4.0.0/haskell-language-server-2.4.0.0-aarch64-apple-darwin.tar.xz;
          in
          pkgs.stdenv.mkDerivation {
            name = "hls24ghc96";
            src = pkgs.fetchurl {
              url = url;
              sha256 = "dM+kf5YaxWBwVcovQAtHGlNee5gukQ4YfHwTA7BI7q8=";
            };
            sourceRoot = "haskell-language-server-2.4.0.0";
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
