(->
  Template.__body__.__contentParts.push Blaze.View("body_content_" + Template.__body__.__contentParts.length, (->
    view = this
    Spacebars.include view.lookupTemplate("_t_path")
  ))
  Meteor.startup Template.__body__.__instantiate
  Template.__define__ "_t_path", (->
    view = this
    Spacebars.With (->
      Spacebars.call view.lookup("path")
    ), ->
      [
        "\n    "
        Blaze.Each(->
          Spacebars.call view.lookup("t_yield")
        , ->
          [
            "\n      "
            Spacebars.With(->
              Spacebars.call view.lookup("ex_ctl")
            , ->
              [
                "\n        "
                Spacebars.include(view.lookupTemplate("_sel_spa"))
                "\n      "
              ]
            )
            "\n    "
          ]
        )
        "\n  "
      ]

  )
  Template.__define__ "sub_path", (->
    view = this
    [
      HTML.Raw("<h3>sub</h3>\n  ")
      Blaze.Each(->
        Spacebars.call view.lookup("t_sub")
      , ->
        [
          "\n    "
          Spacebars.include(view.lookupTemplate("_t_path"))
          "\n  "
        ]
      )
    ]
  )
  Template.__define__ "main_intro", (->
    view = this
    HTML.Raw "<h3>Intro</h3>"
  )
  Template.__define__ "_btn", (->
    view = this
    HTML.A HTML.Attrs(
      class: ->
        [
          "_btn "
          Spacebars.mustache(view.lookup("_btn_class"))
        ]

      href: ->
        Spacebars.mustache view.lookup("fhref")
    , ->
      Spacebars.attrMustache view.lookup("_btn_dyn")
    ), "\n    ", Blaze.View(->
      Spacebars.mustache view.lookup("dis_el")
    ), "\n  "
  )
  Template.__define__ "li_btn", (->
    view = this
    HTML.LI "\n    ", HTML.A(
      href: ->
        [
          "/"
          Spacebars.mustache(Spacebars.dot(view.lookup("."), "_tri_dis", "href"))
        ]
    , Blaze.View(->
      Spacebars.mustache Spacebars.dot(view.lookup("."), "_tri_dis", "dis")
    )), "\n  "
  )
  Template.__define__ "h1_title", (->
    view = this
    HTML.A
      href: ->
        Spacebars.mustache view.lookup("fhref")
    , "\n    ", HTML.H1(
      class: "title_h"
    , Blaze.View(->
      Spacebars.mustache view.lookup("dis_el")
    )), "\n  "
  )
  Template.__define__ "nav_title", (->
    view = this
    HTML.DIV
      class: ->
        [
          "nav_title "
          Spacebars.mustache(view.lookup("ctl_look"))
        ]
    , "\n    ", Spacebars.include(view.lookupTemplate("awesome")), "\n  "
  )
  Template.__define__ "nav_btn_list", (->
    view = this
    HTML.DIV
      class: ->
        [
          "nav_btn_list "
          Spacebars.mustache(view.lookup("ctl_look"))
        ]
    , "\n    ", Spacebars.include(view.lookupTemplate("awesome")), "\n  "
  )
  Template.__define__ "user_n", (->
    view = this
    HTML.A Blaze.View(->
      Spacebars.mustache view.lookup("dis_el")
    )
  )
  Template.__define__ "def_sub_tem", (->
    view = this
    Blaze.View ->
      Spacebars.mustache view.lookup("dis_el")

  )
  Template.__define__ "nav_user", (->
    view = this
    HTML.UL
      class: "right user"
    , "\n    ", HTML.LI("\n      ", Spacebars.include(view.lookupTemplate("awesome")), "\n    "), HTML.Raw("\n    <li>\n      <a class=\"logout\">`</a>\n    </li>\n  ")
  )
  Template.__define__ "main_nav", (->
    view = this
    HTML.NAV
      class: ->
        [
          "nav_large "
          Spacebars.mustache(view.lookup("ctl_look"))
        ]
    , "\n    ", HTML.DIV(
      class: "container"
    , "\n      ", Spacebars.include(view.lookupTemplate("awesome")), "\n    "), "\n  "
  )
  Template.__define__ "footer", (->
    view = this
    HTML.DIV
      class: ->
        [
          "footer "
          Spacebars.mustache(view.lookup("ctl_look"))
        ]
    , "\n    ", Spacebars.include(view.lookupTemplate("awesome")), "\n  "
  )
  Template.__define__ "footer_about", (->
    view = this
    HTML.DIV
      class: ->
        [
          "footer_about "
          Spacebars.mustache(view.lookup("ctl_look"))
        ]
    , "\n    ", Spacebars.include(view.lookupTemplate("awesome")), "\n  "
  )
  Template.__define__ "info", (->
    view = this
    HTML.A HTML.Attrs(
      class: ->
        [
          "profile_e "
          Spacebars.mustache(view.lookup("_btn_class"))
        ]

      href: ->
        Spacebars.mustache view.lookup("fhref")
    , ->
      Spacebars.attrMustache view.lookup("_btn_dyn")
    ), "\n    ", Blaze.View(->
      Spacebars.mustache view.lookup("dis_el")
    ), "\n  "
  )
  Template.__define__ "input", (->
    view = this
    HTML.DIV
      class: ->
        [
          "input "
          Spacebars.mustache(view.lookup("ctl_look"))
        ]
    , "\n    ", Spacebars.include(view.lookupTemplate("awesome")), "\n  "
  )
  Template.__define__ "input_el", (->
    view = this
    HTML.Raw "<input placeholder=\"meme\">"
  )
  Template.__define__ "data_tem", (->
    view = this
    Blaze.Each (->
      Spacebars.call view.lookup("ctla")
    ), ->
      [
        "\n    "
        Spacebars.With(->
          Spacebars.call view.lookup("dat_dat")
        , ->
          [
            "\n      "
            Blaze.Each(->
              Spacebars.call view.lookup("disp_arr")
            , ->
              [
                "\n        "
                Spacebars.include(view.lookupTemplate("dat_tem_cal"))
                "\n      "
              ]
            )
            "\n    "
          ]
        )
        "\n  "
      ]

  )
  Template.__define__ "each_disp", (->
    view = this
    Blaze.Each (->
      Spacebars.call view.lookup("disp_arr")
    ), ->
      [
        "\n    "
        Blaze.View(->
          Spacebars.mustache view.lookup("disp")
        )
        "\n  "
      ]

  )
  Template.__define__ "ctl_tem", (->
    view = this
    Blaze.Each (->
      Spacebars.call view.lookup("ctl")
    ), ->
      [
        "\n    "
        Spacebars.With(->
          Spacebars.call view.lookup("ex_ctl")
        , ->
          [
            "\n      "
            Spacebars.include(view.lookupTemplate("tem_cal"))
            "\n    "
          ]
        )
        "\n  "
      ]

  )
  Template.__define__ "awesome", (->
    view = this
    [
      Spacebars.include(view.lookupTemplate("ctl_tem"))
      "\n  "
      Spacebars.include(view.lookupTemplate("data_tem"))
    ]
  )
  return
).call this
