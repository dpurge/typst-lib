#import "requirements.typ": linguify.lflib

#import "config.typ": (
  config-foreign-script,
  config-foreign-lang,
)

#import "helpers.typ": (
  translations,
  cfg-text,
  section-marker,
)

#let Exercise(
  number: str,
  it,
) = context {
  section-marker[E]
  {
    set text(
      ..cfg-text(
        "section-title",
        config-foreign-script.get(),
        config-foreign-lang.get()
      ),
    )

    heading(level: 2)[
      #lflib._linguify("exercise",
        lang: "pol",
        from: translations,
      ).ok #number ]
  }
  it
}