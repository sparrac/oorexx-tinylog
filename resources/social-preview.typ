#set page(
  width: 1280pt,
  height: 640pt,
  margin: 40pt,
  fill: rgb("#0A192F"),
)

#set text(
  font: "Inter",
  fill: white,
)

#grid(
  columns: (300pt, 2pt, 1fr),
  column-gutter: 20pt,
  rows: (560pt,),

  // Logo
  [
    #align(center + horizon)[
      #rect(
        fill: rgb(255, 255, 255, 85%),
        radius: 24pt,
        inset: 30pt,
        outset: 0pt,
        stroke: 1.5pt + rgb(255, 255, 255, 40%),
        [
        #image("logo.svg", width: 240pt)
        ]
      )
    ]
  ],

  // Vertical separator
  [
    #align(center + horizon)[
      #rect(
        width: 2pt,
        height: 380pt,
        radius: 2pt,
        fill: rgb("#D0D7DE"),
      )
    ]
  ],

  // Right column
  [
    #box(
      width: 1fr,
      height: 380pt,
      align(top + left)[
        #v(128pt)

        #text(size: 100pt, weight: "bold")[
          oorexx-tinylog
        ]

        #v(-80pt)
        #rect(
          width: 200pt,
          height: 3pt,
          radius: 2pt,
          fill: rgb("#2EBE4F")
        )

        #v(-10pt)
        #text(size: 32pt, fill: rgb("#D0D7DE"))[
          A tiny logging library for #text(fill: rgb("#2EBE4F"))[Open Object Rexx].
        ]

        #v(-10pt)
        
        #rect(
          fill: rgb("#112240"),
          inset: (x: 10pt, y: 10pt),
          radius: 8pt,
          stroke: 1pt + rgb("#233554")
        )[
          #set text(font: "Hack", size: 30pt)
          
          #text(fill: orange)[log\~#text(fill: purple)[info]#text(fill: white)[("Hello, world!")]]
          
          #text(fill: rgb("#11D116"), weight: "bold")[[INFO 19790320]]
          #text(fill: rgb("#D0D7DE"))[ hello.rex:1: ]
          #text(fill: rgb("#D0D7DE"), weight: "bold")[ Hello, world! ]
        ]
      ]
    )

    #v(1fr)

    #h(1fr)
    #align(right)[
      #text(
        size: 25pt,
        fill: rgb("#D0D7DE")
      )[
        
Apache-2.0 #text(fill: rgb("#2EBE4F"))[• ooRexx 5.x]
      ]
      #h(80pt)
    ]
    #v(80pt)
  ],
)
