#import "colors.typ": color-text
#import "helpers.typ": cfg-text

#let config-author = state("config-author")
#let config-version = state("config-version")
#let config-native-script = state("config-native-script")
#let config-foreign-script = state("config-foreign-script")
#let config-native-lang = state("config-native-lang")
#let config-foreign-lang = state("config-foreign-lang")

#let counter-lesson = counter("counter-lesson")
// #let counter-exercise = counter("counter-exercise")

#let LangNote(
  title: (:),
  author: (:),
  version: none,
  paper-size: "a5",
  native-lang: "eng",
  native-script: "latn",
  foreign-lang: "eng",
  foreign-script: "latn",
  it
) = context {

  set document(
    title: title,
    author: author,
    description: [],
    keywords: (),
    date: datetime.today()
  )

  config-author.update(author)
  config-version.update(version)
  config-native-script.update(native-script)
  config-foreign-script.update(foreign-script)
  config-native-lang.update(native-lang)
  config-foreign-lang.update(foreign-lang)

  // show: it => context {
  //   let lesson-nr = counter("lesson-nr")
  //   it
  // }

  set text(
    ..cfg-text("langnote-body", native-script, native-lang),
    fallback: true,
  )

  set page(
    paper: paper-size,
    margin: (
      left: 15mm,
      right: 15mm,
      top: 15mm,
      bottom: 20mm,
    ),
    footer-descent: 15pt,
    numbering: "1",
  )

  set par(
    justify: true,
  )

  it
}