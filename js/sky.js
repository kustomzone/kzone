var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { 
	for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
	function ctor() { this.constructor = child; } 
	ctor.prototype = parent.prototype; 
	child.prototype = new ctor(); 
	child.__super__ = parent.prototype; return child; 
  }

var Element = require("../js/element");
var Sky;
__extends(Sky, Element);
function Sky() { Sky.__super__.constructor.call(this, "sky"); }
Sky.prototype.reflect = true;
module.exports = Sky;
