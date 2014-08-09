
Ctrl =
  components: {}
  add: (ctl) ->
    unless @components[ctl._id]
      if ctl._s_n is "_ctl" and ctl._ctl_id
        @components[ctl._id] = new Ctrlgr(ctl)
      else if ctl._s_n is "data" and ctl._did
        @components[ctl._id] = new Docgr(ctl)
    if @components[ctl._id] and @components[ctl._id].tem
      return @components[ctl._id].tem
    else
      return null
  get: (id) ->
    return @components[id]

  remove: (id) ->
    delete @components[id]
    return

class Docgr
  constructor: (@doc) ->
    @tem_compile()
  ctl_cla: ->
    return Ctrl.get(@doc._cid)
  ctl_obj: ->
    return @ctl_cla().ctl_obj()
  doc_obj: ->
    return DATA.findOne(_id: @doc._did)
  tem_obj: ->
    return @ctl_cla().tem_obj()
  doc_comp_obj: ->
    a = @tem_obj()
    if a and a.doc_comp
      return DATA.findOne(_s_n: "templates", tem_ty_n: a.doc_comp)
    return

  tem_loop: (html, arr) ->
    n = 0
    while n < arr.length
      if arr[n].tem_comp
        html = @tem_loop(html, arr[n].tem_comp)
      html = """
        <#{arr[n].tag} class='#{arr[n].class}'>
          #{html}
        </#{arr[n].tag}>
      """
      n++
    return html
  tem_compile: ->
    tem = @doc_comp_obj()
    if tem
      html = "{{_sel_doc}}"
      if tem.tem_comp
        html = @tem_loop(html, tem.tem_comp)
      html = "{{#each k_yield}}#{html}{{/each}}"
      html_func = SpacebarsCompiler.compile(html, {isTemplate: true})
      ff = eval(html_func)
      b = Template.__create__('_doc', ff)
      @tem = b
    else
      @tem = null
    return


class Ctrlgr
  constructor: (@ctl) ->

    @tem_compile()
  ctl_obj: ->
    return DATA.findOne(_id: @ctl._ctl_id)
  tem_obj: ->
    return DATA.findOne(_s_n: "templates", tem_ty_n: @ctl_obj().tem_ty_n)

  tem_loop: (html, arr) ->
    n = 0
    while n < arr.length
      if arr[n].tem_comp
        html = @tem_loop(html, arr[n].tem_comp)
      html = """
        <#{arr[n].tag} class='#{arr[n].class}'>
          #{html}
        </#{arr[n].tag}>
      """
      n++
    return html

  tem_compile: ->
    tem = @tem_obj()
    if tem and tem.tem_comp
      html = "{{#each t_yield}}{{>_sel_spa}}{{/each}}"
      html = @tem_loop(html, tem.tem_comp)
      html_func = SpacebarsCompiler.compile(html, {isTemplate: true})
      ff = eval(html_func)
      b = Template.__create__('_ctrl', ff)
      @tem = b
    return


UI.registerHelper "_ctl", ->
  console.log @
  return null



UI.registerHelper "_sel_spa", ->
  if @_id
    j = Ctrl.add(@)
    if j
      return j
  return null

UI.registerHelper "t_yield", ->
  return LDATA.find(
    {$or: [{_pid: @_id}, {_cid: @_id}], _s_n: {$in: ["_ctl", "data"]}}
    {sort: {sort: 1}}
  )

UI.registerHelper "k_yield", ->
  return Ctrl.get(@_id).ctl_obj().data_dis_key_arr

UI.registerHelper "_sel_doc", ->
  parent = Blaze._parentData(1)
  doc = Ctrl.get(parent._id).doc_obj()
  console.log doc
  if doc[@]
    return doc[@]
  return


Template._t_path.helpers
  path: ->
    unless @_id
      id = Session.get("current_session")
    else
      id = @_id
    return {_id: id}
