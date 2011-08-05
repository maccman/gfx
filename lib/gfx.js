(function() {
  var $, defaults, n, prefix, transformTypes, vendor, vendorNames;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; }, __indexOf = Array.prototype.indexOf || function(item) {
    for (var i = 0, l = this.length; i < l; i++) {
      if (this[i] === item) return i;
    }
    return -1;
  };
  $ = typeof jQuery !== "undefined" && jQuery !== null ? jQuery : require('jqueryify');
  if (!$) {
    throw 'jQuery required';
  }
  defaults = {
    duration: 400,
    queue: true,
    easing: ''
  };
  vendor = $.browser.mozilla ? 'moz' : void 0;
  vendor || (vendor = 'webkit');
  prefix = "-" + vendor + "-";
  vendorNames = n = {
    transition: "" + prefix + "transition",
    transform: "" + prefix + "transform",
    transitionEnd: "" + vendor + "TransitionEnd"
  };
  transformTypes = ['scale', 'scaleX', 'scaleY', 'scale3d', 'rotate', 'rotateX', 'rotateY', 'rotateZ', 'rotate3d', 'translate', 'translateX', 'translateY', 'translateZ', 'translate3d', 'skew', 'skewX', 'skewY', 'matrix', 'matrix3d', 'perspective'];
  $.fn.queueNext = function(callback, type) {
    type || (type = "fx");
    return this.queue(function() {
      var redraw;
      callback.apply(this, arguments);
      redraw = this.offsetHeight;
      return jQuery.dequeue(this, type);
    });
  };
  $.fn.emulateTransitionEnd = function(duration) {
    var callback, called;
    called = false;
    $(this).one(n.transitionEnd, function() {
      return called = true;
    });
    callback = __bind(function() {
      if (!called) {
        return $(this).trigger(n.transitionEnd);
      }
    }, this);
    return setTimeout(callback, duration);
  };
  $.fn.transform = function(properties) {
    var key, transforms, value;
    transforms = [];
    for (key in properties) {
      value = properties[key];
      if (__indexOf.call(transformTypes, key) >= 0) {
        transforms.push("" + key + "(" + value + ")");
        delete properties[key];
      }
    }
    if (transforms.length) {
      properties[n.transform] = transforms.join(' ');
    }
    return $(this).css(properties);
  };
  $.fn.gfx = function(properties, options) {
    var callback, opts;
    opts = $.extend({}, defaults, options);
    properties[n.transition] = "all " + opts.duration + "ms " + opts.easing;
    callback = function() {
      var _ref;
      $(this).css(n.transition, '');
      if ((_ref = opts.complete) != null) {
        _ref.apply(this, arguments);
      }
      return $(this).dequeue();
    };
    return this[opts.queue === false ? 'each' : 'queue'](function() {
      $(this).one(n.transitionEnd, callback);
      $(this).transform(properties);
      return $(this).emulateTransitionEnd(opts.duration + 50);
    });
  };
  $.fn.gfxPopIn = function(options) {
    var _ref;
    if (options == null) {
      options = {};
    }
        if ((_ref = options.scale) != null) {
      _ref;
    } else {
      options.scale = '.2';
    };
    $(this).queueNext(function() {
      return $(this).transform({
        '-webkit-transform-origin': '50% 50%',
        '-moz-transform-origin': '50% 50%',
        scale: options.scale,
        opacity: '0',
        display: 'block'
      });
    });
    return $(this).gfx({
      scale: '1',
      opacity: '1'
    }, options);
  };
  $.fn.gfxPopOut = function(options) {
    $(this).queueNext(function() {
      return $(this).transform({
        '-webkit-transform-origin': '50% 50%',
        '-moz-transform-origin': '50% 50%',
        scale: '1',
        opacity: '1'
      });
    });
    $(this).gfx({
      scale: '.2',
      opacity: '0'
    }, options);
    return $(this).queueNext(function() {
      return $(this).transform({
        display: 'none',
        opacity: '1',
        scale: '1'
      });
    });
  };
  $.fn.gfxFadeIn = function(options) {
    var _ref;
    if (options == null) {
      options = {};
    }
        if ((_ref = options.duration) != null) {
      _ref;
    } else {
      options.duration = 1000;
    };
    $(this).queueNext(function() {
      return $(this).css({
        opacity: '0'
      }).show();
    });
    return $(this).gfx({
      opacity: 1
    }, options);
  };
  $.fn.gfxFadeOut = function(options) {
    if (options == null) {
      options = {};
    }
    $(this).queueNext(function() {
      return $(this).css({
        opacity: 1
      });
    });
    $(this).gfx({
      opacity: 0
    }, options);
    return $(this).queueNext(function() {
      return $(this).hide().css({
        opacity: 1
      });
    });
  };
  $.fn.gfxShake = function(options) {
    var distance, _ref, _ref2;
    if (options == null) {
      options = {};
    }
        if ((_ref = options.duration) != null) {
      _ref;
    } else {
      options.duration = 100;
    };
        if ((_ref2 = options.easing) != null) {
      _ref2;
    } else {
      options.easing = 'ease-out';
    };
    distance = options.distance || 20;
    $(this).gfx({
      translateX: "-" + distance + "px"
    }, options);
    $(this).gfx({
      translateX: "" + distance + "px"
    }, options);
    $(this).gfx({
      translateX: "-" + distance + "px"
    }, options);
    $(this).gfx({
      translateX: "" + distance + "px"
    }, options);
    return $(this).queueNext(function() {
      return $(this).transform({
        translateX: 0
      });
    });
  };
  $.fn.gfxBlip = function(options) {
    if (options == null) {
      options = {};
    }
    options.scale || (options.scale = '1.15');
    $(this).gfx({
      scale: options.scale
    }, options);
    return $(this).gfx({
      scale: '1'
    }, options);
  };
  $.fn.gfxExplodeIn = function(options) {
    if (options == null) {
      options = {};
    }
    options.scale || (options.scale = '3');
    $(this).queueNext(function() {
      return $(this).transform({
        scale: options.scale,
        opacity: '0',
        display: 'block'
      });
    });
    return $(this).gfx({
      scale: '1',
      opacity: '1'
    }, options);
  };
  $.fn.gfxExplodeOut = function(options) {
    if (options == null) {
      options = {};
    }
    options.scale || (options.scale = '3');
    $(this).queueNext(function() {
      return $(this).transform({
        scale: '1',
        opacity: '1'
      });
    });
    $(this).gfx({
      scale: options.scale,
      opacity: '0'
    }, options);
    if (options.reset !== false) {
      $(this).queueNext(function() {
        return $(this).transform({
          scale: '1',
          opacity: '1',
          display: 'none'
        });
      });
    }
    return this;
  };
  $.fn.gfxFlipIn = function(options) {
    if (options == null) {
      options = {};
    }
    $(this).queueNext(function() {
      return $(this).transform({
        rotateY: '180deg',
        scale: '.8',
        display: 'block'
      });
    });
    return $(this).gfx({
      rotateY: 0,
      scale: 1
    }, options);
  };
  $.fn.gfxFlipOut = function(options) {
    if (options == null) {
      options = {};
    }
    $(this).queueNext(function() {
      return $(this).transform({
        rotateY: 0,
        scale: 1
      });
    });
    $(this).gfx({
      rotateY: '-180deg',
      scale: '.8'
    }, options);
    if (options.reset !== false) {
      $(this).queueNext(function() {
        return $(this).transform({
          scale: 1,
          rotateY: 0,
          display: 'none'
        });
      });
    }
    return this;
  };
  $.fn.gfxRotateOut = function(options) {
    if (options == null) {
      options = {};
    }
    $(this).queueNext(function() {
      return $(this).transform({
        rotateY: 0
      }).fix();
    });
    $(this).gfx({
      rotateY: '-180deg'
    }, options);
    if (options.reset !== false) {
      $(this).queueNext(function() {
        return $(this).transform({
          rotateY: 0,
          display: 'none'
        }).unfix();
      });
    }
    return this;
  };
  $.fn.gfxRotateIn = function(options) {
    if (options == null) {
      options = {};
    }
    $(this).queueNext(function() {
      return $(this).transform({
        rotateY: '180deg',
        display: 'block'
      }).fix();
    });
    $(this).gfx({
      rotateY: 0
    }, options);
    $(this).queueNext(function() {
      return $(this).unfix();
    });
    return $ = jQuery;
  };
  $.fn.gfxSlideOut = function(options) {
    var distance, opacity;
    if (options == null) {
      options = {};
    }
    options.direction || (options.direction = 'right');
    distance = options.distance || 100;
    if (options.direction === 'left') {
      distance *= -1;
    }
    distance += "%";
    opacity = options.fade ? 0 : 1;
    $(this).queueNext(function() {
      return $(this).show();
    });
    $(this).gfx({
      translate3d: "" + distance + ",0,0",
      opacity: opacity
    }, options);
    return $(this).queueNext(function() {
      return $(this).transform({
        translate3d: "0,0,0",
        opacity: 1
      }).hide();
    });
  };
  $.fn.gfxSlideIn = function(options) {
    var distance, opacity;
    if (options == null) {
      options = {};
    }
    options.direction || (options.direction = 'right');
    distance = options.distance || 100;
    if (options.direction === 'left') {
      distance *= -1;
    }
    distance += "%";
    opacity = options.fade ? 0 : 1;
    $(this).queueNext(function() {
      return $(this).transform({
        translate3d: "" + distance + ",0,0",
        opacity: opacity
      }).show();
    });
    return $(this).gfx({
      translate3d: "0,0,0",
      opacity: 1
    }, options);
  };
  $.fn.fix = function() {
    return $(this).each(function() {
      var element, parentOffset, styles;
      element = $(this);
      styles = element.offset();
      parentOffset = element.parent().offset();
      styles.left -= parentOffset.left;
      styles.top -= parentOffset.top;
      styles.position = 'absolute';
      return element.css(styles);
    });
  };
  $.fn.unfix = function() {
    return $(this).each(function() {
      var element;
      element = $(this);
      return element.css({
        position: '',
        top: '',
        left: ''
      });
    });
  };
}).call(this);
