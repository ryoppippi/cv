import lume from "lume/mod.ts";
import lightningCss from "lume/plugins/lightningcss.ts";
import favicon from "lume/plugins/favicon.ts";

const site = lume({
  dest: "./dist",
})
  .use(lightningCss())
  .use(favicon({
    input: "./favicon.png",
  }))
  .ignore("README.md", "LICENSE");

export default site;
