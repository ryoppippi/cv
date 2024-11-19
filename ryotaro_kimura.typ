#import "alta-typst.typ": alta, term, skill, styled-link

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


  === Freelance Engineer \
  _Self-Employed_\
  #term[May 2023 --- Present][Remote]

  - Teaching and consulting machine learning, web development, and basic Python programming
      - Guided over *40 students*
  - Built scalable product management systems using TypeScript, React, Storybook, and TailwindCSS, hosted on AWS
  - Engineered interactive data-visualisation tools using D3.js, SvelteKit, PostgreSQL

  === Cloudflare Engineer \
  _NOT A HOTEL Inc._\
  #term[Jan 2024 --- Mar 2024][Japan | Remote]

  - Developed AI assistant for customer services using Cloudflare Workers, GCP, OpenAI API and `React`

  === Full-Stack Engineer \
  _Eightis Inc._\
  #term[July 2022 --- Aug 2023][Japan | Remote]

  - Launched and developed `Shintai`: a web and iOS based platform for body-alignment training
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
    - My _first experience_ of developing a full-stack application. Developed in a month with learning and launched the app on May 2020
    - Built both backend and web frontend using Flask, Angular, MySQL and Azure App Directory
    - Reached *over 1,000 installations* in companies across Japan
    - Won Microsoft for Startups partnership
  - 2021 - `Qore Cloud`: a web-based no-code tool for fine-tuning RC models

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

  == Publications

// spellchecker:off
  - #styled-link("https://link.springer.com/chapter/10.1007/978-3-030-22796-8_18")[Artificial Neural Networks for Realized Volatility Prediction in Cryptocurrency Time Series] ISNN 2019: Advances in Neural Networks 2019 (Full papers)
  - #styled-link("https://dl.acm.org/doi/10.1145/3356590.3356598")[An Intuitive Interface for Digital Synthesizer by Pseudo-intention Learning] Audio Mostly 2019 (Full papers)
  - #styled-link("https://dl.acm.org/doi/10.1145/3550082.3564187")[prometheus: A mobile telepresence system connecting the 1st person and 3rd person perspectives continuously] SIGGRAPH Asia 2022 (Poster)
// spellchecker:on

  == Natural Languages

  English (IELTS 6.5) / Japanese (Native)

  == #link("https://ryoppippi.com/talks")[Talks]

  - #link("https://vimconf.org/2024/#menu-time-table")[VimConf 2024]
  - #link("https://neovimconf.live/speakers/ryo")[neovimconf.live 2024]
  - TEDxYouth\@Tokyo 2013

  == Tech Community Activities

  #styled-link("https://vim-jp.org/")[vim-jp] / 
  #styled-link("https://github.com/svelte-jp")[Svelte Japan]

  == Other Information

  === Visa Status

  Already have a work permission without restrictions in UK (*spouse visa*)
],
  )
