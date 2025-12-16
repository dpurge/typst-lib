#import "config.typ": (
  config-foreign-script,
  config-foreign-lang,
)

#import "helpers.typ": (
  section-marker,
  cfg-text,
  render-dialog-body,
)

#let Dialog(
  title: none,
  it
) = context {
  section-marker[D]
  {
    set text(
      ..cfg-text(
        "section-title",
        config-foreign-script.get(),
        config-foreign-lang.get()
      ),
    )

    heading(level: 2, )[#title]
  }

  set terms(
    separator: h(1em),
    hanging-indent: 4em,
    spacing: 1em,
  )
  v(1em, weak: true)
  block[
    #render-dialog-body(it)
  ]
}