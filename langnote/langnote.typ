#import "colors.typ": color-text

#let LangNote(
  title: (:),
  author: (:),
  language: "eng",
  version: none,
  paper-size: "a5",
  text-font: ("Arial", "Tahoma"),
  // header-font: "Roboto",
  it,
) = {
  let lang_data = toml("lang.toml")

  let __version__ = if version == none {
    (
      datetime.today().display("[year]-[month]-[day]")
    )
  } else {
    version
  }

  let __lang__ = "en"

  set document(
    title: title,
    author: author,
    description: [],
    keywords: (),
    date: datetime.today()
  )

  show: it => context {
    let version2 = "test-version"
    it
  }

  set text(
    font: text-font,
    lang: __lang__,
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