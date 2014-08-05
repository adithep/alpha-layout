Template.main_nav.events
  'mouseenter .user': (e, tpl) ->
    $(e.currentTarget).find('li').last().addClass('show')
  'mouseleave .user': (e, tpl) ->
    $(e.currentTarget).find('li').last().removeClass('show')
  'click .logout': (e, tpl) ->
    Meteor.logout()

UI.registerHelper "test_pls", ->
  parent = UI._parentData(1)
  console.log parent
  console.log @

UI.registerHelper "dis_el", ->
  parent = UI._parentData(1)
  if parent[@]
    return parent[@]

UI.registerHelper "ex_ctl", ->
  if @_ctl_id
    return DATA.findOne(_id: @_ctl_id)

UI.registerHelper "t_data", ->
  if @_did
    return DATA.find({_id: @_did})
  return null

UI.registerHelper "disp", ->
  parent = UI._parentData(1)
  if parent[@]
    return parent[@]

UI.registerHelper "ctl_look", ->
  if @look_n
    return @look_n
  else if @tem_ty_n
    tem = DATA.findOne(_s_n: "def_tem", tem_ty_n: @tem_ty_n)
    if tem and tem.look_n
      return tem.look_n

UI.registerHelper "fhref", ->
  parent = UI._parentData(2)
  if parent.data_href and @[parent.data_href]
    if @[parent.data_href] is "blank"
      return "/"
    else
      return "/#{@[parent.data_href]}"
  else if parent.data_sub_href and @[parent.data_sub_href]
    cur = Session.get("current_path")
    return "/#{cur}/#{@[parent.data_sub_href]}"

UI.registerHelper "disp_arr", ->
  parent = UI._parentData(2)
  if parent.data_dis_key_arr
    return parent.data_dis_key_arr
UI.registerHelper "tem_cal", ->
  if @tem_n and Template[@tem_n]
    return Template[@tem_n]
  else if @tem_ty_n
    tem = DATA.findOne(_s_n: "def_tem", tem_ty_n: @tem_ty_n)
    if tem and Template[tem.tem_n]
      return Template[tem.tem_n]
  return null

UI.registerHelper "dat_tem_cal", ->
  parent = Blaze.getCurrentTemplateView().parentView.parentView.template.__templateName
  tem = DATA.findOne(_s_n: "templates", tem_n: parent)
  if tem and tem.sub_tem and Template[tem.sub_tem]
    return Template[tem.sub_tem]
  return Template.def_sub_tem


UI.registerHelper "make_href", ->
  if @href
    parent = UI._parentData(1)
    ini = Session.get("current_path")
    if ini
      num = parent.depth + 1
      arr = ini.split("/")
      arr.shift()
      len = arr.length
      arr.splice(num, len)
      str = arr.join("/")
    return "/#{str}#{@href}"
  return false
UI.registerHelper "dat_dat", ->
  if @_did
    return DATA.findOne(_id: @_did)
  else if @_fid
    switch @_fid
      when "current_user"
        return Meteor.user()
UI.registerHelper "ctla", ->
  parent = UI._parentData(1)
  if parent._id
    return LDATA.find({_cid: parent._id, _s_n: "data"}, {sort: {sort: 1}})
  return null
Template.ctl_tem.helpers
  ctl: ->
    parent = UI._parentData(1)
    if parent._id
      return LDATA.find({_pid: parent._id, _s_n: "_ctl"}, {sort: {sort: 1}})
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
  _sel_spa: ->
    if @tem_n and Template[@tem_n]
      return Template[@tem_n]
    else if @tem_ty_n
      tem = DATA.findOne(_s_n: "def_tem", tem_ty_n: @tem_ty_n)
      if tem and Template[tem.tem_n]
        return Template[tem.tem_n]
    return null
