#import "config.typ": (
  config-foreign-script,
  config-foreign-lang,
  config-native-script,
  config-native-lang,
)

#import "helpers.typ": (
  to-string,
  cfg-text,
  section-marker,
  render-vocabulary-body,
)

#let Vocabulary(
  title: "",
  it
) = context {
  section-marker[V]
  // block[
    // #section-marker[V]
    {
      set text(
        ..cfg-text(
          "section-title",
          config-native-script.get(),
          config-native-lang.get()
        ),
      )

      heading(level: 2)[#title]
    }
  // ]

  let vocabulary = ()

  if it.has("children") {
    for i in it.children {
      if type(i) == content and repr(i.func()) == "item" {
        let v = (
          phrase: none,
          grammar: none,
          transcription: none,
          translation: none,
          notes: none,
        )

        let state = "phrase"
        for j in i.body.children {

          if j.has("text") {
            let t = j.text

            if state == "phrase" {
              if t.starts-with("=") {
                state = "translation"
              } else if t.starts-with("{") {
                state = "grammar"
              } else if t.starts-with("[") {
                state = "transcription"
              }
            }
            
            if state == "translation" {
              if t.starts-with("(") {
                state = "notes"
              }
            }
          }

          if state == "phrase" {
            v.phrase = v.phrase + j
          } else if state == "grammar" {
            v.grammar = v.grammar + j
          } else if state == "transcription" {
            v.transcription = v.transcription + j
          } else if state == "translation" {
            v.translation = v.translation + j
          } else if state == "notes" {
            v.notes = v.notes + j
          }

          if j.has("text") {
            let t = j.text
            if state == "grammar" {
              if t.ends-with("}") {
                state = "phrase"
              }
            } else if state == "transcription" {
              if t.ends-with("]") {
                state = "phrase"
              }
            } else if state == "notes" {
              if t.ends-with(")") {
                state = "translation"
              }
            }
          }

        }

        v.phrase = to-string(v.phrase).trim()
        v.grammar = to-string(v.grammar).trim(regex("[\s\{\}]*"))
        v.transcription = to-string(v.transcription).trim(regex("[\s\[\]]*"))
        v.translation = to-string(v.translation).trim(regex("[\s=]*"))
        v.notes = to-string(v.notes).trim(regex("[\s\(\)]*"))

        vocabulary.push(v)
      }
    }
    
    v(1em, weak: true)
    render-vocabulary-body(vocabulary)
  }
}