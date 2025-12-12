#import "@preview/linguify:0.4.2": lflib

#import "helpers.typ": section-header, translations

#let Exercise(
  number: str,
  it,
) = {
  section-header("E", [ #lflib._linguify("exercise", lang: "pol", from: translations).ok #number ])
  
  it
}