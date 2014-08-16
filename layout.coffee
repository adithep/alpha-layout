ses.ctls = {}

class DTL
  constructor: (@doc, @ctl_id) ->

  _sel_spa: ->
    ctl = ses.ctls[@ctl_id]
    if ctl and ctl.get_c_tem
      return ctl.get_c_tem()
    return null
  k_yield: ->
    ctl = ses.ctls[@ctl_id]
    if ctl and ctl.doc.data_dis_key_arr
      return ctl.doc.data_dis_key_arr
    return null
  get_href: ->
    ctl = ses.ctls[@ctl_id]
    if ctl
      if ctl.doc.data_href
        if @doc[ctl.doc.data_href]
          return "/#{@doc[ctl.doc.data_href]}"
    return

class CTL
  constructor: (@doc) ->

  c_yield: ->
    if @doc.data
      return DATA.find(@data(), @data_opt())
    else if @doc.data_func
      return @data_func()
  data: ->
    if @doc.data
      return EJSON.parse(@doc.data)
  data_opt: ->
    self = @
    if @doc.data_opt
      data_opt = EJSON.parse(@doc.data_opt)
    else
      data_opt = {}
    data_opt.transform = (doc) ->
      if doc._s_n is "_ctl"
        ses.ctls[doc._id] = new CTL(doc)
        return ses.ctls[doc._id]
      else
        return new DTL(doc, self.doc._id)
    return data_opt

  data_func: ->
    if @doc.data_func
      switch @doc.data_func
        when 'root'
          return [{app_dis: ses.root.app_dis}]
    return

  _sel_spa: ->
    if Template[@doc.tem_ty_n]
      return Template[@doc.tem_ty_n]
    return null

  get_c_tem: ->
    if Template[@doc.tem_ty_n+"_c"]
      return Template[@doc.tem_ty_n+"_c"]
    return null
  get_look: ->
    if @doc.look_n
      return @doc.look_n
    else
      return ses.root.look_n

UI.registerHelper "path", ->
  return ses.path.get(0)


UI.registerHelper "t_yield", ->
  if ses.root.paths[@] and ses.root.paths[@].data
    data = ses.root.paths[@].data
    data_opt = ses.root.paths[@].data_opt or {}
    data_opt.transform = (doc) ->
      return new CTL(doc)
    return DATA.find(data, data_opt)

UI.registerHelper "_sel_doc", ->
  parent = UI._parentData(1)
  if parent.doc[@]
    return parent.doc[@]
  return

UI.registerHelper "get_href", ->
  parent = UI._parentData(1)
  if parent.get_href
    return parent.get_href()
  return
