#import "helpers.typ": section-header, dialog-body

#let Dialog(
  title: str,
  it
) = {
  section-header("D", title)
  set terms(
    separator: h(1em),
    hanging-indent: 4em,
    spacing: 1em,
  )
  // set par.line(
  //   numbering: i => if calc.rem(i, 5) == 0 { i },
  //   number-margin: right,
  // )
  // block(stroke: (left: 4pt), inset: 1em)[
  block[
    #dialog-body(it)
  ]
}