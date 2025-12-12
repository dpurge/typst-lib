#import "colors.typ": color-text

#let LangNote(
  title: (:),
  author: (:),
  version: none,
  paper-size: "a5",
  native-lang: "eng",
  native-script: "latn",
  foreign-lang: none,
  foreign-script: "latn",
  it
) = {
  // let __lang__ = "en"

  set document(
    title: title,
    author: author,
    description: [],
    keywords: (),
    date: datetime.today()
  )

  show: it => context {
    let lesson-nr = counter("lesson-nr")
    // let lesson-nr = counter("lesson-nr")
    let version2 = "test-version"
    it
  }

  set text(
    font: ("Arial", "Tahoma"),
    lang: "en",
    size: 12pt,
    fill: color-text,
    fallback: true,
  )

  set page(
    paper: paper-size,
    margin: (
      left: 15mm,
      right: 15mm,
      top: 15mm,
      bottom: 15mm,
    ),
    footer-descent: 0pt,
    numbering: "1",
  )

  set par(
    justify: true,
  )

  it
}