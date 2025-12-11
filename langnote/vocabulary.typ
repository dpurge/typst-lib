#import "helpers.typ": to-string, section-header

#let Vocabulary(
  title: "",
  it,
) = {
  section-header("V", title)

  let vocabulary = ()

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
  
  columns(2, gutter: 12pt)[
    #for v in vocabulary {
      [#v.phrase]
      [ -- ]
      [#v.translation ]
      [\ ]
    }
  ]
}