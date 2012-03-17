(function() {
  var $, defaults, n, prefix, transformTypes, vendor, vendorNames, _base,
    __indexOf = Array.prototype.indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  $ = typeof jQuery !== "undefined" && jQuery !== null ? jQuery : require('jqueryify');

  if (!$) throw 'jQuery required';

  (_base = $.support).transition || (_base.transition = (function() {
    var style;
    style = (new Image).style;
    return 'transition' in style || 'webkitTransition' in style || 'MozTransition' in style;
  })());

  vendor = $.browser.mozilla ? 'moz' : void 0;

  vendor || (vendor = 'webkit');

  prefix = "-" + vendor + "-";

  vendorNames = n = {
    transition: "" + prefix + "transition",
    transform: "" + prefix + "transform",
    transitionEnd: "" + vendor + "TransitionEnd"
  };

  defaults = {
    duration: 400,
    queue: true,
    easing: '',
    enabled: $.support.transition
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
    var callback, called,
      _this = this;
    called = false;
    $(this).one(n.transitionEnd, function() {
      return called = true;
    });
    callback = function() {
      if (!called) return $(_this).trigger(n.transitionEnd);
    };
    return setTimeout(callback, duration);
  };

  $.fn.transform = function(properties, options) {
    var key, opts, transforms, value;
    opts = $.extend({}, defaults, options);
    if (!opts.enabled) return this;
    transforms = [];
    for (key in properties) {
      value = properties[key];
      if (!(__indexOf.call(transformTypes, key) >= 0)) continue;
      transforms.push("" + key + "(" + value + ")");
      delete properties[key];
    }
    if (transforms.length) properties[n.transform] = transforms.join(' ');
    if (opts.origin) properties["" + prefix + "transform-origin"] = opts.origin;
    return $(this).css(properties);
  };

  $.fn.gfx = function(properties, options) {
    var callback, opts;
    opts = $.extend({}, defaults, options);
    if (!opts.enabled) return this;
    properties[n.transition] = "all " + opts.duration + "ms " + opts.easing;
    callback = function() {
      var _ref;
      $(this).css(n.transition, '');
      if ((_ref = opts.complete) != null) _ref.apply(this, arguments);
      return $(this).dequeue();
    };
    return this[opts.queue === false ? 'each' : 'queue'](function() {
      $(this).one(n.transitionEnd, callback);
      $(this).transform(properties);
      return $(this).emulateTransitionEnd(opts.duration + 50);
    });
  };

}).call(this);
