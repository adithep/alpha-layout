
UI.registerHelper "_sel_spa", ->
  return @get_tem()

UI.registerHelper "t_yield", ->
  return LDATA.find(
    {$or: [{_pid: @_id}, {_cid: @_id}], _s_n: {$in: ["_ctl", "data"]}}
    {sort: {sort: 1}}
  )

UI.registerHelper "dis_key", ->
  parent = Blaze._parentData(1)
  ctl = parent.ctl_obj()
  if ctl.dis_key_dis
    return Template.dis_key_tem
  return null

UI.registerHelper "get_look", ->
  if @_id
    parent = @
  else
    parent = Blaze._parentData(1)
  if parent and parent.get_look
    return parent.get_look()

UI.registerHelper "get_href", ->
  if @_id
    parent = @
  else
    parent = Blaze._parentData(1)
  if parent and parent.get_href
    return parent.get_href()

UI.registerHelper "k_yield", ->
  return @ctl_obj().data_dis_key_arr

UI.registerHelper "_sel_doc", ->
  parent = Blaze._parentData(1)
  doc = parent.data_obj()
  if doc and doc[@]
    return doc[@]
  return

UI.registerHelper "_sel_img", ->
  parent = Blaze._parentData(1)
  img = parent.get_img()
  if img
    return img
  return

UI.registerHelper "_sel_key", ->
  parent = Blaze._parentData(1)
  doc = parent.get_key_dis(@)
  if doc
    return "#{doc}: "
  return

UI.registerHelper "sub_path", ->
  id = Session.get("#{@doc._pid}_path")
  if id

    return {_id: id}
  return


Template._t_path.helpers
  path: ->
    unless @_id
      id = Session.get("current_session")
    else
      id = @_id
    return {_id: id}
