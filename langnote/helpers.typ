#import "colors.typ": color-text

#let to-string(it) = {
  if type(it) == str {
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
