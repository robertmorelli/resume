#let _navy_blue = rgb("#001f8f")

#let _big_bullets = false
#let _bullets = false
#let _lines = true
#let _top_line = true
#let _left_titles = true
#let _date_parens = false
#let _line_above = false
#let _centered_header = false
#let _no_links = false
#let _base_font_size = 8pt
#let _density = 1.4
#let _diff = 1.1
#let _use_link_symbol = true
#let _use_link_symbol_for_header = true
#let _block_body_indentation = 0
#let _dark_mode = true
#let _subtitles_italic = false
#let _subtitles_underlined = false
#let _subtitles_separated = true
#let _right_aligned_italic = true
#let _subtitle_separator = "▪"//▒ ► ● | → ❯i ▪⑇⑊ ◆
#let _link_symbol = "↗" //"🔗" ↗
#let _frills = false
#let _hide_dates = true

#let _black = rgb("#151515")
#let _darkmode_white = rgb("#eee")



#let _link_color = if _dark_mode {
  rgb("#eae")
} else {
  // _navy_blue
  rgb("#0bb")
}

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
    top: 0.6cm,
    bottom: 0.6cm,
    left: 0.6cm,
    right: 0.6cm
  ),
  fill: _page_background,
  background:
    if _frills {
      rect(
        fill: tiling(
          size: (10pt, 10pt),
          text(
            _link_color.transparentize(
              if _dark_mode {
                99.8%
              } else {
                98%
              }
            ),
            size: 20pt,
          )[░]
        ),
        width: 100%,
        height: 100%
      )
    } else {
    }
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
          rgb("#F0F")
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
            rgb("#0F0")
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
  weight: 600,
  _base_font_size,
)
#set par(
  leading: _base_font_size * _density,
  spacing: _base_font_size * _density
)
#let _item_font_size = _base_font_size * _diff
#let _block_header_font_size = _item_font_size * _diff

#let _date(_content) = {
  if _date_parens and _content != [] {
    [~(#_content)]
  } else {
    h(1fr)
    if _right_aligned_italic [
      _ #_content _
    ] else {
      _content
    }
  }
}

#let _subtitles(_subcontent) = {
  if _subtitles_italic [
    #emph(_subcontent)
  ] else if _subtitles_underlined [
    #underline(_subcontent)
  ] else if _subtitles_separated and _subcontent != [] [
    #_subtitle_separator #_subcontent
  ] else [
    #_subcontent
  ]
}

#let _true_link(_content, _subcontent, _url, _time) = {
  [
    #link(_url)[
      #text(_link_color)[
        *#_content*
        // #h(_base_font_size / 2)
        #_subtitles(_subcontent)
        #if _use_link_symbol {
          _link_symbol
        }
      ]
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

#let _link(_content, _subcontent, _url, _time) = {
  if _no_links {
    _nolink(_content, _subcontent, _time)
  } else {
    _true_link(_content, _subcontent, _url, _time)
  }
}

//ITEMS
#let _item_bullets(_title, _contents) = {
  if _bullets and _big_bullets {
    list(
      text(
        size: _item_font_size,
        _title
      ),
      indent: 0pt,
    )
  } else {
    text(size: _item_font_size, _title)
  }
  for _one_subitem in _contents {
    list(_one_subitem, indent: _base_font_size)
  }
  if _contents.len() == 0 and not _big_bullets {
    v(0pt)
  }
}

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
  grid(columns: (1fr, 6fr),
    _shadow_text(
      smallcaps(
        text(
          // _block_title_color,
          size: _block_header_font_size,
          weight: "black",
          _title,
        )
      )
    ),
    block(
      inset: (top: _block_body_indentation/ 2 * _base_font_size),
      _items.join(_join)
    )
  )
}

#let _block_top_title(_title, _items, _join) = {
  if _lines and _line_above {
    line(length: 100%, stroke: 0.5pt + _text_color)
  }
  _shadow_text(
    smallcaps(
      text(
        // _block_title_color,
        size: _block_header_font_size,
        weight: "black",
        _title,
      )
    )
  )
  if _lines {
    if not _line_above {
      line(length: 100%, stroke: 0.5pt + _text_color)
    }
  } else {
    v(_base_font_size * _density)
  }
  block(
      inset: (left: _block_body_indentation * _base_font_size),
      _items.join(_join)
  )
}

#let _block(_title, _items) = {
  if _left_titles {
    _block_left_title(_title, _items, v(0pt))
  } else {
    _block_top_title(_title, _items, v(0pt))
  }
}

#let _grid_item(_title, _url) = {}
#let _grid_link(_title, _url) = {}

#let _grid_left_title(_title, _items, _join, _cols) = {}
#let _grid_top_title(_title, _items, _join, _cols) = {}

#let _grid(_title, _grid_items, _cols) = {
  if _left_titles {
    _grid_left_title(_title, _items, v(0pt))
  } else {
    _grid_top_title(_title, _items, v(0pt))
  }
}

//RESUME

#let _all_blocks_no_lines(_blocks) = {
  if _blocks.len() != 0 and _top_line and not _line_above {
    line(length: 100%, stroke: 1pt + _text_color)
  }
  if _blocks.len() != 0 and _left_titles {v(_base_font_size * _density)}
  if _left_titles {
      _blocks.join(v(_base_font_size * _density))
  } else {
    _blocks.join(v(_base_font_size * _density))
  }
}

#let _all_blocks_lines(_blocks) = {
  if _blocks.len() != 0 and _top_line and not _line_above  {
    line(length: 100%, stroke: 1pt + _text_color)
  }
  if _left_titles {
    _blocks.join(line(length: 100%, stroke: 0.2pt + _text_color))
  } else {
    _blocks.join(v(_base_font_size * _density))
  }
}

#let _true_header_link(_ghlink) = {
  link("https://github.com/" + _ghlink)[
    #text(_link_color)[
      *github.com/#_ghlink*
      #if _use_link_symbol_for_header {
        _link_symbol
      }
    ]
  ]
}

#let _no_header_link(_ghlink) = {
  link("https://github.com/" + _ghlink)[
    *github.com/#_ghlink*
    #if _use_link_symbol_for_header {
      _link_symbol
    }
  ]
}

#let _header_link(_ghlink) = {
  if _no_links {
    _no_header_link(_ghlink)
  } else {
    _true_header_link(_ghlink)
  }
}

#let _resume(_name, _ghlink, _email, _phone, _blocks) = {  
  if _centered_header {
    align(center)[
      #smallcaps[
        #text(size: 18pt)[*#_name*]
        #if _no_links [
          #v(0pt) *#smallcaps[robertmorelli.github.io/resume]*
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
  } else {
    grid(columns: (1fr, 1fr),
      smallcaps[
        #_shadow_text(text(size: 30pt)[*#_name*])
      ],
      smallcaps[
        #if _no_links [
          #h(1fr) *#smallcaps[robertmorelli.github.io/resume]*\
        ]
        #h(1fr) #_header_link(_ghlink)\
        #h(1fr) #_phone\
        #h(1fr) #_email
      ]
    )
  }
  
  if _lines {
    _all_blocks_lines(_blocks) 
  } else {
    _all_blocks_no_lines(_blocks) 
  }
}

#_resume(
  [Robert Morelli],
  "robertmorelli",
  [robertondino\@outlook.com],
  [385 315 0034],
  (
    _block([Education],
      (
        _item(
          _nolink(
            [B.S. Computer Science],
            [University of Utah],
            [expected may 2027]
          ),
          ()
        ),
      )
    ),
    _block([Skills],
      (
        _item(
          _nolink(
            [Proficient],
            [],
            []
          ),
          (
            [Dart, JS, CSS, SVG, HTML, Java, Python, TS, Typst, GitHub Actions, Zig],
          )
        ),
        _item(
          _nolink(
            [Familiar],
            [],
            []
          ),
          (
            [Angular, Bash, C, C\#, Cordova, C++, CI/CD, CircleCI, Flutter, MongoDB, Rust, Swift],
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
            [current]
          ),
          (
            [Benchmarking gradual typing in Meta's Cinder variant of Python],
          )
        ),
        _item(
          _nolink(
            [Teaching Assistant],
            [University of Utah],
            [current]
          ),
          ()
        ),
        _item(
          _nolink(
            [Software Engineer/DevOps],
            [Stutor Inc.],
            []
          ),
          (
            [Architected automation pipeline],
            [Optimized DB indexes, reducing query times by up to 8x],
          )
        ),
        _item(
          _nolink(
            [Web Developer/DevOps],
            [Jerran Software Solutions],
            []
          ),
          (
            [Overhauled LDS MTC QA/CICD workflow, substantially reducing regression burden],
            [Rewrote Embark app startup to reduce first-time loading by up to 50%]
          )
        ),
        _item(
          _nolink(
            [Research Assistant Intern],
            [Earl Keefe PhD/University of Utah],
            []
          ),
          ()
        ),
        _item(
          _nolink(
            [Web Development Intern],
            [Frelii],
            []
          ),
          ()
        ),
      )
    ),
    _block([Projects],
      (
        _item(
          _link(
            [Spreadsheet DLL compiler],
            [c\#],
            "https://github.com/robertmorelli/dll_compiler",
            []
          ),
          (
            [Compiles formulas in a spreadsheet into a DLL],
          )
        ),
        _item(
          _link(
            [Color alchemy],
            [qt c++],
            "https://robertmorelli.github.io/color_alchemy/",
            []
          ),
          (
            [Beautiful game for learning color mixing, properly using oklab color space],
          )
        ),
        _item(
          _link(
            [English language trie],
            [zig wasm],
            "https://robertmorelli.github.io/english"
            ,[]
          ),
          (
            [Dictionary of 236k words embedded into a 4 MB wasm trie for easy autocomplete],
          )
        ),
        _item(
          _link(
            [Web VS Code typst extension],
            [rust ts],
            "https://marketplace.visualstudio.com/items?itemName=robertmorelli.megamist-typst"
            ,[]
          ),
          ()
        ),
        _item(
          _link(
            [Lambda calculus beta reduction visualizer],
            [js html],
            "https://robertmorelli.github.io/beta_reduction_visualizer"
            ,[]
          ),
          ()
        ),
        _item(
          _link(
            [Matrix transpose bead/gravity sort],
            [zig],
            "https://github.com/robertmorelli/bead_sort_u5x32"
            ,[]
          ),
          ()
        ),
        _item(
          _link(
            [Tiny nkey rollover tester kernel],
            [zig],
            "https://github.com/robertmorelli/TinyNKRO.OS",
            []
          ),
          ()
        ),
        _item(
          _link(
            [Really (really) big number printer],
            [python],
            "https://github.com/robertmorelli/messy_print",
            []
          ),
          ()
        ),
        _item(
          _link(
            [Automated resume],
            [typst],
            "https://robertmorelli.github.io/resume/",
            []
          ),
          ()
        ),
        _item(
          _link(
            [Held-Karp],
            [zig],
            "https://github.com/robertmorelli/held_karp",
            []
          ),
          ()
        ),
        _item(
          _link(
            [CSS grid reference sheet],
            [css html],
            "https://robertmorelli.github.io/grid_examples/",
            []
          ),
          ()
        ),
        _item(
          _link(
            [Randomized Pacman game],
            [java],
            "https://github.com/robertmorelli/randomized_pacman",
            []
          ),
          ()
        ),
        _item(
          _link(
            [Svg Animator],
            [html js css],
            "https://robertmorelli.github.io/svg_animator/",
            []
          ),
          ()
        )
      ),
    ),
    _block([Misc],
      (
        _item(
          _nolink(
            [Event Coordinator],
            [Technical Coding Club],
            [2026]
          ),
          (),
        ),
        _item(
          _link(
            [Contributed code field to instruction decoding],
            [MARS IDE],
            "https://github.com/dpetersanderson/MARS",
            []
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
              []
            ),
            _link(
              [Sum One, Somewhere],
              [],
              "https://www.janestreet.com/puzzles/sum-one-somewhere-solution/",
              []
            ),
          )
        ),
      )
    ),
  )
)
