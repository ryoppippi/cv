# ryoppippi's cv

This repository contains my CV/Resume in PDF format, automatically built and deployed to [cv.ryoppippi.com](https://cv.ryoppippi.com).

## 🚀 Quick Start

### Prerequisites

- [Nix](https://nixos.org/) with flakes enabled

### Development

Watch for changes and recompile automatically:

```bash
nix develop -c bun run dev
```

### Build

Build for deployment:

```bash
./scripts/build.ts
```

### Update GitHub Stars

Update star counts for featured projects:

```bash
GITHUB_TOKEN=your_token ./scripts/update-stars.ts
```

## 📁 Project Structure

```
.
├── ryotaro_kimura.typ    # Main CV source file
├── alta-typst.typ        # Typography template
├── ibm-sans/             # Font files
├── icons/                # SVG icons
├── scripts/              # Build scripts (with nix shebang)
├── _redirects            # Netlify redirect rules
└── dist/                 # Build output (generated)
```

## 🌐 Deployment

The CV is automatically deployed to Netlify. All URLs redirect to the PDF file for immediate access.

## 📄 License

See [LICENSE](LICENSE) file.
