var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

var Element = require("../js/element");
var Fog;

__extends(Fog, Element);

function Fog() {
  Fog.__super__.constructor.call(this, "fog");
}

Fog.prototype.reflect = true;

module.exports = Fog;
