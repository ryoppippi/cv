import { $ } from "jsr:@david/dax";

const gitRoot = $.path(await $`git rev-parse --show-toplevel`.text());
const webDir = gitRoot.join("web");
const typstDir = gitRoot.join("typst");

await Promise.all([
  $`deno task build`.cwd(webDir),
  $`deno task compile`.cwd(typstDir),
]);

$.cd(gitRoot);
await $`rm -rf dist`;
await $`mkdir -p dist`;
await $`cp -r ./web/dist/ .`;

const typstPdf = await $`ls ./typst`
  .lines()
  .then((lines) => lines.filter((line) => line.endsWith(".pdf")));

await Promise.all(
  typstPdf.map(async (pdf) => {
    await $`cp ./typst/${pdf} ./dist/`;
  }),
);
