#let themed_math(
  theme,
  body,
  block-width: 105%,
  block-stroke: (left: 5pt),
  block-fill: black,
) = {
  show math.equation.where(block: true): it => box(
    width: block-width,
    stroke: block-stroke,
    text(
      it,
      size: theme.sizes.math,
      font: theme.type.math.font,
      weight: theme.type.math.weight,
      style: theme.type.math.style,
      fill: block-fill,
    ),
  )
  show math.equation.where(block: false): it => box(text(
    it,
    size: theme.sizes.math,
    font: theme.type.math.font,
    weight: theme.type.math.weight,
    style: theme.type.math.style,
  ))
  body
}
