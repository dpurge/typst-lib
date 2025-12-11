
#let Lesson(
  number: none,
  date: datetime.today(),
  it,
) = {
  context {
    set align(center)
    show heading: smallcaps
    [= Lesson #number]

    set text(size: 10pt)
    date.display("[year]-[month]-[day]")
  }

  it

  pagebreak()
}