#import "@preview/linguify:0.4.2": lflib

#import "helpers.typ": translations

#let Lesson(
  number: none,
  date: datetime.today(),
  it
) = {
  context {
    set align(center)
    show heading: smallcaps
    [= #lflib._linguify(
      "lesson",
      lang: "pol",
      from: translations
    ).ok #number]

    set text(size: 10pt)
    date.display("[year]-[month]-[day]")
  }

  it

  pagebreak()
}