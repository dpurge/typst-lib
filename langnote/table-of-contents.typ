#import "@preview/linguify:0.4.2": lflib

#import "helpers.typ": translations

#let TableOfContents(
) = {
  context {
    set align(center)
    show heading: smallcaps
    [= #lflib._linguify(
      "table-of-contents",
      lang: "pol",
      from: translations
    ).ok]
  }
  pagebreak()
}