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

#let section-header(marker, title) = {
  show heading.where(level: 2): it => {
      v(2em, weak: true)
      block(below: 1em)[
        #place(dx:-3mm-2em, dy:-3.5pt)[
          #box(width: 2em)[
            #context {
              align(right)[
                #box(
                  fill: color-text,
                  width: 1em,
                  height: 1em
                )[
                  #align(center+horizon,
                    text(
                      // font: sans,
                      // weight: sans-weight,
                      // size: heading-size,
                      fill: rgb("#fbfbfd"),
                      marker
                    )
                  )
                ]
              ]
            }
          ]
        ]

        #text(
          // font: sans,
          // weight: sans-weight,
          // size: heading-size,
          it.body
        )
      ]
  }

  [== #title]
}

#let dialog-body(it) = {
  
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
