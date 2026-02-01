{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      checks = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          pdf-page-count = pkgs.runCommand "check-pdf-pages"
            {
              nativeBuildInputs = [
                pkgs.typst
                pkgs.qpdf
              ];
              src = ./.;
            }
            ''
              cp -r $src/* .
              typst compile ./ryotaro_kimura.typ --font-path ./ibm-sans
              pages=$(qpdf --show-npages ./ryotaro_kimura.pdf)
              if [ "$pages" -ne 2 ]; then
                echo "ERROR: PDF has $pages pages, expected 2"
                exit 1
              fi
              echo "PDF has 2 pages"
              touch $out
            '';
        }
      );

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              bun
              qpdf
            ];
          };
        }
      );
    };
}
