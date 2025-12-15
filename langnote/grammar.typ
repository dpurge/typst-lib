#import "langnote.typ": (
  config-foreign-script,
  config-foreign-lang,
)

#import "helpers.typ": (
  cfg-text,
  section-marker,
)

#let Grammar(
  title: str,
  it
) = context {
  section-marker[G]
  {
    set text(
      ..cfg-text(
        "section-title",
        config-foreign-script.get(),
        config-foreign-lang.get()
      ),
    )

    heading(level: 2)[#title]
  }
  v(1em, weak: true)
  it
}