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
    nix-filter.url = "github:numtide/nix-filter";
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
      nix-filter,
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

      inherit (cloudflare-redirects.lib) generateRedirectsFromList;

      redirects = [
        {
          from = "/*";
          to = "/ryotaro_kimura.pdf";
          status = 200;
        }
      ];

      wranglerConfig = {
        "$schema" =
          "https://raw.githubusercontent.com/cloudflare/workers-sdk/refs/heads/main/packages/wrangler/config-schema.json";
        name = "cv";
        compatibility_date = "2025-01-29";
        assets = {
          directory = ".";
          not_found_handling = "none";
        };
      };

      cleanedSource = nix-filter {
        root = ./.;
        exclude = [
          ".direnv"
          "result"
        ];
      };

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

            src = cleanedSource;

            nativeBuildInputs = [
              pkgs.typst
            ];

            buildPhase = ''
              runHook preBuild
              typst compile ./ryotaro_kimura.typ --font-path ${ibmPlexFonts}/share/fonts/opentype
              runHook postBuild
            '';

            installPhase =
              let
                wranglerConfigJson = builtins.toJSON wranglerConfig;
              in
              ''
                runHook preInstall
                mkdir -p $out
                cp *.pdf $out/
                echo '${generateRedirectsFromList redirects}' > $out/_redirects
                echo '${wranglerConfigJson}' > $out/wrangler.json
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
                src = cleanedSource;
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
                src = cleanedSource;
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
                src = cleanedSource;
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
                tmpdir=$(mktemp -d)
                trap "rm -rf $tmpdir" EXIT
                cp -r result/* "$tmpdir/"
                cd "$tmpdir" && ${wranglerPkg}/bin/wrangler deploy
              ''
            );
          };

          preview = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "preview" ''
                tmpdir=$(mktemp -d)
                trap "rm -rf $tmpdir" EXIT
                cp -r result/* "$tmpdir/"
                cd "$tmpdir" && ${wranglerPkg}/bin/wrangler versions upload
              ''
            );
          };
        }
      );
    };
}
