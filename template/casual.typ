#import "@preview/cuti:0.2.1": show-cn-fakebold

/* Fonts */
#let font = (
  formal: ("Times New Roman", "FangSong"),
  text: ("Bell MT", "SimSun"),
  code: ("Fira Code", "SimSun"),
  decorative: ("French Script MT", "KaiTi")
)
/* Color */
#let color = (
  text: black,
  heading: gradient.linear(black, black)
)

/* Configurations */
#let casual_text(body) = {
  show: show-cn-fakebold
  set text(size: 14pt, font: font.text)
  show emph: it => box(
    text(it),
    fill: yellow,
    outset: 3pt,
    radius: 3pt,
  )
  show strong: set text(
    weight: "bold"
  )
  set par(leading: 0.7em)
  body
}
#let casual_page(body) = {
  set page(
    paper: "a4",
    margin: (
      top: 3cm,
      bottom: 3cm,
      x: 3cm
    ),
    header: context {
      if counter(page).get().first() > 1 {
        align(
          right,
          text(
            document.title,
            font: font.formal,
            weight: "black"
          )
        )
      }
    },
    footer: context {
      if counter(page).get().first() > 1 {
        set text(font: font.formal)
        grid(
          columns: (1fr, 1fr, 1fr),
          align(left, document.author.join(" & ")),
          align(
            center,
            text(
              counter(page).display(
                "1 / 1",
                both: true,
              ),
            )
          ),
          align(right, box(width: 100%, clip: true, document.date.display())),
        )
      }
    },
  )
  body
}

#let casual_title(body) = {
  show title: it => [
    #align(
      right,
      text(
        it,
        font: font.formal,
        weight: "bold",
        size: 40pt
      )
    )
    #line(
      start: (-05%, 0pt),
      end: (105%, 0pt)
    )
    #v(0.25em)
    #text(
      size: 17pt,
      context document.author.join(" & ")
    )
    #h(1fr)
    #text(
      size: 17pt,
      context document.date.display()
    )
    #line(
      start: (-5%, 0pt),
      end: (105%, 0pt)
    )
    #set text(size: 14pt)
    #outline(
      title: none,
      indent: 0.8em
    )
    #pagebreak()
  ]
  body
}

#let casual_heading(body) = {
  set heading(numbering: "1.1")
  show heading: it => block(
    stroke: (
      bottom: 1pt
    ),
    width: 85%,
    inset: (
      left: (it.level - 3) * 10pt,
      bottom: 7pt
    ),
    outset: (
      left: -(it.level - 3)*10pt,
      right: 3cm,
      bottom: 2pt
    ),
    breakable: false,
    text(
      it,
      fill: color.heading,
      font: font.formal
    )
  )
  body
}

#let casual_math(body) = {
  show math.equation.where(block: true): it => (
    v(10pt)
      + block(
        stroke: (left: blue + 5pt),
        outset: (
          left: 20pt,
          right: 20pt,
          top: 10pt,
          bottom: 10pt,
        ),
        width: 100%,
        text(it, fill: black),
      )
      + v(10pt)
  )
  show math.equation.where(block: false): it => box(
    it
  )
  body
}

#let casual_code(body) = {
  show raw: set text(size: 12pt)
  show raw.where(block: true): it => align(
    center,
    block(
      stroke: (
        top: black + 3pt,
        bottom: black + 3pt
      ),
      width: 110%,
      {
        set text(
          font: font.code,
          size: 14pt,
          fill: rgb("#27b0ff"),
          weight: "semibold"
        )
        let lines = it.text.trim().split("\n") 
        
        grid(
          align: (center + top, left + top), 
          columns: (2em, 1fr),
          // 1. Dynamic inset handles BOTH the indentation and the top/bottom spacing
          inset: (x, y) => (
            left: if x == 1 { 10pt } else { 0pt }, 
            right: 4pt,
            top: if y == 0 { 12pt } else { 4pt },
            bottom: if y == lines.len() - 1 { 12pt } else { 4pt }
          ), 
          stroke: black,
          fill: (x, y) => {
            if x == 0 {
              black
            } else if calc.odd(y) {
              white.darken(90%)
            } else {
              black
            }
          },
          ..lines
            .enumerate()
            .map(((i, line)) => (
              box(
                text(
                  size: 12pt,
                  white.darken(10%)
                )[#i]
              ),
              grid.vline(
                stroke: white.darken(90%) + 2pt
              ),
              raw(line, lang: it.lang),
            ))
            .flatten()
        )
      },
    ),
  )
  body
}

#let casual_table(body) = {
  set table(
    fill: none,
    align: center,
    stroke: (x, y) => {
      let styles = (:)
      if y == 0 {
        styles.insert("top", black)
        styles.insert("bottom", black)
      } else if y > 1 {
        styles.insert("top", gray)
      }
      if x > 0 {
        styles.insert("left", 0.5pt + gray)
      }
      return styles
    },
  )
  body
}

#let casual(body) = {
  show: casual_text
  show: casual_page
  show: casual_title
  show: casual_heading
  show: casual_math
  show: casual_code
  show: casual_table
  body
}
