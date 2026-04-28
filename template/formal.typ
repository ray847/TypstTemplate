#import "component.typ": themed_code, themed_math, themed_table, themed_text, themed_title_text
#import "theme.typ": formal_theme

#let theme = formal_theme

#let formal_text(body) = themed_text(theme, body)
#let formal_page(body) = {
  set page(
    paper: theme.page.paper,
    margin: theme.page.margin,
    header: context {
      if counter(page).get().first() > 1 {
        align(
          center,
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
        align(center, text(
          counter(page).display(
            "1 / 1",
            both: true,
          ),
        ))
      }
    },
  )
  body
}

#let formal_title(body) = {
  show title: it => [
    #align(
      center,
      context themed_title_text(theme, document.title, size: 40pt, weight: "bold"),
    )
    #v(2.5em)
    #align(center, box(
      stroke: (
        top: black,
        bottom: black,
      ),
      outset: (
        top: 10pt,
        bottom: 10pt,
      ),
      width: 110%,
      (
        text(
          size: 17pt,
          context document.author.join(" & ") + "\n" + context document.date.display(),
        )
      ),
    ))
    #v(3em)
    #set text(size: 14pt, weight: "light")
    #outline(
      title: none,
      indent: 0.8em,
    )
    #pagebreak()
  ]
  body
}

#let formal_heading(body) = {
  set heading(numbering: "1 - 1")
  show heading: it => block(
    stroke: (
      bottom: 1pt,
    ),
    width: 100%,
    inset: (
      bottom: 7pt,
    ),
    outset: (
      left: 20pt,
      right: 20pt,
      bottom: 2pt,
    ),
    breakable: false,
    align(center, text(
      it,
      font: theme.fonts.formal,
    )),
  )
  body
}

#let formal_math(body) = themed_math(body, theme)
#let formal_code(body) = themed_code(theme, body)
#let formal_table(body) = themed_table(theme, body)

#let formal(body) = {
  show: formal_text
  show: formal_page
  show: formal_title
  show: formal_heading
  show: formal_math
  show: formal_code
  show: formal_table
  body
}
