#import "component.typ": themed_code, themed_math, themed_table, themed_text, themed_title_text
#import "theme.typ": casual_theme

#let theme = casual_theme

#let casual_text(body) = themed_text(theme, body)
#let casual_page(body) = {
  set page(
    paper: theme.page.paper,
    margin: theme.page.margin,
    header: context {
      if counter(page).get().first() > 1 {
        align(
          right,
          text(
            document.title,
            font: theme.fonts.formal,
            weight: "black",
          ),
        )
      }
    },
    footer: context {
      if counter(page).get().first() > 1 {
        set text(font: theme.fonts.formal)
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
            ),
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
      context themed_title_text(theme, document.title, size: 40pt, weight: "black"),
    )
    #v(0.5em)
    #align(center, box(
      stroke: (top: black, bottom: black),
      outset: (top: 10pt, bottom: 10pt),
      width: 110%,
      (
        h(1em)
          + text(
            size: 17pt,
            context document.author.join(" & "),
          )
          + h(1fr)
          + text(
            size: 17pt,
            context document.date.display(),
          )
          + h(1em)
      ),
    ))
    #v(1em)
    #set text(size: 14pt, weight: "light")
    #outline(title: none, indent: 0.8em)
    #pagebreak()
  ]
  body
}

#let casual_heading(body) = {
  set heading(numbering: "1.1")
  show heading: it => block(
    stroke: (
      bottom: 1pt,
    ),
    width: 85%,
    inset: (
      left: (it.level - 3) * 10pt,
      bottom: 7pt,
    ),
    outset: (
      left: -(it.level - 3) * 10pt,
      right: 3cm,
      bottom: 2pt,
    ),
    breakable: false,
    text(
      it,
      font: theme.fonts.formal,
    ),
  )
  body
}

#let casual_math(body) = themed_math(body, theme)
#let casual_code(body) = themed_code(theme, body)
#let casual_table(body) = themed_table(theme, body)

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
