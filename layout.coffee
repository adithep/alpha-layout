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
          cur = ses.current_path_n.get()
          if cur is "/" or "" or ctl.depth is 0
            return "/#{@doc[ctl.doc.data_href]}"
          else
            dish = cur.replace(/^\/|\/$/g, '')
            arr = dish.split("/")
            if arr.length is ctl.depth
              return "#{cur}/#{@doc[ctl.doc.data_href]}"
            else
              arr.splice(ctl.depth, arr.length)
              dash = arr.join("/")
              return "/#{dash}/#{@doc[ctl.doc.data_href]}"
    return

class CTL
  constructor: (@doc, @depth) ->

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
        ses.ctls[doc._id] = new CTL(doc, self.depth)
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
  sub_path: ->
    depth = @depth + 1
    a = ses.path.get(depth)
    if a

      data = {_s_n: "_ctl", path_n: a}
      data_opt = {}
      data_opt.transform = (doc) ->
        ses.ctls[doc._id] = new CTL(doc, depth)
        return ses.ctls[doc._id]
      return DATA.findOne(data, data_opt)
    return

UI.registerHelper "path", ->
  a = ses.path.get(0)
  if a
    data = {_s_n: "_ctl", path_n: a}
    data_opt = {}
    data_opt.transform = (doc) ->
      return new CTL(doc, 0)
    return DATA.findOne(data, data_opt)
  return

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
