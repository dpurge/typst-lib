#import "config.typ": (
  config-foreign-script,
  config-foreign-lang,
  config-native-script,
  config-native-lang,
)

#import "colors.typ": color-text

#let translations = toml("translations.toml")

#let to-string(it) = {
  if it == none {
    ""
  } else if type(it) == str {
    it
  } else if type(it) != content {
    str(it)
  } else if it.has("text") {
    it.text
  } else if it.has("children") {
    it.children.map(to-string).join()
  } else if it.has("body") {
    to-string(it.body)
  } else if it == [ ] {
    " "
  }
}

// #let test-it(it) = {
//   repr(it)
// }

#let to-lang(it) = {
  let lang-code = none
  
  if it == "arb" {
    lang-code = "ar"
  } else if it == "cmn" {
    lang-code = "zh"
  } else if it == "fas" {
    lang-code = "fa"
  } else if it == "eng" {
    lang-code = "en"
  } else if it == "pol" {
    lang-code = "pl"
  } else if it == "kor" {
    lang-code = "ko"
  } else if it == "tur" {
    lang-code = "tr"
  } else {
    panic("(to-lang) Unsupported language: " + str(it))
  }
  
  lang-code
}

#let cfg-text(scope, script, lang) = {
  let cfg = (
    font: ("Arial", "Tahoma"),
    lang: to-lang(lang),
    size: 12pt,
    fill: color-text,
    dir: ltr,
  )

  if script == "latn" {
    if scope == "langnote-body" {
    } else if scope == "lesson-title" {
      cfg.size = 24pt
    } else if scope == "lesson-body" {
    } else if scope == "lesson-date" {
      cfg.size = 10pt
    } else if scope == "abstract-body" {
    } else if scope == "section-title" {
    } else if scope == "section-body" {
    } else if scope == "vocabulary-phrase" {
    } else if scope == "vocabulary-transcription" {
      cfg.font = ("Andika")
      cfg.style = "italic"
    } else if scope == "vocabulary-translation" {
    } else if scope == "line-number" {
      cfg.fill = gray
      cfg.size = 8pt
    } else {
      panic("(cfg-text) Unsupported scope: " + str(scope))
    }

  } else if script == "cyrl" {
    if scope == "section-title" {
    } else if scope == "section-body" {
    } else {
      panic("(cfg-text) Unsupported scope: " + str(scope))
    }

  } else if script == "arab" {
    cfg.font = ("Amiri")
    cfg.dir = rtl
    if scope == "section-title" {
      cfg.size = 16pt
    } else if scope == "section-body" {
      cfg.size = 14pt
    } else if scope == "vocabulary-phrase" {
      cfg.size = 14pt
    } else {
      panic("(cfg-text) Unsupported scope: " + str(scope))
    }

  // } else if script == "hans" {
  //   if scope == "section-title" {
  //   } else if scope == "section-body" {
  //   } else {
  //     panic("(cfg-text) Unsupported scope: " + str(scope))
  //   }

  } else if script == "hant" or script == "hans" {
      // cfg.font = ("FangSong")
      cfg.font = ("KaiTi")
    if scope == "section-title" {
      cfg.size = 16pt
    } else if scope == "section-body" {
      cfg.size = 14pt
    } else if scope == "vocabulary-phrase" {
      cfg.size = 14pt
    } else {
      panic("(cfg-text) Unsupported scope: " + str(scope))
    }

  } else if script == "kore" {
    cfg.font = ("Noto serif")
    if scope == "section-title" {
      cfg.size = 15pt
    } else if scope == "section-body" {
      cfg.size = 13pt
    } else if scope == "vocabulary-phrase" {
      cfg.size = 13pt
    } else {
      panic("(cfg-text) Unsupported scope: " + str(scope))
    }

  } else if script == "grek" {
    if scope == "section-title" {
    } else if scope == "section-body" {
    } else {
      panic("(cfg-text) Unsupported scope: " + str(scope))
    }

  } else if script == "deva" {
    if scope == "section-title" {
    } else if scope == "section-body" {
    } else {
      panic("(cfg-text) Unsupported scope: " + str(scope))
    }

  } else if script == "hebr" {
    cfg.dir = rtl
    if scope == "section-title" {
    } else if scope == "section-body" {
    } else {
      panic("(cfg-text) Unsupported scope: " + str(scope))
    }

  } else {
    panic("(cfg-text) Unsupported script: " + str(script))
  }

  // if lang == "pol" {
  // } else {
  //   panic("(cfg-text) Unsupported language: " + str(lang))
  // }
  
  cfg
}

#let section-marker(it) = {
  v(2em, weak: true)
  place(
    dx:-3mm-2em,
    dy:-1pt,
  )[
    #box(width: 2em)[
      #align(top+right)[
        #box(
          fill: black,
          width: 1em,
          height: 1em
        )[
          #align(center+horizon,
            text(
              fill: white,
              font: ("Arial", "Tahoma"),
              size: 12pt,
              strong(it)
            )
          )
        ]
      ]
    ]
  ]
}


#let render-dialog-body(it) = {
  
  let dialog = ()

  for i in it.children {
    if type(i) == content and repr(i.func()) == "item" {
      let d = (
        head: none,
        body: none,
      )

      let state = "head"
      for j in i.body.children {
        if j.has("text") {
          let t = j.text
          if state == "head" {
            if t.ends-with(":") {
              state = "separator"
              t = t.trim(":", at: end)
              j = if t == "" { none } else { t }
            } else if t.ends-with("：") {
              state = "separator"
              j = t.trim("：", at: end)
            } else if t == "-" and d.head == none {
              j = [--]
            }
          }
        }

        if state == "head" or state == "separator" {
          d.head = d.head + j
        } else {
          d.body = d.body + j
        }

        if state == "separator" {
          state = "body"
        }
      }

      dialog.push(d)
    }
  }

  set text(
    ..cfg-text(
      "section-body",
      config-foreign-script.get(),
      config-foreign-lang.get()
    ),
  )

  for d in dialog {
    [/ #d.head: #d.body]
  }
}

#let get-vocabulary-phrase(it) = {
  it.phrase
}

#let get-vocabulary-transcription(it) = {
  it.transcription
}

#let get-vocabulary-grammar(it) = {
  it.grammar
}

#let get-vocabulary-translation(it) = {
  if it.translation != "" {
    it.translation
  }
  if it.translation != "" and it.notes != "" {
    " "
  }
  if it.notes != "" {
    "("
    it.notes
    ")"
  }
}

#let render-vocabulary-body(
  it
) = {

  // defaults
  let columns = (12fr, 12fr)
  let phrase-column = 0
  let translation-column = 1
  let transcription-column = none

  let native-lang = config-native-lang.get()
  let native-script = config-native-script.get()

  // language setup
  let lang = config-foreign-lang.get()
  let script = config-foreign-script.get()

  if lang == "arb" {
    columns = (6fr, 7fr, 11fr)
    transcription-column = 1
    translation-column = 2
  } else if lang == "cmn" {
    columns = (6fr, 6fr, 12fr)
    transcription-column = 1
    translation-column = 2
  } else if lang == "fas" {
    columns = (6fr, 6fr, 12fr)
    transcription-column = 1
    translation-column = 2
  }

  // styling
  show grid: it => {

    show grid.cell.where(x: phrase-column): it => {
      set text(
        ..cfg-text(
          "vocabulary-phrase",
          script,
          lang
        ),
      )
      it
    }

    // if transcription-column != none {
      show grid.cell.where(x: transcription-column): it => {
        set text(
          ..cfg-text(
            "vocabulary-transcription",
            native-script,
            lang
          )
        )
        it
      }
    // }
    
    show grid.cell.where(x: translation-column): it => {
      set text(
        ..cfg-text(
          "vocabulary-translation",
          native-script,
          native-lang
        )
      )
      it
    }
    it
  }
  
  grid(
    columns: columns,
    gutter: 1em,

    ..for v in it {
      let row = ()
      for i in range(3) {
        if i == phrase-column {
          row.push(get-vocabulary-phrase(v))
        } else if i == translation-column {
          row.push(get-vocabulary-translation(v))
        } else if i == transcription-column {
          row.push(get-vocabulary-transcription(v))
        }
      }
      row
    }
  )
}