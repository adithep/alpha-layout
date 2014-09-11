hide_ctl = (ctl) ->
  ctl.set('hide')

UI.body.events

  'blur .form_insert': (e, t) ->

    val = e.currentTarget.value or ""
    val = Mu.del_white_spa(val)
    if @path and ses.form_el[@path]
      ses.form_el[@path].set(val)
    if e.currentTarget.value is ""
      if @errvis
        @errvis.set('hide')
      if @errvisg
        @errvisg.set('hide')
      if @errstate
        @errstate.set('blank')
    else
      if @dtl and @dtl.check_key_ty
        if @dtl.check_key_ty(val)
          if @errvisg
            @errvisg.set('showa')
          if @errvis
            @errvis.set('showa')
          if @errstate
            @errstate.set('error')
        else
          if @errvisg
            @errvisg.set('showa')
          if @errvis
            @errvis.set('hide')
          if @errstate
            @errstate.set('ok')

  'click .form_submit': (e, t) ->
    if @ctl
      if @ctl.form and @ctl.form_submit
        ctl = @ctl
      else if @ctl.opt.form and @ctl.opt.form.form_submit
        ctl = @ctl.opt.form
      if ctl
        ctl.form_submit()


  'mouseenter .drop': (e, t) ->
    if @dvis
      @dvis.set("showa")

  'mouseleave .drop': (e, t) ->
    if @dvis
      @dvis.set("hide")

  'mouseenter .dropdown': (e, t) ->
    if @ptl.dvis
      @ptl.dvis.set("showa")

  'mouseleave .dropdown': (e, t) ->
    if @ptl.dvis
      @ptl.dvis.set("hide")

  'mouseenter .sub_sub_path': (e, t) ->
    if @doc.path_dis
      ses.current_path_h.set(@doc.path_dis)
