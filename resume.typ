#set page(margin: (top: 0.5cm, bottom: 2cm, left: 0.5cm, right: 1cm))
#set text(font: ("Noto Sans", "DejaVu Sans"), 8pt)

#let big_bullets = false
#let bullets = true
#let lines = true
#let left_titles = true
#let date_parens = false

#let _date(_content) = {
  if date_parens {
    [~(#_content)]
  } else {
    h(1fr)
    _content
  }
}

#let _link(_content, _subcontent, _url, _time) = {
  if date_parens {
    link(_url)[#text(blue)[*#_content* _#_subcontent _]~]
  } else {
    link(_url)[#text(blue)[*#_content* #_subcontent]~]
  }
  _date(_time)
}

#let _nolink(_content, _subcontent, _time) = {
  if date_parens {
    [*#_content* _#_subcontent _]
  } else {
    [*#_content* #_subcontent]
  }
  _date(_time)
}

//ITEMS

#let _item_bullets(_title, _contents) = {
  if bullets and big_bullets {
    list(_title, indent: 0pt)
  } else {
    _title
  }
  for _one_subitem in _contents {
    list(_one_subitem, indent: 10pt)
  }
  if _contents.len() == 0 and not big_bullets [\ ]
}

#let _subitem_nobullets(_content) = {
  [#h(10pt) #_content]
}

#let _item_nobullets(_title, _contents) = {
  [
    #_title
  ]
  if _contents.len() != 0 {
    [\ ]
  }
  _contents.map(_subitem_nobullets).join([\ ])
}

#let _item(_title, _contents) = {
  if bullets {
    _item_bullets(_title, _contents)
  } else {
    _item_nobullets(_title, _contents)
  }
}

//BLOCK

#let _block_left_title(_title, _items, _join) = {
  grid(columns: (1fr, 7fr),
    smallcaps[
      == #_title
    ],
    [
      #set par(justify: true)
      #set enum(spacing: 12pt)
      #_items.join(_join)
    ]
  )
}

#let _block_top_title(_title, _items, _join) = [
  = #smallcaps[#_title]\
  #set par(justify: true)
  #set enum(spacing: 12pt)
  #line(length: 100%, stroke: 0.5pt)
  #_items.join(_join)
]

#let _block_joined(_title, _items, _join) = {
  if left_titles {
    _block_left_title(_title, _items, _join)
  } else {
    _block_top_title(_title, _items, _join)
  }
}

#let _block(_title, _items) = {
  if bullets {
    _block_joined(_title, _items, [])
  } else {
    _block_joined(_title, _items, [\ ])
  }
}

//RESUME

#let _resume_space(_name, _ghlink, _email, _phone, _blocks) = {
  grid(columns: (1fr, 1fr),
    smallcaps[
      #text(size: 32pt)[*#_name*]
    ],
    smallcaps[
      #h(1fr) #link(_ghlink)[#text(blue)[*Github*]]\
      #h(1fr) #_phone\
      #h(1fr) #_email
    ]
  )
}

#let _resume_nospace(_name, _ghlink, _email, _phone, _blocks) = {
  grid(columns: (1fr, 1fr),
    smallcaps[
      #text(size: 32pt)[*#_name*]
    ],
    smallcaps[
      #h(1fr) #link(_ghlink)[#text(blue)[*Github*]]\
      #h(1fr) #_phone\
      #h(1fr) #_email
    ]
  )
}

#let _all_blocks_nolines(_blocks) = {
  if _blocks.len() != 0 and left_titles [\ ]
  if left_titles {
    _blocks.join([\ ])
  } else {
    _blocks.join([])
  }
}

#let _all_blocks_lines(_blocks) = {
  if _blocks.len() != 0 {
    line(length: 100%, stroke: 1pt)
  }
  _blocks.join(line(length: 100%, stroke: 0.2pt))
}

#let _resume(_name, _ghlink, _email, _phone, _blocks) = {  
  if bullets {
    _resume_nospace(_name, _ghlink, _email, _phone, _blocks)
  } else {
    _resume_space(_name, _ghlink, _email, _phone, _blocks)
  }
  if lines {
    _all_blocks_lines(_blocks) 
  } else {
    _all_blocks_nolines(_blocks) 
  }
}






#_resume(
  [Robert Morelli],
  "https://github.com/robertmorelli",
  [robertondino\@outlook.com],
  [385 315 0034],
  (
    _block([Education],
      (
        _item(
          _nolink(
            [B.S. Computer Science],
            [University of Utah],
            [2022 - 2027 _expected_]
          ),
          ()
        ),
        _item(
          _nolink(
            [A.S. Computer Science (incomplete)],
            [SLCC],
            [2019 - 2022 _transferred_]
          ),
          ()
        ),
      )
    ),
    _block([Technology],
      (
        _item(
          _nolink(
            [Comfortable Languages],
            [],
            []
          ),
          (
            [Python, C,  Zig, Dart, JS, TS, WASM (WAT), Java, C\#],
          )
        ),
        _item(
          _nolink(
            [Familiar Languages],
            [],
            []
          ),
          (
            [Ruby, C++, Rust, Swift, Metal, OpenCL, Typst, F\#, x86 assembly, MIPS assembly, PHP, Bash],
          )
        ),
        _item(
          _nolink(
            [Misc],
            [],
            []
          ),
          (
            [Flutter, Angular, Laravel, cicd/github actions/circleCi, css, html/svg, mongoDB, Cordova],
          )
        ),
      )
    ),
    _block([Experience],
      (
        _item(
          _nolink(
            [Research Assistant],
            [University of Utah],
            [Nov 2025 - present]
          ),
          (
            [Benchmarking gradual typing in Meta's Cinder variant of python],
          )
        ),
        _item(
          _nolink(
            [Teaching Assistant],
            [University of Utah],
            [Apr 2025 - present]
          ),
          (
            [Leading labs, grading, assisting students for COMP 1020],
          )
        ),
        _item(
          _nolink(
            [Software Engineer/Dev ops],
            [Stutor Inc.],
            [Sep 2023 - Apr 2024]
          ),
          (
            [Architected CICD pipeline],
            [Optimized DB indexes, reducing query times by up to 8x],
          )
        ),
        _item(
          _nolink(
            [Web Developer/Dev Ops],
            [Jerran Software Solutions],
            [Apr 2022 - Sep 2023]
          ),
          (
            [Overhauled LDS MTC QA/CICD workflow, substantially reducing regression burden],
            [Rewrote Embark app startup to reduce first time loading by up to 50% for users with poor internet]
          )
        ),
        _item(
          _nolink(
            [Research Assistant Intern],
            [Earl Keefe PhD],
            [Nov 2020 - Jun 2021]
          ),
          (
            [Visualizations for anthropology research],
          )
        ),
        _item(
          _nolink(
            [Web Dev. Intern],
            [Frelii],
            [May 2019 - Sep 2019]
          ),
          (
            [Web scraping SNPedia for AI training],
          )
        ),
      )
    ),
    _block([Projects],
      (
        _item(
          _link(
            [Optimized bead/gravity sort],
            [zig],
            "https://github.com/robertmorelli/bead-sort-u5x32"
            ,[2026]
          ),
          (
            [Bead sort done via popcount intrinsics and bit matrix transpositions. Only for 32 u5s],
          )
        ),
        _item(
          _link(
            [Tiny nkey rollover tester OS],
            [zig],
            "https://github.com/robertmorelli/TinyNKRO.OS",
            [2025]
          ),
          (
            [Ported as OS class assignment to zig and then added keyboard input and vga output],
          )
        ),
        _item(
          _link(
            [Fast approximate change of base],
            [python],
            "https://github.com/robertmorelli/messy_print",
            [2025]
          ),
          (
            [Novel algorithm for printing numbers larger than $10^(10^5)$ efficiently],
          )
        ),
        _item(
          _link(
            [Automated resume],
            [typst],
            "https://robertmorelli.github.io/typst-resume/",
            [2025]
          ),
          (
            [CICD typst resume],
          )
        ),
        _item(
          _link(
            [Held-karp],
            [zig],
            "https://github.com/robertmorelli/held-karp",
            [2025]
          ),
          (
            [Well optimized bitset based Held-karp TSP algorithm],
          )
        ),
        _item(
          _link(
            [Spreadsheet formulas to DLL compiler],
            [c],
            "https://github.com/robertmorelli/dll-compiler",
            [2025]
          ),
          (
            [A spreadsheet which compiles formulas to a DLL which can be used in DOTNET projects],
          )
        ),
        _item(
          _link(
            [Color alchemy],
            [qt c++],
            "https://robertmorelli.github.io/color-alchemy/",
            [2024]
          ),
          (
            [A game for learning color mixing],
          )
        ),
        _item(
          _link(
            [CSS grid examples],
            [css html],
            "https://robertmorelli.github.io/grid-examples/",
            [2024]
          ),
          (
            [Examples of common design patterns implemented with css grid as a good reference],
          )
        ),
        _item(
          _link(
            [Randomized Pacman game],
            [java],
            "https://github.com/robertmorelli/randomized-pacman",
            [2021]
          ),
          (
            [Pacman game using some algorithms from my 2420 class: A\*, DFS, BFS, Union find],
          )
        )
      ),
    ),
    _block([Misc],
      (
        
        _item(
          _link(
            [Added code field to instruction decoder],
            [MARS IDE],
            "https://github.com/dpetersanderson/MARS",
            [2025]
          ),
          (),
        ),
        _item(
          _link(
            [\#12 Ranked team at Rocky Mountain Regional Contest],
            [ICPC],
            "https://rmc25.kattis.com/contests/rmc25/standings/site",
            [2025]
          ),
          (),
        ),
        // _item(
        //   _link(
        //     [\#1 Ranked U of U Among U of U affiliated teams at ICPC North America Qualifier],
        //     [ICPC],
        //     "https://naq25.kattis.com/contests/naq25/standings/affiliation/University%20of%20Utah",
        //     [2025]
        //   ),
        //   (),
        // ),
        _item(
          _nolink(
            [Jane Street Leaderboard],
            [],
            []
          ),
          (
            _link(
              [Number Cross 5],
              [],
              "https://www.janestreet.com/puzzles/number-cross-5-solution/",
              [May 2025]
            ),
            _link(
              [Sum One, Somewhere],
              [],
              "https://www.janestreet.com/puzzles/sum-one-somewhere-solution/",
              [Apr 2025]
            ),
          )
        ),
      )
    ),
  )
)
