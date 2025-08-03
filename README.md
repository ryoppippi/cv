# ryoppippi's cv

This repository contains my CV/Resume in PDF format, automatically built and deployed to [cv.ryoppippi.com](https://cv.ryoppippi.com).

## 🚀 Quick Start

### Prerequisites

- [Bun](https://bun.sh) (latest version)
- [Typst](https://typst.app) (for compiling the CV)

### Installation

```bash
bun install
```

### Development

Watch for changes and recompile automatically:

```bash
bun run dev
```

### Build

Compile the CV to PDF:

```bash
bun run compile
```

Build for deployment:

```bash
bun run build
```

### Update GitHub Stars

Update star counts for featured projects:

```bash
GITHUB_TOKEN=your_token bun run update-stars
```

## 📁 Project Structure

```
.
├── ryotaro_kimura.typ    # Main CV source file
├── alta-typst.typ        # Typography template
├── ibm-sans/             # Font files
├── icons/                # SVG icons
├── scripts/              # Build scripts
├── _redirects            # Netlify redirect rules
└── dist/                 # Build output (generated)
```

## 🌐 Deployment

The CV is automatically deployed to Netlify. All URLs redirect to the PDF file for immediate access.

## 📄 License

See [LICENSE](LICENSE) file.