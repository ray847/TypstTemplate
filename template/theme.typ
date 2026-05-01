#let shared_fonts = (
  formal: ("Times New Roman", "FangSong", "Segoe UI Emoji"),
  text: ("Bell MT", "SimSun", "Segoe UI Emoji"),
  code: ("Fira Code", "SimSun"),
  // decorative: ("Lucida Calligraphy", "KaiTi"),
  // decorative: ("Lucien Schoenschriftv CAT", "KaiTi"),
  // decorative: ("Edwardian Script ITC", "KaiTi"),
  // decorative: ("Monsieur La Doulaise", "KaiTi"),
  // decorative: ("Kunstler Script", "KaiTi"),
  // decorative: ("Palace Script MT", "KaiTi"),
  decorative: ("Ballet 48pt", "KaiTi"),
)

#let shared_colors = (
  primary: rgb("#8FABD4"),
  secondary: rgb("#EFECE3"),
  third: rgb("#4A70A9"),
)

#let shared_page = (
  paper: "a4",
  margin: (
    top: 4cm,
    bottom: 2.5cm,
    x: 3cm,
  ),
)

#let shared_code = (
  text_fill: black,
  line_number_fill: rgb("#4A70A9"),
  row_fill_even: rgb("#EFECE3"),
  row_fill_odd: rgb("#EFECE3"),
  separator: white.darken(90%) + 2pt,
)

#let shared_table = (
  divider: 0.5pt + gray,
  row_rule: gray,
)

#let make_theme(
  text_size,
  text_leading,
  colors: (:),
) = (
  fonts: shared_fonts,
  colors: shared_colors + colors,
  page: shared_page,
  text: (
    size: text_size,
    leading: text_leading,
  ),
  code: shared_code,
  table: shared_table,
)

#let casual_theme = make_theme(
  12pt,
  0.65em,
)

#let formal_theme = make_theme(
  12pt,
  0.7em,
)
