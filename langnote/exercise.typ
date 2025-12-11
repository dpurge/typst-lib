#import "helpers.typ": section-header

#let Exercise(
  number: str,
  it,
) = {
  section-header("E", [Exercise #number])
  it
}