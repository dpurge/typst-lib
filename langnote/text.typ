#import "helpers.typ": section-header

#let Text(
  title: "",
  it
) = {
  section-header("T", title)

  set par.line(
    numbering: i => if calc.rem(i, 5) == 0 { i },
    numbering-scope: "page",
    number-margin: right,
  )

  it
}