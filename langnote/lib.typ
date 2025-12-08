#import "@preview/linguify:0.4.2": lflib

// const colors
#let color-text = rgb("#131A28")

// const icons
#let icon-lesson = box("L")
#let icon-vocabulary = box("L")
#let icon-models = box("M")
#let icon-grammar = box("G")
#let icon-text = box("T")
#let icon-exercise = box("E")

// const variables

// helper functions

/// ---- Start of Title ----
#let __Title__(
  title: str,
  subtitle: str,
  author: str,
  version: str,
) = [
  #show title: set text(size: 17pt)
  #show title: set align(center)
  #show title: set block(below: 1.2em)

  #title

  #author

  #version
]
/// ---- End of Title ----

/// ---- Start of Contents ----
#let __Contents__(
) = {
  [= Contents]
}
/// ---- End of Contents ----

/// ---- Start of LangNote ----
#let LangNote(
  title: (:),
  author: (:),
  language: "eng",
  version: none,
  paper-size: "a5",
  text-font: ("Arial", "Tahoma"),
  // header-font: "Roboto",
  body,
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

  show: body => context {
    set document(
      title: title,
      author: author,
      // version: __version__,
    )
    body
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
    margin: (left: 10mm, right: 10mm, top: 10mm, bottom: 10mm),
    footer-descent: 0pt,
  )

  set par(
    justify: true,
  )

  __Title__(
    title: title,
    author: author,
    version: __version__,
  )

  body

  __Contents__()

}
/// ---- End of LangNote ----

/// ---- Start of Lesson ----
// #let Lesson(
//   number: none,
//   date: none,
//   abstract,
// ) = {
//   [= Lesson #number]
//   [#date \ ]
//   [#abstract]
// }
#let Lesson(
  number: int,
  date: datetime,
  it,
) = {
  [= Lesson #number]

  // datetime.today().display("[year]-[month]-[day]")
  // date.display("[year]")

  it

  [end of lesson]
}
/// ---- End of Lesson ----

#let Abstract(
  it,
) = [
  #it
]

#let Vocabulary(
  title: str,
  items: list,
) = [
  == #title
  #items
]

#let Models(
  title: str,
  items: list,
) = [
  == #title
  #items
]

#let Grammar(
  title: str,
  it,
) = [
  == #title
  #it
]

#let Text(
  title: str,
  it,
) = [
  == #title
  #it
]

#let Dialog(
  title: str,
  it,
) = [
  == #title
  #it
]

#let Exercise(
  number: str,
  it,
) = [
  == Exercise #number
  #it
]