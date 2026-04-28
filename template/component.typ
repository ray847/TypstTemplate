#import "@preview/cuti:0.2.1": show-cn-fakebold
#import "@preview/zebraw:0.6.1": *
#import "@preview/typixel:0.1.1": *

#let themed_text(theme, body) = {
  show: show-cn-fakebold
  set text(size: theme.text.size, font: theme.fonts.text)
  show emph: it => box(
    text(it),
    fill: yellow,
    outset: 3pt,
    radius: 3pt,
  )
  show strong: set text(weight: "bold")
  set par(leading: theme.text.leading)
  body
}

#let themed_math(body, theme) = {
  show math.equation.where(block: true): it => (
    v(10pt)
      + block(
        stroke: (left: theme.colors.third + 5pt),
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
  show math.equation.where(block: false): it => box(it)
  body
}

#let themed_code(theme, body) = {
  show raw.where(block: true): set text(
    size: 12pt,
    font: theme.fonts.code,
    fill: theme.code.text_fill,
    weight: "semibold",
  )
  show raw.where(block: true): zebraw.with(
    lang: false,
    numbering-separator: true,
    numbering-offset: -1,
    numbering-font-args: (
      font: theme.fonts.code,
      size: 12pt,
      fill: theme.code.line_number_fill,
      weight: "semibold",
    ),
    background-color: (
      theme.code.row_fill_even,
      theme.code.row_fill_odd,
    ),
    highlight-color: theme.colors.primary,
    radius: 0pt,
  )
  body
}

#let themed_table(theme, body) = {
  set table(
    fill: none,
    align: center,
    stroke: (x, y) => {
      let styles = (:)
      if y == 0 {
        styles.insert("top", black)
        styles.insert("bottom", black)
      } else if y > 1 {
        styles.insert("top", theme.table.row_rule)
      }
      if x > 0 {
        styles.insert("left", theme.table.divider)
      }
      styles
    },
  )
  body
}

#let title_parts(title) = {
  let clusters = title.text.clusters()
  (
    first: clusters.at(0, default: ""),
    rest: clusters.slice(1).join(),
  )
}

#let mesh_fill(color, grain) = tiling()[
  #grid(
    columns: 2,
    square(
      stroke: none,
      fill: color,
      size: grain,
    ),
    square(
      stroke: none,
      fill: none,
      size: grain,
    ),

    square(
      stroke: none,
      fill: none,
      size: grain,
    ),
    square(
      stroke: none,
      fill: color,
      size: grain,
    ),
  )
]

#let themed_title_text(
  theme,
  title,
  size: 40pt,
  weight: "bold",
  font: auto,
) = {
  let parts = title_parts(title)
  let title_font = if font == auto { theme.fonts.formal } else { font }
  let decorative_font = if font == auto { theme.fonts.decorative } else { font }

  text(
    font: title_font,
    size: size,
    weight: weight,
  )[
    #box(
      fill: theme.colors.third,
      outset: (
        right: 15pt,
        bottom: 12pt,
      ),
      text(
        size: size * 2,
        fill: white,
        font: decorative_font,
        weight: "black",
      )[#parts.first]
        + h(5pt),
    )
    #parts.rest
  ]
}
