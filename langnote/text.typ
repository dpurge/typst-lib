#import "helpers.typ": section-header

#let Text(
  title: "",
  it
) = {
  section-header("T", title)
  it
}