#import "helpers.typ": section-header

#let Questions(
  title: "",
  it,
) = {
  section-header("Q", title)
  it
}
