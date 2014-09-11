
ses.form_el = {}



class MTL
  constructor: (@doc, @dtl, @ctl) ->
    @eid = Random.id()
    @depth = @ctl.ptl.depth
    if @ctl and @ctl.doc.form_el
      @path = @ctl.path + @dtl.doc._id
      unless ses.form_el[@path]
        ses.form_el[@path] = new Blaze.ReactiveVar()
      if @ctl.form and @ctl.regis_form_el
        @ctl.regis_form_el(@)
      else if @ctl.opt.form and @ctl.opt.form.regis_form_el
        @ctl.opt.form.regis_form_el(@)

  dyield: ->
    if @doc.dropdown
      if @dtl.doc[@doc.dropdown]
        obj = {data: @dtl.doc[@doc.dropdown]}
        if @dtl.doc["#{@dtl.doc[@doc.dropdown]}_opt"]
          obj.data_opt = @dtl.doc["#{dkey}_opt"]
        ctl = new CTL(obj, @, @ctl.path)
        @dvis = new Blaze.ReactiveVar('hide')
        return ctl
    return false

  dropdown: ->
    if @doc.dropdown
      if @dtl.doc[@doc.dropdown]
        return true
    return false

  get_error_icon_font: ->
    if @errstate
      errstate = @errstate.get()
      if errstate and errstate isnt 'blank'
        app = ses.app.get()
        if app and app.form_state_set_n
          state = ses.state_glyph[app.form_state_set_n].get()
          if state
            if errstate is 'error'
              if state.error_font
                return "key-#{state.error_font}"
            else if errstate is 'ok'
              if state.ok_font
                return "key-#{state.ok_font}"
    return

  get_error_icon: ->
    if @errstate
      errstate = @errstate.get()
      if errstate and errstate isnt 'blank'
        app = ses.app.get()
        if app and app.form_state_set_n
          state = ses.state_glyph[app.form_state_set_n].get()
          if state
            if errstate is 'error'
              if state.error_code
                return state.error_code
            else if errstate is 'ok'
              if state.ok_code
                return state.ok_code
    return
  get_err_state: ->
    unless @errstate
      state = 'blank'
      if @path and ses.form_el[@path]
        el = ses.form_el[@path].get()
        if el and el isnt ""
          if @dtl.check_key_ty(el)
            state = 'error'
          else
            state = 'ok'
      @errstate = new Blaze.ReactiveVar(state)
    return @errstate.get()

  get_visibility: ->
    app = ses.app.get()
    if app and app.form_show_error_message
      unless @errvis
        state = 'hide'
        if @path and ses.form_el[@path]
          el = ses.form_el[@path].get()
          if el and el isnt ""
            if @dtl.check_key_ty(el)
              state = 'showa'
        @errvis = new Blaze.ReactiveVar(state)
      return @errvis.get()
    return 'hide'

  get_visibility_glyph: ->
    app = ses.app.get()
    if app and app.form_show_error_glyph
      unless @errvisg
        state = 'hide'
        if @path and ses.form_el[@path]
          el = ses.form_el[@path].get()
          if el and el isnt ""
            state = 'showa'
        @errvisg = new Blaze.ReactiveVar(state)
      return @errvisg.get()
    return 'hide'

  get_error_msg: ->
    unless @errmsg
      @errmsg = new Blaze.ReactiveVar('Bad Value Type')
    return @errmsg.get()

  _sel_doc: ->
    if @doc.key_n
      if @dtl.doc and @dtl.doc[@doc.key_n]
        return @dtl.doc[@doc.key_n]
    return

  get_href: ->
    if @dtl.get_href
      return @dtl.get_href()

  _sel_img: ->
    if @dtl.doc[@doc.key_n]
      return "#{img_p}#{@dtl.doc[@doc.key_n]}"

  get_key: ->
    return "key-#{@doc.key_n}"

  get_evt: ->
    if @doc._evt
      return @doc._evt

  input_value: ->
    if @path and ses.form_el[@path]
      return ses.form_el[@path].get()
    return

  get_input_type: ->
    if @dtl and @dtl.get_input_type
      return @dtl.get_input_type()
    return

  doc_a_spa: ->
    if @ctl and @ctl.doc.data_href and @doc.key_n and @dtl.doc[@doc.key_n]
      return Template.a_tem
    else
      return @doc_spa()
    return null

  doc_spa: ->
    if @dtl.doc and @dtl.doc[@doc.key_n]
      if @doc.template
        tem = ses.templates[@doc.template].get()
        if tem and tem.doc_comp and Template[tem.doc_comp]
          return Template[tem.doc_comp]
      else if @ctl.get_c_tem
        return @ctl.get_c_tem()
    else if @doc.key_c and @ctl.get_c_tem_e
      return @ctl.get_c_tem_e()
    return null

  get_tem_ty: ->
    if @doc.template and Template[@doc.template]
      tem = ses.templates[@doc.template].get()
      if tem and tem.doc_class
        return tem.doc_class
    else if @ctl and @ctl.get_c_tem_ty
      return @ctl.get_c_tem_ty()

  _sel_doc_ea: ->
    if @doc.key_c and Array.isArray(@doc.key_c)
      arr = []
      n = 0
      while n < @doc.key_c.length
        arr[n] = new MTL(@doc.key_c[n], @dtl, @ctl)
        n++
      return arr
    return null


class DTL
  constructor: (@doc, @ctl) ->

  _sel_spa: ->
    return Template.each_kyield

  check_key_ty: (val) ->
    if val and @doc and @doc.key_ty and Mu.sanatize_key[@doc.key_ty]
      val = Mu.sanatize_key[@doc.key_ty](val)
      unless val
        return true
    return false


  get_input_type: ->
    if @doc
      switch @doc._s_n
        when "keys"
          switch @doc.key_ty
            when "email"
              return "email"
            else
              return "text"
        when "_btn"
          return "button"

  get_s_n: ->
    if @doc._s_n
      return "sn-#{@doc._s_n}"

  get_slave_num: (id_arr) ->
    if @ctl.doc.group_key_by_s_n and id_arr
      num = false
      if @doc._s_n is @ctl.doc.group_key_by_s_n
        id = @doc[@ctl.doc.group_key_by_key]
        if id_arr.indexOf(@doc[@ctl.doc.group_key_by_key]) isnt -1
          num = id_arr.indexOf(@doc[@ctl.doc.group_key_by_key])

      else if @ctl.doc.group_key_slave[@doc._s_n]
        slave_key = @ctl.doc.group_key_slave[@doc._s_n]
        id = @doc[slave_key]
        if id_arr.indexOf(@doc[slave_key]) isnt -1
          num = id_arr.indexOf(@doc[slave_key])
      return {num: num, id: id}
    return false

  check_slave: () ->
    if @ctl.doc.group_key_by_s_n
      if (@doc._s_n is @ctl.doc.group_key_by_s_n)
        return true
      else
        return false
    else
      return true
    return true

  join_doc: (ndoc) ->
    if ndoc
      s_n = @doc._s_n
      unless @histo
        @histo = {}
      unless @histo[@doc._s_n]
        @histo[@doc._s_n] = EJSON.clone(@doc)
      @histo[ndoc._s_n] = EJSON.clone(@ndoc)
      for dkey of ndoc
        @doc[dkey] = ndoc[dkey]
    return

  unjoin_doc: (ndoc) ->
    if ndoc and ndoc._s_n
      if @histo and @histo[ndoc._s_n]
        delete @histo[ndoc._s_n]
        @doc = {}
        for kk of @histo
          for key of @histo[kk]
            @doc[@histo[kk][key]] = @histo[kk][key]
    return

  k_yield: ->
    if @ctl and @ctl.data_dis_key_arr
      return @ctl.data_dis_key_arr(@)
    return null
  get_tem_ty: ->
    if @ctl and @ctl.get_c_tem_ty
      return @ctl.get_c_tem_ty()

  get_href: ->
    if @ctl and @ctl.data_href
      href = @ctl.data_href()
      if href
        if href is "/"
          return "/"
        else
          if @doc[href]
            depth = @ctl.ptl.depth.length - 1
            cur = ses.current_path_n.get()
            if cur is "/" or cur is "" or depth is 0
              return "/#{@doc[href]}"
            else
              dish = Mu.remove_first_last_slash(cur)
              arr = dish.split("/")
              if arr.length is depth
                return "#{cur}/#{@doc[href]}"
              else
                arr.splice(depth, arr.length)
                dash = arr.join("/")
                return "/#{dash}/#{@doc[href]}"
    return

class CTL
  constructor: (@doc, @ptl, @path, @opt) ->
    if @doc.form_ctl
      @form = {}

  c_yield: ->
    if @doc.data
      return DATA.find(@data(), @data_opt())
    else if @doc.data_func
      return @data_func()

  regis_form_el: (mtl) ->
    if mtl and mtl.eid and @form
      @form[mtl.eid] = mtl

  get_submit_msg: ->
    unless @submsg
      app = ses.app.get()
      if app and app.default_form_submit_message
        @submsg = new Blaze.ReactiveVar(app.default_form_submit_message)
      else
        @submsg = new Blaze.ReactiveVar('submited')
    return @submsg.get()

  get_submit_visibility: ->
    unless @subvis
      @subvis = new Blaze.ReactiveVar('hide')
    return @subvis.get()
  form_submit: ->
    self = this
    if @form
      obj = {}
      legit = true
      for key of @form
        if @form[key].path and ses.form_el[@form[key].path]
          if @form[key].errstate
            err = @form[key].errstate.get()
            if err is 'error'
              legit = false
              break
          val = ses.form_el[@form[key].path].get()
          if val? and val isnt ""
            if @form[key].dtl.doc.key_n
              obj[@form[key].dtl.doc.key_n] = val
      if legit is true
        if Object.keys(obj).length > 0
          if !@doc.form_required or Mu.parse_json_logic(@doc.form_required, obj)
            for key of @form
              if @form[key].path and ses.form_el[@form[key].path]
                ses.form_el[@form[key].path].set("")
                if @form[key].errstate
                  @form[key].errstate.set('blank')
                if @form[key].errvis
                  @form[key].errvis.set('hide')
                if @form[key].errvisg
                  @form[key].errvisg.set('hide')
            fobj = {}
            fobj._s_n = @doc.form_ctl
            app = ses.app.get()
            if app and app.app_n
              fobj.app_n = app.app_n
            if @doc.form_auto_add
              fobj.form_auto_add = @doc.form_auto_add
            Meteor.call 'form_submit', fobj, obj
            if @submsg
              app = ses.app.get()
              if app and app.default_form_submit_message
                @submsg.set(app.default_form_submit_message)
              else
                @submsg.set('submited')
          else
            if @submsg
              @submsg.set('Please fill the required field')
        else
          if @submsg
            @submsg.set('Please fill the required field')
      else
        if @submsg
          @submsg.set('Please fill in the correct information')
    if @subvis
      if @subvistime
        Meteor.clearTimeout(@subvistime)
      @subvis.set('showa')
      @subvistime = Meteor.setTimeout (->
        self.subvis.set('hide')
        return
      ), 4000

  data_href: ->
    if @doc.data_href
      return @doc.data_href
  data: ->
    if @doc.data
      return EJSON.parse(@doc.data)
  data_opt: ->
    self = @
    if @doc.data_opt
      data_opt = EJSON.parse(@doc.data_opt)
    else
      data_opt = {}
    path = @path + @_id
    data_opt.transform = (doc) ->
      if doc._s_n is "_ctl"
        if self.doc.form_ctl
          opt = {form: self}
        else if self.opt and self.opt.form
          opt = {form: self.opt.form}
        else
          opt = {}
        return new CTL(doc, self.ptl, path, opt)
      else
        return new DTL(doc, self)
    return data_opt

  data_func: ->
    if @doc.data_func
      switch @doc.data_func
        when "current_path"
          paa = ses.current_path_h.get()
          if paa
            obj = {path_dis: paa}
            dtl = new DTL(obj, @)
            return [dtl]

    return

  data_dis_key_arr: (dtl) ->
    if @doc.data_dis_key_arr and dtl
      arr = []
      n = 0
      while n < @doc.data_dis_key_arr.length
        if @doc.data_dis_key_arr[n][dtl._id]
          @doc.data_dis_key_arr[n] = @doc.data_dis_key_arr[n][dtl._id]
        arr[n] = new MTL(@doc.data_dis_key_arr[n], dtl, @)
        n++
      return arr

  _sel_spa: ->
    if ses.templates[@doc.tem_ty_n]
      tem = ses.templates[@doc.tem_ty_n].get()
      if tem and Template[tem.tem_comp]
        return Template[tem.tem_comp]
    return null

  s_each_cyield: ->
    unless @doc.group_key_by_s_n
      return Template.each_cyield
    else
      return Template.each_cyield_a
    return null

  get_visibility: ->
    if @ptl.dvis
      return @ptl.dvis.get()
    return


  get_c_tem: ->
    if ses.templates[@doc.tem_ty_n]
      tem = ses.templates[@doc.tem_ty_n].get()
      if tem and Template[tem.doc_comp]
        return Template[tem.doc_comp]
    return null
  get_c_tem_e: ->
    if ses.templates[@doc.tem_ty_n]
      tem = ses.templates[@doc.tem_ty_n].get()
      if tem and Template[tem.doc_each_comp]
        return Template[tem.doc_each_comp]
    return null
  get_tem_ty: ->
    if ses.templates[@doc.tem_ty_n]
      tem = ses.templates[@doc.tem_ty_n].get()
      if tem and tem.tem_class
        return tem.tem_class
  get_c_tem_ty: ->
    if ses.templates[@doc.tem_ty_n]
      tem = ses.templates[@doc.tem_ty_n].get()
      if tem and tem.doc_class
        return tem.doc_class

  get_size: ->
    if @doc.size
      return @doc.size
    else if ses.tem_looks[@doc.tem_ty_n]
      looks = ses.tem_looks[@doc.tem_ty_n].get()
      if looks and looks.size
        return looks.size
    return

  get_look: ->
    if @doc.look_n
      return @doc.look_n
    else if ses.tem_looks[@doc.tem_ty_n]
      looks = ses.tem_looks[@doc.tem_ty_n].get()
      if looks and looks.look_n
        return looks.look_n
    else
      looks = ses.app.get()
      if looks and looks.look_n
        return looks.look_n
    return

  sub_path_loop: (depth, arri) ->
    arr = arri or []
    a = ses.path.get(depth)
    path = @path + a
    if a
      a = new PTL(a, depth, path)
      arr.push(a)
      dep = depth.slice(-1)
      depth = depth.slice(0, -1)
      dep = Number(dep)
      dep++
      dep = String(dep)
      depth = "#{depth}#{dep}"
      arr = @sub_path_loop(depth, arr)
    return arr


  esub_path: ->
    a = @sub_path_loop("#{@ptl.depth}0")
    if a and a.length >= 1
      return a
    return null



class PTL
  constructor: (@doc, @depth, @path) ->

  sub_path: ->
    self = this
    if @doc
      data = {_s_n: "a_paths", path_n: @doc}
      data_opt = {}
      data_opt.transform = (doc) ->
        return new CTL(doc, self, self.path)
      return DATA.findOne(data, data_opt)
    return

UI.registerHelper "path", ->
  a = ses.path.get(0)
  if a
    a = new PTL(a, "0", a)
    return a
  return
