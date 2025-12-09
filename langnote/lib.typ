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

#let part(content, angle: 0deg, content_color: black) = {
  box(
    radius: 0.1em, 
    stroke: (2pt + oklch(40%, 0.2, angle, 100%)), 
    fill: oklch(95%, 0.05, angle, 80%), 
    inset: (x: 0.3em),
    outset: (y: 0.3em),
  )[#text(content_color)[#content]]
}

// const variables

// helper functions

#let to-string(it) = {
  if type(it) == str {
    it
  } else if type(it) != content {
    str(it)
  } else if it.has("text") {
    it.text
  } else if it.has("children") {
    it.children.map(to-string).join()
  } else if it.has("body") {
    to-string(it.body)
  } else if it == [ ] {
    " "
  }
}

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
    margin: (left: 15mm, right: 15mm, top: 15mm, bottom: 15mm),
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
#let Lesson(
  number: none,
  date: none,
  it,
) = {
  [= Lesson #number]

  // datetime.today().display("[year]-[month]-[day]")
  // date.display("[year]")

  it
}
/// ---- End of Lesson ----

/// ---- Start of Abstract ----
#let Abstract(
  it,
) = [
  #it
]
/// ---- End of Abstract ----

/// ---- Start of Vocabulary ----
#let Vocabulary(
  title: "",
  it,
) = {
  [== #title]

  let vocabulary = ()

  for i in it.children {
    if type(i) == content and repr(i.func()) == "item" {
      let v = (
        phrase: none,
        grammar: none,
        transcription: none,
        translation: none,
        notes: none,
      )

      let state = "phrase"
      for j in i.body.children {

        if j.has("text") {
          let t = j.text

          if state == "phrase" {
            if t.starts-with("=") {
              state = "translation"
            } else if t.starts-with("{") {
              state = "grammar"
            } else if t.starts-with("[") {
              state = "transcription"
            }
          }
          
          if state == "translation" {
            if t.starts-with("(") {
              state = "notes"
            }
          }
        }

        if state == "phrase" {
          v.phrase = v.phrase + j
        } else if state == "grammar" {
          v.grammar = v.grammar + j
        } else if state == "transcription" {
          v.transcription = v.transcription + j
        } else if state == "translation" {
          v.translation = v.translation + j
        } else if state == "notes" {
          v.notes = v.notes + j
        }

        if j.has("text") {
          let t = j.text
          if state == "grammar" {
            if t.ends-with("}") {
              state = "phrase"
            }
          } else if state == "transcription" {
            if t.ends-with("]") {
              state = "phrase"
            }
          } else if state == "notes" {
            if t.ends-with(")") {
              state = "translation"
            }
          }
        }

      }

      v.phrase = to-string(v.phrase).trim()
      v.grammar = to-string(v.grammar).trim(regex("[\s\{\}]*"))
      v.transcription = to-string(v.transcription).trim(regex("[\s\[\]]*"))
      v.translation = to-string(v.translation).trim(regex("[\s=]*"))
      v.notes = to-string(v.notes).trim(regex("[\s\(\)]*"))

      vocabulary.push(v)
    }
  }
  
  columns(2, gutter: 12pt)[
    #for v in vocabulary {
      [#v.phrase]
      [ -- ]
      [#v.translation ]
      [\ ]
    }
  ]
}
/// ---- End of Vocabulary ----

/// ---- Start of Models ----
#let Models(
  title: "",
  items: (),
) = [
  == #title
  #items
]
/// ---- End of Models ----

/// ---- Start of Grammar ----
#let Grammar(
  title: str,
  it,
) = [
  == #title
  #it
]
/// ---- End of Grammar ----

/// ---- Start of Text ----
#let Text(
  title: "",
  it,
) = [
  == #title
  #it
]
/// ---- End of Text ----

/// ---- Start of Dialog ----
#let Dialog(
  title: str,
  it,
) = [
  == #title
  #it
]
/// ---- End of Dialog ----

/// ---- Start of Exercise ----
#let Exercise(
  number: str,
  it,
) = [
  == Exercise #number
  #it
]
/// ---- End of Exercise ----
