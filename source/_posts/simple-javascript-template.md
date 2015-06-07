title: Simple Javascript Template
tags:
  - development
  - javascript
  - library
  - modular pattern
  - oop
  - programming
id: 280
categories:
  - Developer Stories
date: 2012-11-28 09:55:00
---

Lately I had been struggling trying to explain Javascript to newcomers, specially to people that come from OOP language and have problems understanding the language. As a result, I created a simple template for them to start hack away. As a bonus, I also added the basics for [YuiDocs](http://yui.github.com/yuidoc/) and how to use it.

Here's the stripped template. I would go check the Gist, as it seem the Syntax Highlighting works funky in Wordpress, plus I added some explanations there.

    /**
    * A simple template for native Javascript modules and classes with documentation
    * @module Template
    * @author jjperezaguinaga
    * @copyright (c) 2012 Company Inc.
    * @requires NoLibrary
    **/

    window.Template = (function( t, undefined ) {

    /**
    * My awesome class that does funky things.
    * @class AwesomeClass
    * @constructor
    * @chainable
    **/
    t.AwesomeClass = function() {
        var self = {};

        /**
        * My awesome property. Stick to a code standard - under_score or camelCase!
        * @property awesomeProperty
        * @type = {String}
        * @default "" 
        **/
        self.awesomeProperty = "";

        /**
        * My awesome private property. Closures! Your object has scope on this variable.
        * @property id
        * @type = {Number}
        * @default 0
        * @private
        *
        **/
        var id = 0;

        /**
        * "Constructor" of the class. Don't confuse with the at-constructor block
        * @method init
        * @param {String} awesome The initial value of our awesome property
        * @param {Number} id Our value id!
        **/
        self.init = function(awesome, id) {
            self.awesome = awesome;
            id = id;
            return self;
        }

        return self.init();
    }

    return t;
    })(window.Template || {});

Here's the [Gist](https://gist.github.com/6c4a65ffbcefb8c8ec09), feel free to grab it/fork it/comment. I also created a [Github Project](https://github.com/jjperezaguinaga/Javascript-Template) to show more less the way I use it. In practice, though, I usually have an extra module that manages all the dependencies.