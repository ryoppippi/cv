#!/usr/bin/env deno run -A

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
  { owner: "ryoppippi", repo: "vim-svelte-inspector", name: "vim-svelte-inspector" },
  { owner: "ryoppippi", repo: "sveltweet", name: "sveltweet" },
  
  // Zig
  { owner: "ryoppippi", repo: "zigcv", name: "zigcv" },
  { owner: "ryoppippi", repo: "nyancat.zig", name: "nyancat.zig" },
];

async function fetchStarCount(owner: string, repo: string): Promise<number> {
  const token = Deno.env.get("GITHUB_TOKEN");
  const headers: HeadersInit = {
    "Accept": "application/vnd.github.v3+json",
  };
  
  if (token) {
    headers["Authorization"] = `token ${token}`;
  }
  
  const response = await fetch(
    `https://api.github.com/repos/${owner}/${repo}`,
    { headers }
  );
  
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

async function updateTypstFile() {
  const typstPath = "ryotaro_kimura.typ";
  let content = await Deno.readTextFile(typstPath);
  let updated = false;
  
  for (const project of projects) {
    try {
      const starCount = await fetchStarCount(project.owner, project.repo);
      const formattedCount = formatStarCount(starCount);
      
      // Create a regex pattern to match the project's star count
      const pattern = new RegExp(
        `(${project.name}:.*?\\(#icon\\("star"\\))([0-9.]+k?)\\)`,
        "g"
      );
      
      const newContent = content.replace(pattern, `$1${formattedCount})`);
      
      if (newContent !== content) {
        console.log(`✅ Updated ${project.name}: ${formattedCount} stars`);
        content = newContent;
        updated = true;
      } else {
        console.log(`ℹ️  ${project.name}: ${formattedCount} stars (no change)`);
      }
      
      // Small delay to avoid rate limiting
      await new Promise(resolve => setTimeout(resolve, 100));
    } catch (error) {
      console.error(`❌ Failed to update ${project.name}:`, error.message);
    }
  }
  
  if (updated) {
    await Deno.writeTextFile(typstPath, content);
    console.log("\n✨ Star counts updated successfully!");
    return true;
  } else {
    console.log("\n👍 All star counts are up to date!");
    return false;
  }
}

// Run the update
if (import.meta.main) {
  try {
    const hasChanges = await updateTypstFile();
    Deno.exit(hasChanges ? 0 : 0);
  } catch (error) {
    console.error("Error:", error);
    Deno.exit(1);
  }
}