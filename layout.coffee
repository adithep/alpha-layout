
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
  tem_compile: ->
    tem = @tem_obj()
    if tem
      html = "<div class=#{tem.tem_n}>{{miracle}}</div>"
      html_func = SpacebarsCompiler.compile(html, {isTemplate: true})
      ff = eval(html_func)
      b = Template.__create__('_ctrl', ff)
      @tem = b
    return


UI.registerHelper "miracle", ->
  j = Ctrl.get(@_id)
  return j.tem_obj().tem_n



UI.registerHelper "_sel_spa", ->
  if @_id and @_ctl_id
    j = Ctrl.add(@)
    if j
      return j
  return null
Template._t_path.helpers
  path: ->
    unless @_id
      id = Session.get("current_session")
    else
      id = @_id
    return {_id: id}

  t_yield: ->
    return LDATA.find({_pid: @_id, _s_n: "_ctl"}, {sort: {sort: 1}})
