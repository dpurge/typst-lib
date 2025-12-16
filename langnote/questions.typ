#import "config.typ": (
  config-foreign-script,
  config-foreign-lang,
)

#import "helpers.typ": (
  cfg-text,
  section-marker,
)

#let Questions(
  title: "",
  it,
) = context {
  section-marker[Q]
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
  {
    set text(
      ..cfg-text(
        "section-body",
        config-foreign-script.get(),
        config-foreign-lang.get()
      ),
    )
    v(1em, weak: true)
    it
  }
}
