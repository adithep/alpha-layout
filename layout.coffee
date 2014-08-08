
Ctrl =
  components: {}
  add: (ctl) ->
    unless @components[ctl._id]
      @components[ctl._id] = new Ctrlgr(ctl)
      return @components[ctl._id].tem
    else
      return @components[ctl._id].tem

  get: (id) ->
    return @components[id]

  set: (tplData) ->
    @setSelectedButton tplData.value
    @settings.onSet tplData.value  if _.isFunction(@settings.onSet)
    return

  remove: (id) ->
    @components[id]["delete"]()
    @components[id] = null
    delete @components[id]
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
    if tem and tem.comp
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
  console.log @
  if @_id
    if @_s_n is "_ctl" and @_ctl_id
      j = Ctrl.add(@)
      if j
        return j
    else if @_s_n is "data" and @_did
      j = Ctrl.add(@)
  return null

UI.registerHelper "t_yield", ->
  return LDATA.find(
    {$or: [{_pid: @_id}, {_cid: @_id}], _s_n: {$in: ["_ctl", "data"]}}
    {sort: {sort: 1}}
  )


Template._t_path.helpers
  path: ->
    unless @_id
      id = Session.get("current_session")
    else
      id = @_id
    return {_id: id}
