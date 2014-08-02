Template.main_nav.events
  'mouseenter .user': (e, tpl) ->
    $(e.currentTarget).find('li').last().addClass('show')
  'mouseleave .user': (e, tpl) ->
    $(e.currentTarget).find('li').last().removeClass('show')
  'click .logout': (e, tpl) ->
    Meteor.logout()

UI.registerHelper "t_data", ->
  if @_did
    return DATA.find({_id: @_did})
  return null

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

Template._t_group.helpers
  t_gr: ->
    return LDATA.find(_gid: @_id, _s_n: "doc")

Template._t_space.helpers
  t_spa: ->
    return LDATA.find(_sid: @_id, _s_n: "_gr")

Template._t_path.helpers
  path: ->
    unless @_id
      id = Session.get("current_session")
    else
      id = @_id
    return {_id: id}

  t_yield: ->
    console.log @
    return LDATA.find(_pid: @_id, _s_n: "_spa")
  _sel_spa: ->
    if @_spa_tem and Template[@_spa_tem]
      return Template[@_spa_tem]
    return Template._t_space
  t_sub: ->
    id = Session.get("#{@_id}_path")
    return LDATA.find(_id: id, _s_n: "path")

Template._parent_t.helpers
  t_tem: ->
    if @_tri_ty
      switch @_tri_ty
        when 'insert_form'
          return Template.insert_form
        when '_btn_list'
          return Template.button_list
        when '_btn'
          return Template._schema_buttons
        when 'input'
          return Template._each_input
    else
      return Template._string_select_options
    return null
