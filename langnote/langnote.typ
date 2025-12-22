#import "colors.typ": color-text
#import "helpers.typ": cfg-text

#import "config.typ": (
  config-author,
  config-version,
  config-native-lang,
  config-native-script,
  config-foreign-lang,
  config-foreign-script,
)

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

  // set text(..cfg-text("line-number", native-script, native-lang))

  // set par.line(
  //   numbering: i => if calc.rem(i, 5) == 0 {
  //     text(..cfg-text("line-number", native-script, native-lang))[
  //       #i
  //     ]
  //   } else {
  //     none
  //   },
  //   numbering-scope: "page",
  //   number-margin: right,
  // )

  set par.line(
    numbering: i => {
      text(
        ..cfg-text("line-number", native-script, native-lang)
      )[#i]
    },
    numbering-scope: "page",
    number-margin: right,
  )

  it
}