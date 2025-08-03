import { $ } from "bun";
import path from "path";

const gitRoot = await $`git rev-parse --show-toplevel`.text();
const gitRootPath = gitRoot.trim();
const distDir = path.join(gitRootPath, "dist");

// Compile typst
await $`bun run compile`.cwd(gitRootPath);

// Setup dist directory
await $`rm -rf ${distDir}`;
await $`mkdir -p ${distDir}`;

// Copy PDF files
const typstPdfFiles = await $`ls *.pdf`.cwd(gitRootPath).text();
const pdfFiles = typstPdfFiles.trim().split('\n').filter(Boolean);

for (const pdf of pdfFiles) {
  await $`cp ${pdf} ${distDir}/`.cwd(gitRootPath);
}

// Copy _redirects file
await $`cp _redirects ${distDir}/`.cwd(gitRootPath);

console.log("Build completed successfully!");