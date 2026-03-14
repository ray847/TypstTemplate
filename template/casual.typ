/* Fonts */
#let font = (
  formal: "Times New Roman",
  text: "Bell MT",
  decorative: "French Script MT"
)
/* Color */
#let color = (
  text: black,
  heading: gradient.linear(black, black)
)

/* Configurations */
#let casual_text(body) = {
  set text(size: 14pt, font: font.text)
  show strong: set text(rgb(170, 0, 0))
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
    text(it, fill: color.heading)
  )
  body
}

#let casual(body) = {
  show: casual_text
  show: casual_page
  show: casual_title
  show: casual_heading
  body
}
