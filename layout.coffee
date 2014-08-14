class CTL
  constructor: (@doc) ->

UI.registerHelper "path", ->
  return ses.path.get(0)


UI.registerHelper "t_yield", ->
  if ses.root.paths[@] and ses.root.paths[@].data
    data = ses.root.paths[@].data
    data_opt = ses.root.paths[@].data_opt or {}
    data_opt.transform = (doc) ->
      return new CTL(doc)
    return DATA.find(data, data_opt)

UI.registerHelper "_sel_spa", ->
  if @doc and Template[@doc.tem_ty_n]
    return Template[@doc.tem_ty_n]
  return null
