Template.__define__("each_cyield_a", (function() {
  var view = this;
  return Mu.Eacha(function() {
    return Spacebars.call(view.lookup("."));
  }, function() {
    return [ "\n    ", Spacebars.include(view.lookupTemplate("_sel_spa")), "\n  " ];
  });
}));
