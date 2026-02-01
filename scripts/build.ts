#!/usr/bin/env nix
/*
#! nix shell --inputs-from . nixpkgs#bun nixpkgs#typst -c bun
*/

import { $ } from "bun";
import path from "path";

const gitRoot = await $`git rev-parse --show-toplevel`.text();
const gitRootPath = gitRoot.trim();
const distDir = path.join(gitRootPath, "dist");

$.cwd(gitRootPath);

// Compile typst
await $`./scripts/update-stars.ts`;
await $`typst compile ./ryotaro_kimura.typ --font-path ./ibm-sans`;

// Setup dist directory
await $`rm -rf ${distDir}`;
await $`mkdir -p ${distDir}`;

// Copy PDF files
const typstPdfFiles = await $`ls *.pdf`.text();
const pdfFiles = typstPdfFiles.trim().split('\n').filter(Boolean);

for (const pdf of pdfFiles) {
  await $`cp ${pdf} ${distDir}/`;
}

// Copy _redirects file
await $`cp _redirects ${distDir}/`;

console.log("Build completed successfully!");
