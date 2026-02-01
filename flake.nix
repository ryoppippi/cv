{
  nixConfig = {
    extra-substituters = [ "https://wrangler.cachix.org" ];
    extra-trusted-public-keys = [
      "wrangler.cachix.org-1:N/FIcG2qBQcolSpklb2IMDbsfjZKWg+ctxx0mSMXdSs="
    ];
  };

  inputs = {
    cloudflare-redirects = {
      url = "github:ryoppippi/cloudflare-redirects-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    git-hooks.url = "github:cachix/git-hooks.nix";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    wrangler = {
      url = "github:emrldnix/wrangler";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      wrangler,
      git-hooks,
      treefmt-nix,
      cloudflare-redirects,
      ...
    }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;

      inherit (cloudflare-redirects.lib) generateRedirects;

      treefmtEval =
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        treefmt-nix.lib.evalModule pkgs {
          projectRootFile = "flake.nix";
          programs = {
            nixfmt.enable = true;
            deadnix.enable = true;
            statix.enable = true;
            typstyle.enable = true;
          };
          settings.formatter.oxfmt = {
            command = "${pkgs.oxfmt}/bin/oxfmt";
            includes = [
              "*.md"
              "*.yml"
              "*.yaml"
              "*.json"
              "*.jsonc"
              "*.toml"
              "*.ts"
            ];
            excludes = [ ];
          };
        };
    in
    {
      formatter = forAllSystems (system: (treefmtEval system).config.build.wrapper);

      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          ibmPlexFonts = pkgs.ibm-plex;
        in
        {
          default = pkgs.stdenvNoCC.mkDerivation {
            pname = "ryoppippi-cv";
            version = "1.0.0";

            src = pkgs.lib.cleanSourceWith {
              src = ./.;
              filter =
                path: _type:
                let
                  baseName = baseNameOf path;
                in
                baseName != "dist"
                && baseName != "result"
                && baseName != "node_modules"
                && baseName != "ibm-sans"
                && baseName != ".direnv"
                && baseName != "_redirects";
            };

            nativeBuildInputs = [
              pkgs.typst
            ];

            buildPhase = ''
              runHook preBuild
              typst compile ./ryotaro_kimura.typ --font-path ${ibmPlexFonts}/share/fonts/opentype
              runHook postBuild
            '';

            installPhase = ''
              runHook preInstall
              mkdir -p $out
              cp *.pdf $out/
              echo '${generateRedirects ./redirects.toml}' > $out/_redirects
              runHook postInstall
            '';
          };
        }
      );

      checks = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          ibmPlexFonts = pkgs.ibm-plex;
          pre-commit-check = git-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              gitleaks = {
                enable = true;
                entry = "${pkgs.gitleaks}/bin/gitleaks protect --staged --config .gitleaks.toml";
              };
              treefmt = {
                enable = true;
                entry = "${(treefmtEval system).config.build.wrapper}/bin/treefmt --fail-on-change --no-cache";
                pass_filenames = false;
              };
            };
          };
        in
        {
          inherit pre-commit-check;

          formatting = (treefmtEval system).config.build.check ./.;

          pdf-page-count =
            pkgs.runCommand "check-pdf-pages"
              {
                nativeBuildInputs = [
                  pkgs.typst
                  pkgs.qpdf
                ];
                src = pkgs.lib.cleanSourceWith {
                  src = ./.;
                  filter =
                    path: _type:
                    let
                      baseName = baseNameOf path;
                    in
                    baseName != "dist"
                    && baseName != "result"
                    && baseName != "node_modules"
                    && baseName != "ibm-sans"
                    && baseName != ".direnv";
                };
              }
              ''
                cp -r $src/* .
                typst compile ./ryotaro_kimura.typ --font-path ${ibmPlexFonts}/share/fonts/opentype
                pages=$(qpdf --show-npages ./ryotaro_kimura.pdf)
                if [ "$pages" -ne 2 ]; then
                  echo "ERROR: PDF has $pages pages, expected 2"
                  exit 1
                fi
                echo "PDF has 2 pages"
                touch $out
              '';

          typos =
            pkgs.runCommand "check-typos"
              {
                nativeBuildInputs = [ pkgs.typos ];
                src = ./.;
              }
              ''
                cd $src
                typos
                touch $out
              '';

          gitleaks =
            pkgs.runCommand "check-gitleaks"
              {
                nativeBuildInputs = [ pkgs.gitleaks ];
                src = ./.;
              }
              ''
                cd $src
                gitleaks detect --source . --config .gitleaks.toml --no-git
                touch $out
              '';
        }
      );

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          ibmPlexFonts = pkgs.ibm-plex;
          pre-commit-check = git-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              gitleaks = {
                enable = true;
                entry = "${pkgs.gitleaks}/bin/gitleaks protect --staged --config .gitleaks.toml";
              };
              treefmt = {
                enable = true;
                entry = "${(treefmtEval system).config.build.wrapper}/bin/treefmt --fail-on-change --no-cache";
                pass_filenames = false;
              };
            };
          };
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              typst
              qpdf
              bun
              typos-lsp
              gitleaks
              nixd
            ];
            shellHook = ''
              export TYPST_FONT_PATHS="${ibmPlexFonts}/share/fonts/opentype"
              ${pre-commit-check.shellHook}
            '';
          };
        }
      );

      apps = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          wranglerPkg = wrangler.packages.${system}.default;
        in
        {
          deploy = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "deploy" ''
                ${wranglerPkg}/bin/wrangler deploy
              ''
            );
          };

          preview = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "preview" ''
                ${wranglerPkg}/bin/wrangler versions upload
              ''
            );
          };
        }
      );
    };
}
