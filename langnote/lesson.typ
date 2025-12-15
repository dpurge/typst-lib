#import "@preview/linguify:0.4.2": lflib

#import "langnote.typ": (
  config-native-script,
  config-native-lang,
)

#import "counter.typ": (
  counter-lesson,
)

#import "helpers.typ": (
  translations,
  cfg-text,
)

#let Lesson(
  date: datetime.today(),
  it
) = context {
  counter-lesson.step()
  {
    set align(center)

    {
      show heading: smallcaps
      show heading: set text(
        ..cfg-text(
          "lesson-title",
          config-native-script.get(),
          config-native-lang.get()
        ),
      )

      heading(
        level: 1,
        outlined: true,
      )[#lflib._linguify(
          "lesson",
          lang: "pol",
          from: translations
        ).ok #counter-lesson.display("1")]
    }

    {
      set text(
        ..cfg-text(
          "lesson-date",
          config-native-script.get(),
          config-native-lang.get()
        ),
      )

      date.display("[year]-[month]-[day]")
    }
  }

  it

  pagebreak()
}