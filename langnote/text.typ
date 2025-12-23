#import "config.typ": (
  config-foreign-script,
  config-foreign-lang,
)

#import "helpers.typ": section-marker, cfg-text

#let Text(
  title: "",
  it
) = context {
  section-marker[T]
  // block[
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
  // ]

  {
    set text(
      ..cfg-text(
        "section-body",
        config-foreign-script.get(),
        config-foreign-lang.get()
      ),
    )
    set par(
      leading: 1em
    )
    v(1em, weak: true)
    it
  }
}