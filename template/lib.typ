#import "@preview/linguify:0.4.2": lflib

// const colors

// const icons

// const variables

// helper functions

/// ---- Start of Template ----
#let Template(
  title: (:),
  author: (:),
  language: "eng",
  version: none,
  paper-size: "a5",
  // text-font: ("Source Sans Pro", "Source Sans 3"),
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

  show: body => context {
    set document(
      author: author,
      title: title,
      // version: __version__,
    )

    body
  }

  set text(
    // font: text-font,
    // lang: language,
    size: 11pt,
    fill: color.linear-rgb(0, 0, 0, 0),
    fallback: true,
  )

  set page(
    paper: paper-size,
    margin: (left: 10mm, right: 10mm, top: 10mm, bottom: 10mm),
    footer-descent: 0pt,
  )

  body
}
/// ---- End of Template ----
