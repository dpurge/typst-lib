#import "config.typ": (
  config-author,
  config-version,
  config-native-script,
)


#let TitlePage(
) = context {
  set align(center)
  set page(numbering: none)

  show title: smallcaps
  show title: set text(size: 20pt)
  show title: set block(below: 1.2em)

  title()

  config-author.get()
  linebreak()

  [#config-version.get()]

  pagebreak()
  pagebreak()
  counter(page).update(1)
}