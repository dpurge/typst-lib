#import "requirements.typ": (
  dpurge-langnote.LangNote,
  dpurge-langnote.TitlePage,
  dpurge-langnote.TableOfContents,
)

#show: LangNote.with(
  title: "Język niemiecki",
  author: "D. Purge",
  version: none,
  
  native-lang: "pol",
  foreign-lang: "deu",
  foreign-script: "latn",
)

#TitlePage()

#include "txt/001.typ"

#TableOfContents()
