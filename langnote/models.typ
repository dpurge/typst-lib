#import "langnote.typ": (
  config-foreign-script,
  config-foreign-lang,
)

#import "helpers.typ": (
  cfg-text,
  section-marker,
)

#let Models(
  title: "",
  it,
) = context {
  section-marker[M]
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
}