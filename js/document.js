'use strict';

var UUID 	= require("uuid"),
  dom 		= require("../js/dom-lite"),
  Script 	= require("../js/script"),
  Document  = dom.Document,
  
  HTMLElement = dom.HTMLElement,
  
  Audio 	= require("../js/audio"),
  Billboard = require("../js/billboard"),
  Box 		= require("../js/box"),
  Fog 		= require("../js/fog"),
  Link 		= require("../js/link"),
  Model 	= require("../js/model"),
  Player 	= require("../js/player"),
  Spawn 	= require("../js/spawn"),
  Skybox 	= require("../js/skybox");
  

Document.prototype.markAsDead = function(uuid) {
  this.deadNodes[uuid] = (new Date).valueOf();
  return delete this.nodeMap[uuid];
};

Document.prototype.getElementByUUID = function(uuid) {
  return this.nodeMap[uuid];
};

Document.prototype.createElement = function(tag) {
  var node;
  if (tag === "script") { 			node = new Script;
  } else if (tag === "audio") {		node = new Audio;
  } else if (tag === "billboard") { node = new Billboard;
  } else if (tag === "box") { 		node = new Box;
  } else if (tag === "fog") {		node = new Fog;
  } else if (tag === "link") {		node = new Link;
  } else if (tag === "model") {		node = new Model;
  } else if (tag === "player") {	node = new Player;
  } else if (tag === "skybox") {	node = new Skybox;
  } else if (tag === "spawn") {		node = new Spawn;
  
  } else {	node = new HTMLElement(tag); }
  
  if (node.reflect) {
    node.uuid = UUID.v4();
    this.nodeMap[node.uuid] = node;
  }
  node.ownerDocument = this;
  node.eventTargets = {};
  return node;
};

Document.createDocument = function() {
  var d;
  d = new Document;
  d.deadNodes = {};
  d.nodeMap = {};
  return d;
};

module.exports = Document;
