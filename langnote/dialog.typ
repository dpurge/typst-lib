#import "helpers.typ": section-header

#let Dialog(
  title: str,
  it
) = {
  section-header("D", title)
  it
}