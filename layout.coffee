
class MTL
  constructor: (@doc, @dtl, @ctl) ->

  _sel_doc: ->
    if @dtl.doc and @dtl.doc[@doc.key_n]
      return @dtl.doc[@doc.key_n]

  get_href: ->
    if @dtl.get_href
      return @dtl.get_href()

  _sel_img: ->
    if @dtl.doc[@doc.key_n]
      return "http://localhost:8080/static/img/#{@dtl.doc[@doc.key_n]}"

  get_key: ->
    return "key-#{@doc.key_n}"

  doc_a_spa: ->
    if @ctl and @ctl.doc.data_href and @doc.key_n and @dtl.doc[@doc.key_n]
      return Template.a_tem
    else
      return @doc_spa()
    return null

  doc_spa: ->
    if @dtl.doc and @dtl.doc[@doc.key_n]
      if @doc.template
        tem = ses.tem[@doc.template].get()
        if tem and tem.doc_comp and Template[tem.doc_comp]
          return Template[tem.doc_comp]
      else if @ctl.get_c_tem
        return @ctl.get_c_tem()
    else if @doc.key_c and @ctl.get_c_tem_e
      return @ctl.get_c_tem_e()
    return null

  get_tem_ty: ->
    if @doc.template and Template[@doc.template]
      tem = ses.tem[@doc.template].get()
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
    unless @hist
      @hist = {}
    unless @hist[ndoc._s_n]
      @hist[ndoc._s_n] = {}
    if ndoc
      for dkey of ndoc
        if @doc[dkey]
          @hist[ndoc._s_n][dkey] = @doc[dkey]
        @doc[dkey] = ndoc[dkey]
    return

  unjoin_doc: (ndoc) ->
    if ndoc
      for dkey of ndoc
        if @doc[dkey]
          if @hist and @hist[ndoc._s_n] and @hist[ndoc._s_n][dkey]
            @doc[dkey] = @hist[ndoc._s_n][dkey]
          else
            delete @doc[dkey]
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
            cur = ses.current_path_n.get()
            if cur is "/" or "" or @ctl.depth is 0
              return "/#{@doc[href]}"
            else
              dish = Mu.remove_first_last_slash(cur)
              arr = dish.split("/")
              if arr.length is @ctl.depth
                return "#{cur}/#{@doc[href]}"
              else
                arr.splice(@ctl.depth, arr.length)
                dash = arr.join("/")
                return "/#{dash}/#{@doc[href]}"
    return

class CTL
  constructor: (@doc, @depth) ->

  c_yield: ->
    if @doc.data
      return DATA.find(@data(), @data_opt())
    else if @doc.data_func
      return @data_func()
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
    data_opt.transform = (doc) ->
      if doc._s_n is "_ctl"
        return new CTL(doc, self.depth)
      else
        return new DTL(doc, self)
    return data_opt

  data_func: ->
    return

  data_dis_key_arr: (dtl) ->
    if @doc.data_dis_key_arr and dtl
      arr = []
      n = 0
      while n < @doc.data_dis_key_arr.length
        arr[n] = new MTL(@doc.data_dis_key_arr[n], dtl, @)
        n++
      return arr

  _sel_spa: ->
    if ses.tem[@doc.tem_ty_n]
      tem = ses.tem[@doc.tem_ty_n].get()
      if tem and Template[tem.tem_comp]
        return Template[tem.tem_comp]
    return null

  s_each_cyield: ->
    unless @doc.group_key_by_s_n
      return Template.each_cyield
    else
      return Template.each_cyield_a
    return null

  get_c_tem: ->
    if ses.tem[@doc.tem_ty_n]
      tem = ses.tem[@doc.tem_ty_n].get()
      if tem and Template[tem.doc_comp]
        return Template[tem.doc_comp]
    return null
  get_c_tem_e: ->
    if ses.tem[@doc.tem_ty_n]
      tem = ses.tem[@doc.tem_ty_n].get()
      if tem and Template[tem.doc_each_comp]
        return Template[tem.doc_each_comp]
    return null
  get_tem_ty: ->
    if ses.tem[@doc.tem_ty_n]
      tem = ses.tem[@doc.tem_ty_n].get()
      if tem and tem.tem_class
        return tem.tem_class
  get_c_tem_ty: ->
    if ses.tem[@doc.tem_ty_n]
      tem = ses.tem[@doc.tem_ty_n].get()
      if tem and tem.doc_class
        return tem.doc_class

  get_look: ->
    if @doc.look_n
      return @doc.look_n
    else
      looks = DATA.findOne(_s_n: "tem_looks", tem_ty_n: @doc.tem_ty_n)
      if looks and looks.look_n
        return looks.look_n
      else
        looks = DATA.findOne(_s_n: "apps")
        if looks and looks.look_n
          return looks.look_n

  sub_path: ->
    depth = @depth + 1
    a = ses.path.get(depth)
    if a
      data = {_s_n: "a_paths", path_n: a}
      data_opt = {}
      data_opt.transform = (doc) ->
        return new CTL(doc, depth)
      return DATA.findOne(data, data_opt)
    return

UI.registerHelper "path", ->
  a = ses.path.get(0)
  if a
    data = {_s_n: "a_paths", path_n: a}
    data_opt = {}
    data_opt.transform = (doc) ->
      return new CTL(doc, 0)
    return DATA.findOne(data, data_opt)
  return
