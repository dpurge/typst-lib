#import "config.typ": (
  config-foreign-script,
  config-foreign-lang,
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
  } else if it == "eng" {
    lang-code = "en"
  } else if it == "pol" {
    lang-code = "pl"
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
    } else {
      panic("(cfg-text) Unsupported scope: " + str(scope))
    }
  } else if script == "hans" {
    if scope == "section-title" {
    } else if scope == "section-body" {
    } else {
      panic("(cfg-text) Unsupported scope: " + str(scope))
    }
  } else if script == "hant" {
      cfg.font = ("FangSong")
    if scope == "section-title" {
      cfg.size = 16pt
    } else if scope == "section-body" {
      cfg.size = 14pt
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
            if t == ":" {
              state = "separator"
              continue
            } else if t == "-" and d.head == none {
              j = [--]
            }
          }
          if state == "separator" {
            state = "body"
          }
        }

        if state == "head" {
          d.head = d.head + j
        } else if state == "separator" {
        } else {
          d.body = d.body + j
        }
      }

      dialog.push(d)
    }
  }

  // repr(dialog)
  for d in dialog {
    [/ #d.head: #d.body]
  }
}

#let render-phrase(it) = {
  set text(
    ..cfg-text(
      "section-body",
      config-foreign-script.get(),
      config-foreign-lang.get()
    ),
  )
  it
}

#let render-transcription(it) = {
  it
}

#let render-grammar(it) = {
  it
}

#let render-vocabulary-body(
  it
) = {
  grid(
    columns: (6fr, 6fr, 12fr),
    gutter: 5pt,

    ..for v in it {
      (
        render-phrase(v.phrase),
        render-transcription(v.transcription),
        v.translation + if v.notes != "" { " (" + v.notes + ")" }
      )
    }
  )
}