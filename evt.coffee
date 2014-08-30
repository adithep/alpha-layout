UI.body.events

  'blur .form_insert': (e, t) ->
    val = e.currentTarget.value or ""
    val = Mu.del_white_spa(val)
    if @path and ses.form_el[@path]
      ses.form_el[@path].set(val)
    if @dtl and @dtl.check_key_ty and @dtl.check_key_ty(val)
      @dtl.check_key_ty(val)

  'click .form_submit': (e, t) ->
    if @ctl
      if @ctl.form and @ctl.form_submit
        @ctl.form_submit()
      else if @ctl.opt.form and @ctl.opt.form.form_submit
        @ctl.opt.form.form_submit()
