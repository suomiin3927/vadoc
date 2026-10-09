#let report-template(
  title: "",
  subtitle: none,
  author: "",
  student-id: none,
  date: none,
  show-cover: true,
  show-page-num: true,
  cols: 1,
  body
) = {
  set page(
    paper: "a4",
    margin: (x: 2.5cm, top: 2.5cm, bottom: 2.5cm),
    footer: context {
      let current-page = counter(page).get().first()
      if show-page-num and (not show-cover or current-page > 1) {
        align(center, text(size: 10pt)[#current-page])
      }
    }
  )

  set text(
    font: ("Harano Aji Mincho", "IPAexMincho", "Hiragino Mincho ProN", "MS Mincho"),
    size: 10.5pt,
    lang: "ja"
  )
  
  set par(
    justify: true,
    leading: 0.8em,
    first-line-indent: 1em
  )

  if show-cover {
    align(center + horizon)[
      #v(-3cm)
      #text(size: 24pt, weight: "bold")[#title] \
      #if subtitle != none {
        v(1em)
        text(size: 16pt, style: "italic")[#subtitle]
      }
      
      #v(8cm)
      
      #block(width: 60%, align(left)[
        #set text(size: 12pt)
        #grid(
          columns: (80pt, 1fr),
          row-gutter: 1.2em,
          if student-id != none [学籍番号:], if student-id != none [#student-id],
          [氏名:], [#author],
          [提出日:], [#date],
        )
      ])
    ]
    pagebreak()
  }

  if show-cover {
    counter(page).update(1)
  }

  if not show-cover {
    align(center)[
      #text(size: 18pt, weight: "bold")[#title] \
      #if subtitle != none {
        text(size: 12pt)[#subtitle] 
      }
      #v(0.5em)
      #text(size: 10pt)[
        #if student-id != none [#student-id \ ]
        #author | #date
      ]
    ]
    v(2em)
  }

  if cols > 1 {
    show: columns.with(cols, gutter: 15pt)
    body
  } else {
    body
  }
}