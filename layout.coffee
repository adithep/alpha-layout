class CTL
  constructor: (@doc) ->

  



UI.registerHelper "path", ->
  cur = ses.path.get(0)
  if cur
    return DATA.findOne(_s_n: "paths", path_n: cur)

UI.registerHelper "t_yield", ->
  if @path_ctl_arr
    return @path_ctl_arr
  return null

UI.registerHelper "c_yield", ->
  return DATA.findOne({_s_n: "_ctl", _ctl_n: String(@)}, {
    transform: (doc) ->
      return new CTL(doc)
  })

UI.registerHelper "_sel_spa", ->

  if @doc and Template[@doc.tem_ty_n]
    return Template[@doc.tem_ty_n]
  return null
