Ctrl =
  components: {}
  add: (ctl, settings) ->
    unless @components[ctl._id]
      @components[ctl._id] = new Ctrlgr(ctl)
    return

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
    @ctl_obj = DATA.findOne(_id: @ctl._ctl_id)




UI.registerHelper "_sel_spa", ->
  if @_id and @_ctl_id
    SBGCtrl.add(@)
Template._t_path.helpers
  path: ->
    unless @_id
      id = Session.get("current_session")
    else
      id = @_id
    return {_id: id}

  t_yield: ->
    return LDATA.find({_pid: @_id, _s_n: "_ctl"}, {sort: {sort: 1}})
