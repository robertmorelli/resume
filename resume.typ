#let _navy_blue = rgb("#001f8f")

#let _big_bullets = false
#let _bullets = true
#let _lines = true
#let _top_line = false
#let _left_titles = false
#let _date_parens = false
#let _line_above = false
#let _centered_header = false
#let _no_links = false
#let _base_font_size = 9pt
#let _density = 0.7768
#let _diff = 1.251
#let _heading_diff = 1.5 // section heading size relative to base
#let _body_weight = 600
#let _stacked_header = true // compact header: name left, contact details right
#let _name_size = 20pt
#let _stack_dates = false // true: dates in their own narrow right column, two lines tall
#let _date_col = 69pt // widest stacked line, "to Sep 2023", is ~68pt at 9pt
#let _gutter = 12pt // clear air between a bullet and its date
#let _inline_date_col = 116pt // widest one-line date, "Sep 2025 – May 2026"; bullets stop short of it
#let _use_link_symbol = true
#let _use_link_symbol_for_header = true
#let _block_body_indentation = 0
#let _dark_mode = false
#let _subtitles_italic = true
#let _subtitles_underlined = false
#let _subtitles_seperated = true
#let _right_aligned_italic = true
#let _subtitle_seperator = "|"//"▪"//▒ ► ● | → ❯i ▪⑇⑊ ◆
#let _subtitle_wrap = ("[", "]") // wraps the italic subtitle; ("(", ")") etc
#let _link_symbol = "↗" //"🔗" ↗
#let _frills = false
#let _inline_lines = true

#let _black = rgb("#151515")
#let _darkmode_white = rgb("#eee")



#let _link_color = if _dark_mode {
  // rgb("#eae")
  rgb("#FFF")
} else {
  // _navy_blue
  // rgb("#0bb")
  // rgb("#00cdb8")
  rgb("#000")
}

#let _rule_color = if _dark_mode { rgb("#eee") } else { rgb("#151515") } // full contrast: hard edges

#let _block_title_color = if _dark_mode {
  _darkmode_white
} else {
  _black
}
#let _page_background = if _dark_mode {
  _black
} else {
  white
}

#let _text_color = if _dark_mode {
  _darkmode_white
} else {
  _black
}

#set page(
  margin: (
    top: 0.8cm,
    bottom: 0.7cm,
    left: 0.6cm,
    right: 0.6cm,
  ),
  fill: _page_background,
  background: if _frills {
    rect(
      fill: tiling(
        size: (10pt, 10pt),
        text(
          _link_color.transparentize(
            if _dark_mode {
              99.8%
            } else {
              98%
            },
          ),
          size: 20pt,
        )[░],
      ),
      width: 100%,
      height: 100%,
    )
  } else {},
)
#let _double_offset = 0.005em
#let _shadow_text(_text) = {
  if _frills {
    block[
      #place(top + left, block(inset: (left: _double_offset, top: _double_offset))[
        #text(
          // _text_color
          //   .mix(_link_color)
          //   .mix(_link_color)
          //   .mix(_link_color)
          //   .transparentize(10%)
          rgb("#F0F"),
        )[
          #_text
        ]
      ])
      #place(top + left, block(inset: (left: -_double_offset, top: -_double_offset))[
        #text(
          // _text_color
          // .mix(_link_color)
          // .mix(_link_color)
          // .mix(_link_color)
          // .transparentize(10%)
          // red
          rgb("#0F0"),
        )[
          #_text
        ]
      ])
      #place(top + left, text(_text_color)[#_text])
    ]
  } else {
    _text
  }
}

#set text(
  _text_color,
  font: "Cartograph CF",
  weight: _body_weight,
  _base_font_size,
)
// bold = font's heaviest weight, so titles never fall below a heavy body
#show strong: it => text(weight: 900, it.body)
#set par(
  leading: _base_font_size * _density,
  spacing: _base_font_size * _density,
)
#let _item_font_size = _base_font_size * _diff
#let _block_header_font_size = _base_font_size * _heading_diff

#let _date(_content) = {
  if _date_parens and _content != [] {
    [~(#_content)]
  } else if _stack_dates {
    if _content != [] {
      place(top + right, block(width: _date_col, align(right, if _right_aligned_italic { emph(_content) } else {
        _content
      })))
    }
  } else {
    h(1fr)
    if _right_aligned_italic [
      _ #_content _
    ] else {
      _content
    }
  }
}

#let _span(_from, _to) = if _stack_dates [#_from\ to #_to] else [#_from – #_to]

#let _subtitles(_subcontent) = {
  if _subtitles_italic and _subcontent != [] [
    #emph[#_subtitle_wrap.at(0)#_subcontent#_subtitle_wrap.at(1)]
  ] else if _subtitles_underlined [
    #underline(_subcontent)
  ] else if _subtitles_seperated and _subcontent != [] [
    #_subtitle_seperator #_subcontent #_subtitle_seperator
  ] else [
    #_subcontent
  ]
}

#let _true_link(_content, _subcontent, _url, _time) = {
  [
    #link(_url)[
      *#_content*
      // #h(_base_font_size / 2)
      #_subtitles(_subcontent)
      #if _use_link_symbol {
        text(_link_color, weight: "black", _link_symbol)
      }
    ]
  ]
  _date(_time)
}

#let _nolink(_content, _subcontent, _time) = {
  _shadow_text([
    *#_content*
    // #h(_base_font_size / 2)
    #_subtitles(_subcontent)
    #_date(_time)
  ])
}

#let _sublink(_content, _url) = {
  link(_url)[#_content #text(_link_color, weight: "black", _link_symbol)]
}

#let _link(_content, _subcontent, _url, _time) = {
  if _no_links {
    _nolink(_content, _subcontent, _time)
  } else {
    _true_link(_content, _subcontent, _url, _time)
  }
}

//ITEMS
#let _item_bullets(_title, _contents) = block(width: 100%, {
  if _bullets and _big_bullets {
    list(
      text(
        size: _item_font_size,
        _title,
      ),
      indent: 0pt,
    )
  } else {
    text(size: _item_font_size, _title)
  }
  for _one_subitem in _contents {
    // dates own a right-hand column; descriptions stop short of it
    block(
      width: 100% - (if _stack_dates { _date_col } else { _inline_date_col }) - _gutter,
      list(_one_subitem, indent: _base_font_size),
    )
  }
  if _contents.len() == 0 and not _big_bullets {
    v(0pt)
  }
})

#let _subitem_no_bullets(_content) = {
  block(inset: (left: _base_font_size), width: 80%)[#_content]
}

#let _item_no_bullets(_title, _contents) = {
  text(size: _item_font_size, _title)
  if _contents.len() != 0 {
    v(0pt)
  }
  _contents.map(_subitem_no_bullets).join(v(0pt))
}

#let _item(_title, _contents) = {
  if _bullets {
    _item_bullets(_title, _contents)
  } else {
    _item_no_bullets(_title, _contents)
  }
}

//BLOCK

#let _block_left_title(_title, _items, _join) = {
  grid(
    columns: (1fr, 6fr),
    _shadow_text(
      smallcaps(
        text(
          // _block_title_color,
          size: _block_header_font_size,
          weight: "black",
          _title,
        ),
      ),
    ),
    block(
      inset: (top: _block_body_indentation / 2 * _base_font_size),
      _items.join(_join),
    ),
  )
}

#let _block_top_title(_title, _items, _join) = {
  if _lines and _line_above {
    line(length: 100%, stroke: 0.5pt + _text_color)
  }
  if _inline_lines {
    _shadow_text(
      smallcaps(
        text(
          // _block_title_color,
          size: _block_header_font_size,
          weight: "black",
          fill: _link_color,
          grid(
            columns: (auto, 10pt, 1fr),
            [
              #_title
            ],
            [],
            block(inset: (top: 0.45em))[
              #line(length: 100%, stroke: 1pt + _rule_color)
            ],
          ),
        ),
      ),
    )
  } else {
    _shadow_text(
      smallcaps(
        text(
          // _block_title_color,
          size: _block_header_font_size,
          weight: "bold",
          _title,
        ),
      ),
    )
  }
  if _lines {
    if not _line_above and not _inline_lines {
      line(length: 100%, stroke: 0.5pt + _text_color)
    }
  } else {
    v(_base_font_size * _density)
  }
  block(
    inset: (left: _block_body_indentation * _base_font_size),
    _items.join(_join),
  )
}

#let _block(_title, _items) = {
  if _left_titles {
    _block_left_title(_title, _items, v(0pt))
  } else {
    _block_top_title(_title, _items, v(_base_font_size * 0.5))
  }
}

//RESUME

#let _all_blocks_no_lines(_blocks) = {
  if _blocks.len() != 0 and _top_line and not _line_above {
    line(length: 100%, stroke: 1pt + _text_color)
  }
  if _blocks.len() != 0 and _left_titles { v(_base_font_size * _density) }
  if _left_titles {
    _blocks.join(v(_base_font_size * _density))
  } else {
    _blocks.join(v(_base_font_size * _density))
  }
}

#let _all_blocks_lines(_blocks) = {
  if _blocks.len() != 0 and _top_line and not _line_above {
    line(length: 100%, stroke: 1pt + _text_color)
  }
  if _left_titles {
    _blocks.join(line(length: 100%, stroke: 0.2pt + _text_color))
  } else {
    _blocks.join(v(_base_font_size * _density))
  }
}

#let _true_header_link(_text, _link) = {
  link(_link)[
    *#_text*
    #if _use_link_symbol_for_header {
      text(_link_color, weight: "black", _link_symbol)
    }
  ]
}

#let _no_header_link(_text, _link) = {
  link(_link)[
    *#_text*
    #if _use_link_symbol_for_header {
      _link_symbol
    }
  ]
}

#let _header_link(_text, _link) = {
  if _no_links {
    _no_header_link(_text, _link)
  } else {
    _true_header_link(_text, _link)
  }
}

#let _resume(_name, _ghlink, _email, _phone, _linkedin, _blocks) = {
  if _centered_header {
    align(center)[
      #smallcaps[
        #text(size: 18pt)[*#_name*]
        #if _no_links [
          #v(0pt) *#smallcaps[robertmorelli.GitHub.io/resume]*
        ]
      ]
    ]
    columns(3)[
      #align(left)[

        #_email
      ]
      #colbreak()
      #align(center)[
        #_header_link(_ghlink)
      ]
      #colbreak()
      #align(right)[#_phone]
    ]
  } else if _stacked_header {
    grid(
      columns: (auto, 1fr),
      align: horizon,
      smallcaps[#h(-1pt)#_shadow_text(text(size: _name_size, tracking: -0.04em, weight: 900)[#_name])],
      align(right, text(0.85em)[#_header_link(_ghlink.at(1), _ghlink.at(0)) #h(1.2em) #_header_link(
          _linkedin.at(1),
          _linkedin.at(0),
        ) #h(1.2em) #_phone #h(1.2em) #_email]),
    )
    v(_base_font_size * 0.2)
  } else {
    grid(
      columns: (auto, 1fr),
      align: top,
      smallcaps[
        #h(-1.3pt)#_shadow_text(text(size: 32pt, tracking: -0.04em, weight: 900)[#_name])
      ],
      smallcaps[
        // #if _no_links [
        //   #h(1fr) *#smallcaps[robertmorelli.GitHub.io/resume]*\
        // ]
        #h(1fr) #_header_link(_ghlink.at(1), _ghlink.at(0))\
        #h(1fr) #_header_link(_linkedin.at(1), _linkedin.at(0))\
        #h(1fr) #_phone\
        #h(1fr) #_email
      ],
    )
  }

  if _lines {
    _all_blocks_lines(_blocks)
  } else {
    _all_blocks_no_lines(_blocks)
  }
}

#_resume(
  [Robert Ondino Morelli],
  ("https://GitHub.com/robertmorelli", "GitHub: robertmorelli"),
  [robertondino\@outlook.com],
  [385-315-0034],
  ("https://www.linkedin.com/in/robert-o-morelli/", "LinkedIn: robert-o-morelli"),
  (
    _block([Education], (
      _item(
        _nolink(
          [B.S. Computer Science],
          [University of Utah],
          [May 2027],
        ),
        (),
      ),
    )),
    _block([Technical skills], (
      // [Zig, C/C++, C\#, Python, Java, TypeScript/JS, WebAssembly/WasmGC, Qt, Git, Docker, GitHub Actions, Fastlane, CI/CD],
      [Zig, C/C++, C\#, Python, Java, TS, WASM, Git, Docker, GitHub Actions, CI/CD],
    )),
    _block([Experience], (
      _item(
        _nolink(
          [Research Assistant],
          [Ben Greenman PhD, University of Utah],
          _span([Oct 2025], [Present]),
        ),
        (
          [Analyzing performance cost of gradual typing\ in Meta's Static Python (CinderX)],
          [Automatic rewriting of Python code to construct test examples],
          [First author, "Automatic Cast Insertion\ to Evaluate Progressive Gradual Types" (under review)],
        ),
      ),
      _item(
        _nolink(
          [Teaching Assistant],
          [University of Utah],
          _span([Sep 2025], [May 2026]),
        ),
        (
          [Led labs, graded, and assisted students for COMP 1020],
        ),
      ),
      _item(
        _nolink(
          [Software Engineer/DevOps],
          [Stutor Inc.],
          _span([Sep 2023], [Apr 2024]),
        ),
        (
          [Architected automation pipeline using Fastlane and GitHub Actions\ to build, sign and deploy to multiple platforms],
          [Added compound keys to tables where backend queries had drifted\ from database schema; query times reduced from 15+ s to \<1 s],
        ),
      ),
      _item(
        _nolink(
          [Web Developer/DevOps],
          [Jerran Software Solutions],
          _span([Apr 2022], [Sep 2023]),
        ),
        (
          // [Software consulting; clients included the LDS Church, Retro Game Vault and Stutor Inc.],
          [Architected, proposed and implemented overhaul of development process\ for the LDS MTC team using build automation\ in conjunction with new QA practices;\ deployment was reduced from a week-long headache to mere minutes],
          [Rewrote Embark startup using dependency-ordered queue\ for async initializations; first-time loading reduced by 50%],
        ),
      ),
      _item(
        _nolink(
          [Research Assistant],
          [Earl Keefe PhD, University of Utah],
          _span([Nov 2020], [Jun 2021]),
        ),
        (
          [Used pypng to construct novel visualizations of covariance matrices\ to provide more intuitive understanding of data],
          // [Implemented statistical formulas in clear code in order that a reviewer can be sure the results are correct and valid],
        ),
      ),
      // _item(
      // _nolink(
      // [Web Development Intern],
      // [Frelii],
      // _span([Jun 2019], [Sep 2019]),
      // ),
      // (
      // [Implemented web scraping SNPedia for AI training using Python with multiprocessing and BeautifulSoup],
      // ),
      // ),
    )),
    _block([Projects], (
      _item(
        _link(
          [IRX regex fuzzer],
          [Zig],
          "https://github.com/robertmorelli/irx",
          [],
        ),
        (
          // [The inverted regex fuzzer generates accept and reject string seeds\ and fuzzes patterns instead of inputs across \~25 engines],
          [Fuzzes patterns instead of inputs: samples regexes\ that must match one fixed string and must reject another fixed string],
        ),
      ),
      _item(
        _link(
          [UTU language and compiler],
          [JS/TS, WasmGC],
          "https://github.com/robertmorelli/utu",
          [],
        ),
        (
          // [The language AssemblyScript was meant to be: designed from the ground up to have predictable lowering to WasmGC, have small bundle size, and support .d.ts as an ABI],
          [WasmGC language with predictable lowering,\ small bundles, and .d.ts as its ABI],
        ),
      ),
      // _item(
      //   _link(
      //     [MIPS assembly extension for VS Code],
      //     [TypeScript, Java],
      //     "https://marketplace.visualstudio.com/items?itemName=robertmorelli.mips-assembly",
      //     [],
      //   ),
      //   (
      //     [LSP diagnostics, hover and go-to-definition, plus running and assembling via MARS; 300+ installs],
      //   ),
      // ),
      // _item(
      //   _link(
      //     [Beta reduction visualizer],
      //     [js html],
      //     "https://robertmorelli.GitHub.io/beta_reduction_visualizer"
      //     ,[2026]
      //   ),
      //   (
      //     [Trace argument through function application with useful highlighting],
      //   )
      // ),
      // _item(
      //   _link(
      //     [Optimized bead/gravity sort],
      //     [zig],
      //     "https://GitHub.com/robertmorelli/bead_sort_u5x32"
      //     ,[2026]
      //   ),
      //   (
      //     [Bead sort via popcount intrinsics and bit matrix transpositions for 32 u5s],
      //   )
      // ),
      // _item(
      //   _link(
      //     [Tiny nkey rollover tester OS],
      //     [zig],
      //     "https://GitHub.com/robertmorelli/TinyNKRO.OS",
      //     [2025]
      //   ),
      //   (
      //     [Ported as OS class assignment to zig, demo of keyboard in and vga out],
      //   )
      // ),
      // _item(
      //   _link(
      //     [Fast approximate change of base],
      //     [python],
      //     "https://GitHub.com/robertmorelli/messy_print",
      //     [2025]
      //   ),
      //   (
      //     [Novel algorithm for printing numbers larger than $10^(10^5)$ efficiently],
      //   )
      // ),
      // _item(
      //   _link(
      //     [Automated resume],
      //     [typst],
      //     "https://robertmorelli.GitHub.io/resume/",
      //     [2025]
      //   ),
      //   (
      //     [Automated typst resume deployed to website],
      //   )
      // ),
      // _item(
      //   _link(
      //     [Held-karp],
      //     [zig],
      //     "https://GitHub.com/robertmorelli/held_karp",
      //     [2025]
      //   ),
      //   (
      //     [Well optimized Held-karp TSP algorithm using bitsets and Gosper's hack],
      //   )
      // ),
      _item(
        _link(
          [Spreadsheet formulas to DLL compiler],
          [C\#],
          "https://GitHub.com/robertmorelli/dll_compiler",
          [],
        ),
        (
          [Compiles spreadsheet formulas into a DLL,\ supporting optimizations including fast-math style unsafe float conversion],
        ),
      ),
      // _item(
      // _link(
      // [Color alchemy],
      // [Qt/C++],
      // "https://robertmorelli.GitHub.io/color_alchemy/",
      // [],
      // ),
      // (
      // [Beautiful game for learning color mixing, properly using OKLab color space for gradient construction and scoring],
      // ),
      // ),
      // _item(
      //   _link(
      //     [CSS grid examples],
      //     [css html],
      //     "https://robertmorelli.GitHub.io/grid_examples/",
      //     [2024]
      //   ),
      //   (
      //     [Reference for common design patterns that should be implemented with css grid],
      //   )
      // ),
      // _item(
      //   _link(
      //     [Randomized Pacman game],
      //     [Java],
      //     "https://GitHub.com/robertmorelli/randomized_pacman",
      //     [],
      //   ),
      //   (
      //     [Pacman game using some algorithms from my 2420 class: A\*, DFS, BFS, Union find],
      //   ),
      // ),
      // _item(
      //   _link(
      //     [SVG Animator],
      //     [HTML/JS/CSS, SVG + SMIL],
      //     "https://robertmorelli.GitHub.io/svg_animator/",
      //     [],
      //   ),
      //   (
      //     [Svg animator inspired by ms paint. Animations can be made with one click and no prior experience animating],
      //   ),
      // ),
    )),
    _block([Open source & competitions], (
      _item(
        _link(
          [Contributed to open-source IDE code-base],
          [MARS],
          "https://GitHub.com/dpetersanderson/MARS",
          [],
        ),
        (
          [Discovered and corrected oversight in the MARS IDE's instruction decoder\ that affected correctness of self-modifying code],
        ),
      ),
      _item(
        _nolink(
          [CinderX bug hunting],
          [CinderX],
          [],
        ),
        (
          [Reported 11 bugs in CinderX and contributed 2 fixes to the type-checker],
        ),
      ),
      _item(
        _nolink(
          [Regex bug hunting],
          [],
          [],
        ),
        (
          // [Reported 46 correctness bugs across a wide variety\ of regular expression engines including Perl, .NET and V8],
          [Reported 86 correctness bugs across a wide variety\ of regular expression engines including Perl, .NET and V8],
        ),
      ),
      _item(
        _link(
          [Competitive programming],
          [ICPC],
          "https://rmc25.kattis.com/contests/rmc25/standings/site",
          [],
        ),
        (
          [As part of team "Big Cottonwood Coders",\ placed 12 out of 48 teams at the Rocky Mountain regional contest (2025)],
          [As Event Coordinator of the U of U technical coding club,\ organized and oversaw competitions (2026)],
        ),
      ),
      // _item(
      // _nolink(
      // [Jane Street leaderboard],
      // [],
      // [],
      // ),
      // (
      // _sublink([Number Cross 5], "https://www.janestreet.com/puzzles/number-cross-5-solution/"),
      // _sublink([Sum One, Somewhere], "https://www.janestreet.com/puzzles/sum-one-somewhere-solution/"),
      // ),
      // ),
    )),
  ),
)
