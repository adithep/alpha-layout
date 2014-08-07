(function () {

Template.__body__.__contentParts.push(Blaze.View('body_content_'+Template.__body__.__contentParts.length, (function() {
  var view = this;
  return Spacebars.include(view.lookupTemplate("_t_path"));
})));
Meteor.startup(Template.__body__.__instantiate);

Template.__define__("_t_path", (function() {
  var view = this;
  return Spacebars.With(function() {
    return Spacebars.call(view.lookup("path"));
  }, function() {
    return [ "\n    ", Blaze.Each(function() {
      return Spacebars.call(view.lookup("t_yield"));
    }, function() {
      return [ "\n      ", Spacebars.With(function() {
        return Spacebars.call(view.lookup("ex_ctl"));
      }, function() {
        return [ "\n        ", Spacebars.include(view.lookupTemplate("_sel_spa")), "\n      " ];
      }), "\n    " ];
    }), "\n  " ];
  });
}));

Template.__define__("sub_path", (function() {
  var view = this;
  return [ HTML.Raw("<h3>sub</h3>\n  "), Blaze.Each(function() {
    return Spacebars.call(view.lookup("t_sub"));
  }, function() {
    return [ "\n    ", Spacebars.include(view.lookupTemplate("_t_path")), "\n  " ];
  }) ];
}));

Template.__define__("main_intro", (function() {
  var view = this;
  return HTML.Raw("<h3>Intro</h3>");
}));

Template.__define__("_btn", (function() {
  var view = this;
  return HTML.A(HTML.Attrs({
    "class": function() {
      return [ "_btn ", Spacebars.mustache(view.lookup("_btn_class")) ];
    },
    href: function() {
      return Spacebars.mustache(view.lookup("fhref"));
    }
  }, function() {
    return Spacebars.attrMustache(view.lookup("_btn_dyn"));
  }), "\n    ", Blaze.View(function() {
    return Spacebars.mustache(view.lookup("dis_el"));
  }), "\n  ");
}));

Template.__define__("li_btn", (function() {
  var view = this;
  return HTML.LI("\n    ", HTML.A({
    href: function() {
      return [ "/", Spacebars.mustache(Spacebars.dot(view.lookup("."), "_tri_dis", "href")) ];
    }
  }, Blaze.View(function() {
    return Spacebars.mustache(Spacebars.dot(view.lookup("."), "_tri_dis", "dis"));
  })), "\n  ");
}));

Template.__define__("h1_title", (function() {
  var view = this;
  return HTML.A({
    href: function() {
      return Spacebars.mustache(view.lookup("fhref"));
    }
  }, "\n    ", HTML.H1({
    "class": "title_h"
  }, Blaze.View(function() {
    return Spacebars.mustache(view.lookup("dis_el"));
  })), "\n  ");
}));

Template.__define__("nav_title", (function() {
  var view = this;
  return HTML.DIV({
    "class": function() {
      return [ "nav_title ", Spacebars.mustache(view.lookup("ctl_look")) ];
    }
  }, "\n    ", Spacebars.include(view.lookupTemplate("awesome")), "\n  ");
}));

Template.__define__("nav_btn_list", (function() {
  var view = this;
  return HTML.DIV({
    "class": function() {
      return [ "nav_btn_list ", Spacebars.mustache(view.lookup("ctl_look")) ];
    }
  }, "\n    ", Spacebars.include(view.lookupTemplate("awesome")), "\n  ");
}));

Template.__define__("user_n", (function() {
  var view = this;
  return HTML.A(Blaze.View(function() {
    return Spacebars.mustache(view.lookup("dis_el"));
  }));
}));

Template.__define__("def_sub_tem", (function() {
  var view = this;
  return Blaze.View(function() {
    return Spacebars.mustache(view.lookup("dis_el"));
  });
}));

Template.__define__("nav_user", (function() {
  var view = this;
  return HTML.UL({
    "class": "right user"
  }, "\n    ", HTML.LI("\n      ", Spacebars.include(view.lookupTemplate("awesome")), "\n    "), HTML.Raw('\n    <li>\n      <a class="logout">`</a>\n    </li>\n  '));
}));

Template.__define__("main_nav", (function() {
  var view = this;
  return HTML.NAV({
    "class": function() {
      return [ "nav_large ", Spacebars.mustache(view.lookup("ctl_look")) ];
    }
  }, "\n    ", HTML.DIV({
    "class": "container"
  }, "\n      ", Spacebars.include(view.lookupTemplate("awesome")), "\n    "), "\n  ");
}));

Template.__define__("footer", (function() {
  var view = this;
  return HTML.DIV({
    "class": function() {
      return [ "footer ", Spacebars.mustache(view.lookup("ctl_look")) ];
    }
  }, "\n    ", Spacebars.include(view.lookupTemplate("awesome")), "\n  ");
}));

Template.__define__("footer_about", (function() {
  var view = this;
  return HTML.DIV({
    "class": function() {
      return [ "footer_about ", Spacebars.mustache(view.lookup("ctl_look")) ];
    }
  }, "\n    ", Spacebars.include(view.lookupTemplate("awesome")), "\n  ");
}));

Template.__define__("info", (function() {
  var view = this;
  return HTML.A(HTML.Attrs({
    "class": function() {
      return [ "profile_e ", Spacebars.mustache(view.lookup("_btn_class")) ];
    },
    href: function() {
      return Spacebars.mustache(view.lookup("fhref"));
    }
  }, function() {
    return Spacebars.attrMustache(view.lookup("_btn_dyn"));
  }), "\n    ", Blaze.View(function() {
    return Spacebars.mustache(view.lookup("dis_el"));
  }), "\n  ");
}));

Template.__define__("input", (function() {
  var view = this;
  return HTML.DIV({
    "class": function() {
      return [ "input ", Spacebars.mustache(view.lookup("ctl_look")) ];
    }
  }, "\n    ", Spacebars.include(view.lookupTemplate("awesome")), "\n  ");
}));

Template.__define__("input_el", (function() {
  var view = this;
  return HTML.Raw('<input placeholder="meme">');
}));

Template.__define__("data_tem", (function() {
  var view = this;
  return Blaze.Each(function() {
    return Spacebars.call(view.lookup("ctla"));
  }, function() {
    return [ "\n    ", Spacebars.With(function() {
      return Spacebars.call(view.lookup("dat_dat"));
    }, function() {
      return [ "\n      ", Blaze.Each(function() {
        return Spacebars.call(view.lookup("disp_arr"));
      }, function() {
        return [ "\n        ", Spacebars.include(view.lookupTemplate("dat_tem_cal")), "\n      " ];
      }), "\n    " ];
    }), "\n  " ];
  });
}));

Template.__define__("each_disp", (function() {
  var view = this;
  return Blaze.Each(function() {
    return Spacebars.call(view.lookup("disp_arr"));
  }, function() {
    return [ "\n    ", Blaze.View(function() {
      return Spacebars.mustache(view.lookup("disp"));
    }), "\n  " ];
  });
}));                                                                                                

Template.__define__("ctl_tem", (function() {
  var view = this;
  return Blaze.Each(function() {
    return Spacebars.call(view.lookup("ctl"));
  }, function() {
    return [ "\n    ", Spacebars.With(function() {
      return Spacebars.call(view.lookup("ex_ctl"));
    }, function() {
      return [ "\n      ", Spacebars.include(view.lookupTemplate("tem_cal")), "\n    " ];
    }), "\n  " ];
  });
}));

Template.__define__("awesome", (function() {
  var view = this;
  return [ Spacebars.include(view.lookupTemplate("ctl_tem")), "\n  ", Spacebars.include(view.lookupTemplate("data_tem")) ];
}));


}).call(this);
