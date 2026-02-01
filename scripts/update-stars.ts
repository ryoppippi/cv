#!/usr/bin/env nix
/*
#! nix shell --inputs-from . nixpkgs#bun -c bun
*/

interface Project {
  owner: string;
  repo: string;
  name: string;
}

const projects: Project[] = [
  // AI Tools
  { owner: "ryoppippi", repo: "ccusage", name: "ccusage" },
  { owner: "ryoppippi", repo: "SiteMCP", name: "SiteMCP" },
  { owner: "ryoppippi", repo: "curxy", name: "curxy" },

  // Web Development / TypeScript Ecosystem
  { owner: "ryoppippi", repo: "unplugin-typia", name: "unplugin-typia" },
  { owner: "ryoppippi", repo: "pkg-to-jsr", name: "pkg-to-jsr" },
  { owner: "ryoppippi", repo: "mirror-jsr-to-npm", name: "mirror-jsr-to-npm" },
  {
    owner: "ryoppippi",
    repo: "vim-svelte-inspector",
    name: "vim-svelte-inspector",
  },
  { owner: "ryoppippi", repo: "sveltweet", name: "sveltweet" },

  // Zig
  { owner: "ryoppippi", repo: "zigcv", name: "zigcv" },
  { owner: "ryoppippi", repo: "nyancat.zig", name: "nyancat.zig" },
];

async function fetchStarCount(owner: string, repo: string): Promise<number> {
  const token = Bun.env.GITHUB_TOKEN;
  const headers: HeadersInit = {
    Accept: "application/vnd.github.v3+json",
  };

  if (token) {
    headers["Authorization"] = `token ${token}`;
  }

  const response = await fetch(`https://api.github.com/repos/${owner}/${repo}`, { headers });

  if (!response.ok) {
    throw new Error(`Failed to fetch ${owner}/${repo}: ${response.statusText}`);
  }

  const data = await response.json();
  return data.stargazers_count;
}

function formatStarCount(count: number): string {
  if (count >= 1000) {
    return `${(count / 1000).toFixed(1)}k`;
  }
  return count.toString();
}

async function processInBatches<T, R>(
  items: T[],
  batchSize: number,
  processor: (item: T) => Promise<R>,
): Promise<R[]> {
  const results: R[] = [];
  for (let i = 0; i < items.length; i += batchSize) {
    const batch = items.slice(i, i + batchSize);
    const batchResults = await Promise.all(batch.map(processor));
    results.push(...batchResults);
  }
  return results;
}

if (import.meta.main) {
  const typstPath = "ryotaro_kimura.typ";
  let content = await Bun.file(typstPath).text();
  let updated = false;

  const results = await processInBatches(projects, 5, async (project) => {
    try {
      const starCount = await fetchStarCount(project.owner, project.repo);
      const formattedCount = formatStarCount(starCount);
      return { project, formattedCount, success: true };
    } catch (error: unknown) {
      const message = error instanceof Error ? error.message : String(error);
      console.error(`❌ Failed to update ${project.name}:`, message);
      return { project, formattedCount: "", success: false };
    }
  });

  for (const result of results) {
    if (!result.success) continue;

    const { project, formattedCount } = result;

    const pattern = new RegExp(`(\\[${project.name}\\].*?\\(#icon\\("star"\\))([0-9.]+k?)\\)`, "g");

    const newContent = content.replace(pattern, `$1${formattedCount})`);

    if (newContent !== content) {
      console.log(`✅ Updated ${project.name}: ${formattedCount} stars`);
      content = newContent;
      updated = true;
    } else {
      console.log(`ℹ️  ${project.name}: ${formattedCount} stars (no change)`);
    }
  }

  if (!updated) {
    console.log("\n👍 All star counts are up to date!");
    process.exit(0);
  }
  await Bun.write(typstPath, content);
  console.log("\n✨ Star counts updated successfully!");
}
