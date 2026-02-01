# CV Project

A Typst-based CV/Resume that compiles to PDF and deploys to Cloudflare Workers.

## Build System

This project uses Nix for all dependencies and builds. No npm/bun packages are required.

### Key Commands

- `nix build` - Build the PDF (output in `result/`)
- `nix run .#deploy` - Deploy to Cloudflare Workers
- `nix run .#preview` - Create preview deployment
- `nix flake check` - Run all checks (PDF page count, typos, gitleaks)
- `nix develop` - Enter development shell

### Scripts

Scripts use nix shebang and are self-contained:

- `./scripts/update-stars.ts` - Update GitHub star counts in the CV

### Redirects

Redirect rules are defined in `redirects.toml` and converted to `_redirects` format during build via a Nix function.

### Fonts

IBM Plex Sans font is provided by nixpkgs (`pkgs.ibm-plex`), not stored locally.

### Deployment

- Wrangler is provided by the `emrldnix/wrangler` flake input
- Assets are served from the nix build output (`result/`)
- CI uses `nix-community/cache-nix-action` to cache the Nix store
