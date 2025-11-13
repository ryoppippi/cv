#import "alta-typst.typ": alta, term, skill, styled-link, icon

#alta(
  name: "Ryotaro Kimura",
  links: (
  (name: "email", link: "mailto:m.ryoppippi@gmail.com"),
  (name: "website", link: "http://ryoppippi.com", display: "ryoppippi.com"),
  (name: "github", link: "https://www.github.com/ryoppippi/", display: "@ryoppippi"),
  (name: "linkedin", link: "https://www.linkedin.com/in/ryoppippi/", display: "Ryotaro Kimura"),
),
  tagline: [Engineer specialising in Human Computer Interaction, Intelligent Machines and Web Development],
  [
  == Experience

  === AI Engineer \
  _StackOne_\
  #term[June 2025 --- Present][Remote]

  - Making unified API platforms AI-friendly for seamless integration with AI systems
  - Designing and implementing AI-optimised unified API interfaces for HR technology
  - Enhancing unified API accessibility and usability for AI applications and LLMs
  - Building intelligent middleware to bridge traditional unified APIs with modern AI frameworks

  === Open Source Developer \
  _WRTN Technologies_\
  #term[Mar 2025 --- June 2025][Remote]

  - Developing *Agent OS*: OSS for creating AI agents using TypeScript
  - Managing community and supporting users
  - Enhancing the developer experience of the project
  - Writing whitepapers and documentation
  - R&D for tool-calling and agent creation

  === Freelance Engineer \
  _Self-Employed_\
  #term[May 2023 --- Present][Remote]

  - Teaching and consulting machine learning, web development, and basic Python programming
      - Guided over *40 students*
  - Built scalable product management systems using TypeScript, React, Storybook, TailwindCSS, and AWS
  - Built B2B SaaS products using React, Next.js and Vercel
  - Engineered interactive data-visualisation tools using D3.js, SvelteKit, PostgreSQL

  === Cloudflare Engineer \
  _NOT A HOTEL Inc._\
  #term[Jan 2024 --- Mar 2024][Japan | Remote]

  - Developed AI assistant for customer services using Cloudflare Workers, GCP, OpenAI API and `React`

  === Full-Stack Engineer \
  _eightis Co., Ltd._\
  #term[July 2022 --- Aug 2023][Japan | Remote]

  - Launched and developed `SHINTAI`: a web and iOS based platform for body-alignment training
    - Web: SvelteKit, Cloudflare Workers and PostgreSQL
    - iOS app: Swift, SwiftUI and Firebase authentication
    - Machine learning: fine-tuning of pose detection model and run on CoreML
  - Collaboration work with athletes and trainers

  === *Co-Founder* and *Chief Research Officer* \
  _QuantumCore Inc._\
  #term[Oct 2018 --- June 2023][Tokyo, Japan | Remote]

  - Worked on #link("https://www.qcore.co.jp/")[`Qore`]: the core-algorithms to enhance Reservoir Computing(RC)
  - 2018 - 2019: Implement RC and data preprocessing algorithms originally written in Python to embedded devices using *C/C++*
    - Achieved *120x faster training time* compared to LSTM and enabled deployment on embedded devices, including Raspberry Pi and M5Stack.
  - 2018 - 2023: Created and presented a dozens of PoCs using RC, mainly in the field of _time-series_, _audio processing_, and _image processing_
  - 2020 - 2023: Launched, developed and operated `Sloos`: a minute-taking app for remote workers
    - Applied speaker-detection algorithm with RC to automatically generate meeting minutes
    - Built both backend and web frontend using Flask, Angular, MySQL Azure App Directory, and PAY.JP
    - Reached *over 1,000 installations* in companies across Japan
    - Won Microsoft for Startups partnership
  - 2021 - `Qore Cloud`: a web-based no-code tool for fine-tuning RC models using SvelteKit, prisma, and PostgreSQL

  == #link("https://ryoppippi.com/projects")[Projects]

  === Web Development

  I created some websites and web applications. Here are some of them:

  - #styled-link("https://ryoppippi.com")[ryoppippi.com]: My personal website. It is built using `SvelteKit`, `UnoCSS`, and custom `markdown-it` plugins. I wrote all classes by hand. I created this without any AI/LLM tools.
  - #styled-link("https://vim-jp-radio.com/")[Vim-JP Radio LP]: A landing page for a podcast presented by `vim-jp` community.
  - #styled-link("https://pr.ryoppippi.com")[pr.ryoppippi.com]: A personal page to list up my recent OSS contributions.

  === Open Source Projects

  I have started and contributed to many open source projects. Here are some of them:

  ==== AI Tools
  - #styled-link("https://github.com/ryoppippi/ccusage")[ccusage] (#icon("star")8.9k): CLI tool for analysing Claude Code token usage and costs from local JSONL files. Features include daily/monthly/session-based reports, live monitoring, real-time dashboard, model-specific tracking, and cost analysis. Built with TypeScript and designed for incredibly fast and informative insights.
  - #styled-link("https://github.com/ryoppippi/sitemcp")[SiteMCP] (#icon("star")732): Fetch an entire site and use it as an MCP Server. This tool scrapes pages from a website, converts into markdown files, cache them, and serves them as a local MCP server. It is useful when you ask LLMs to ask questions about a libraries/documentation.
  - #styled-link("https://github.com/ryoppippi/curxy")[curxy] (#icon("star")398): Simple proxy worker for using ollama in cursor. If we want to use local LLM models in cursor, we need to have a proxy between local ollama server and remote cursor server. This tool is a simple proxy worker for that.

  ==== Web Development / TypeScript Ecosystem
  - #styled-link("https://github.com/ryoppippi/unplugin-typia")[unplugin-typia] (#icon("star")79): A plugin for bundlers to use `Typia`. `Typia` is a TypeScript validation library which generates logic from TypeScript type. Before this plugin, it was hard to use `Typia` in bundlers like `Vite`, `Webpack`, and `esbuild`. This plugin made a huge impact on the `Typia` ecosystem.
  - #styled-link("https://github.com/ryoppippi/pkg-to-jsr")[pkg-to-jsr] (#icon("star")27): Zero-config tool that generates `jsr.json` from `package.json`. This tool is useful when you publish node projects into `JSR` registry.
  - #styled-link("https://github.com/ryoppippi/mirror-jsr-to-npm")[mirror-jsr-to-npm] (#icon("star")17): A tool designed to mirror packages from `JSR` to `npm`. It is useful when you want to publish your package to both `npm` and `JSR` registries.
  - #styled-link("https://github.com/ryoppippi/vim-svelte-inspector")[vim-svelte-inspector] (#icon("star")19): A plugin for Neovim and `Vim` to integrate with `Svelte Inspector` or `Vue Inspector`. When you click a component on the browser, it opens the corresponding component in your `vim`.
  - #styled-link("https://github.com/ryoppippi/sveltweet")[sveltweet] (#icon("star")8): A Svelte component for embedding tweets. JavaScript is not required, and it supports both SSR and pre-rendering. It enhances the performance of your website.


  ==== Zig
  - #styled-link("https://github.com/ryoppippi/zigcv")[zigcv] (#icon("star")140): Zig bindings for OpenCV. This project is a wrapper for OpenCV in Zig. It is a good example of how to use Zig with C++ libraries.
  - #styled-link("https://github.com/ryoppippi/nyancat.zig")[nyancat.zig] (#icon("star")23): Running `nyancat` in your terminal. Written in Zig.

  === Miscellaneous
  - #styled-link("https://www.youtube.com/watch?v=MngEJwk5KPU")["影のキャンバス- Silhouette on Canvas"] - Interactive art installation with projection mapping. Created with `kinect` and `Processing`. 

  == Publications

// spellchecker:off
  - #styled-link("https://link.springer.com/chapter/10.1007/978-3-030-22796-8_18")[Artificial Neural Networks for Realized Volatility Prediction in Cryptocurrency Time Series] ISNN 2019: Advances in Neural Networks 2019 (Full papers)
  - #styled-link("https://dl.acm.org/doi/10.1145/3356590.3356598")[An Intuitive Interface for Digital Synthesizer by Pseudo-intention Learning] Audio Mostly 2019 (Full papers)
  - #styled-link("https://dl.acm.org/doi/10.1145/3550082.3564187")[prometheus: A mobile telepresence system connecting the 1st person and 3rd person perspectives continuously] SIGGRAPH Asia 2022 (Poster)
// spellchecker:on

  == #link("https://ryoppippi.com/talks")[Talks]

  - #styled-link("https://audee.jp/voice/show/95400")[vim-jp radio \#23/\#24 (Japanese)]: Talking about academia and open source development
  - #styled-link("https://youtu.be/tBY3RxTrhkM")[Neovim for Frontend Developers: Boosting Productivity and Creativity] VimConf 2024
  - #styled-link("https://youtu.be/D8qI9zkKATM")[Neovim for Web Frontend Developers: Boosting your Dev with some plugins | Neovim Conf 2024] neovimconf.live 2024:
  - TEDxYouth\@Tokyo 2013

  == Tech Community Activities

  - #styled-link("https://vim-jp.org/")[vim-jp]: Active contributor writing technical articles and participating in community discussions
  - #styled-link("https://github.com/svelte-jp")[Svelte Japan]: Active member contributing to Svelte Tokyo meetups and community initiatives

  == Natural Languages

  - English (IELTS 6.5) 
  - Japanese (Native)

  == Education

  === Master of Applied Computer Science \
  _University of Tokyo_\
  #term[Apr 2019 --- Mar 2022][Tokyo, Japan]

  Applied Computer Science

  === Bachelor of Arts \
  _International Christian University_\
  #term[Apr 2015 --- May 2019][Tokyo, Japan]

  Information Science Major, Economics Minor \
  Dean's List #text(0.9em)[(GPA: 3.86/4)]

  === Exchange Program \
  _The University of Edinburgh_\
  #term[Sep 2017 --- May 2018][Edinburgh, UK]

  School of Informatics

  == Other Information

  === Visa Status

  Already have a work permission without restrictions in UK (*spouse visa*)

],
  )
