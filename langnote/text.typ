#import "langnote.typ": (
  config-foreign-script,
  config-foreign-lang,
)

#import "helpers.typ": section-marker, cfg-text

#let Text(
  title: "",
  it
) = context {

  section-marker[T]
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

  set par.line(
    numbering: i => if calc.rem(i, 5) == 0 { i },
    numbering-scope: "page",
    number-margin: right,
  )

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