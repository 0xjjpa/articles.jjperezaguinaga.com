title: AngularJS Summer 2013 AngularJS knowledge base
tags:
  - angularjs
  - javascript
id: 336
categories:
  - Developer Stories
date: 2013-07-20 10:06:10
---

![Picture](https://coderwall-assets-0.s3.amazonaws.com/uploads/picture/file/1880/AngularJS-large.png)

1.  If I want to create a mobile app with AngularJS, there's a project that binds the awesome mobile framework [LungoJS](http://lungo.tapquo.com/) with AngularJS. It's called [Lungo-Angular-Bridge](https://github.com/centralway/lungo-angular-bridge) or just LAB.

2.  If I need a good reference for creating modular CRUD components, I can check out the [Angular-App](https://github.com/angular-app/angular-app). It includes nice examples for reusable Directives, Resources and Services.

3.  If I want to create a Chrome Extension with AngularJS, I need to use the `ng-csp`directive at the top of my `ng-app` and whitelist my chrome resources with the compileProvider. Also, the easiest way to do so is through [Yeoman](http://yeoman.io/), its [Chrome Extension Generator](https://github.com/yeoman/generator-chrome-extension) and then just do `bower i --save angular` (short notation for install and save angularjs).

    &lt;!doctype html&gt;
    &lt;html ng-app="Geomit" ng-csp&gt;
    &lt;head&gt;
      &lt;title&gt;Geomit&lt;/title&gt;
      ...

    //Sometimes you need to whitelist the Chrome Extension when accesing other Extension's resources through $http
    ...
    mymodule.config(['$compileProvider', function($compileProvider) {
      $compileProvider.urlSanitizationWhitelist(/^\s*(https?|file|chrome-extension):/);
    }])
    ...
    `</pre>

1.  AngularJS cool people, team members, resources and twitter: [Angular JS twitter](https://twitter.com/angularjs)(duh); AngularJS team members [Sindre Sorhus](https://twitter.com/sindresorhus) and [Brian Ford](https://twitter.com/briantford), including [Brian Ford blog](http://briantford.com/blog/); AngularJS "Father" [Misko Hevery](https://coderwall.com/p/@mhevery); AngularJS jack-of-all-trades [Oliver Tupman](https://twitter.com/olivertupman). And just in case you are living under a rock, Google Ninja [Andy Osmani](https://twitter.com/addyosmani) and Front End God [Paul Irish](https://twitter.com/paul_irish)
2.  If you use unstable-branch (`bower i --save angular-unstable`) AKA version 1.1.5, you can perform cool animations with the ng-animate directive. [Here's a simple slider I made in Codepen](http://codepen.io/jjperezaguinaga/pen/DGhjC) to showcase this function. The original example was taken from [here](http://www.nganimate.org/angularjs/ng-switch/slider-css3-transition-animation); don't forget that some people [don't like sliders](http://shouldiuseacarousel.com/)!
3.  AngularJS rocks for CSS3 animations (and not only with the unstable branch): you can use `ng-style` to change the CSS properties of HTML elements and react to changes from your controller. You can even use CSS3 transforms (still with vendor prefixes though)! So you can do things like this, were `ng-style` is binded to a controller function:<pre>`&lt;div ng-app="scrollSample" ng-controller="WrapperController" class="wrapper" ng-style="{'webkitTransform': transform()}"&gt;

    // In your controller
    $scope.transform = function() {
      return "rotateZ("+ degree +"deg)";
    }
    `</pre>

    <small>[Here's] the ([http://codepen.io/jjperezaguinaga/pen/pzoHE](http://codepen.io/jjperezaguinaga/pen/pzoHE)) sample Codepen with all the code.</small>

1.  The guys at Firebase created [AngularFire](https://github.com/firebase/angularFire), a AngularJS binding for their real-time backend service Firebase; now, your two way binding can be not only client side, but back-end side too. Here's the [video](http://www.youtube.com/watch?v=C7ZI7z7qnHU) (Realtime Web Apps with AngularJS and Firebase) with [Anant Narayanan](https://twitter.com/anantn) and [the blog post](https://www.firebase.com/blog/2013-07-16-build-your-own-feed-reader.html) on how to build your own Google Reader with Firebase and AngularJS. Look ma, no back end!
2.  If I want to do some AngularJS testing, I can always browse the most popular blog about testing: [Full Spectrum Testing with AngularJS and Karma](http://www.yearofmoo.com/2013/01/full-spectrum-testing-with-angularjs-and-karma.html)(Karma is what we previously knew as Testacular). Here's a small template you can use for your own small projects:<pre>`'use strict'

    // Unit test for MyController
    describe('MyController', function() {
      var controller, scope, httpBackend;
      var someService;
      var controllerInstance;

      // In case it's wrapped in a module
      beforeEach(module('MyModule'));

      beforeEach(
        inject(function(_$rootScope_, _$controller_, _$httpBackend_, _someService_){
          controller  = _$controller_;
          httpBackend = _$httpBackend_;
          scope = _$rootScope_.$new();

          someService = _someService_;
          // For integration tests, we want to also test our services
          someService.clearStuff();

          // For controllers that do http requests
          //httpBackend.expectGET('/url/to/API');     

          // You might want to start your controller here, or in each test...
          // controllerInstance = controller('MyController', {$scope: scope});
        })
      );

      //Tests
      it('should do something really nice', function() {
        // ... or start it here
        controllerInstance = controller('MyController', {$scope: scope});
      });

    })
    `</pre>

1.  If I want to create a directive, I check which type of directive I want to create. For most 'E' based ones (element directives) that represent isolated features, I usually create a new scope with the isolate option ({}). Most of the time, however, I use directives that receive attributes that communicate with a scope, so here `$parse` is my friend:<pre>`//A simple hover image directive so you don't have to use :hover css
    angularModule
    .directive('hoverImg', ['$parse', function($parse) {
      return function(scope, element, attrs) { 
        // In case some people use the directive accidently with {{}} instead of passing the variables
        var inactive = $parse(attrs.inactive)(scope) || attrs.inactive;
        var active = $parse(attrs.active)(scope) || attrs.active;
        scope.hover = function() {
          scope.src = active;
        }
        scope.unhover = function() {
          scope.src = inactive;
        }
        scope.unhover();
      }   
    }])

    // The HTML
    hoverImg(ng-inactive="inactive", ng-active="active", ng-mouseover='hover()', ng-mouseout='unhover()')
      img(ng-src="{{src}}")

1.  The reason [it's called AngularJS](http://docs.angularjs.org/misc/faq) and their namespaces "ng" is because HTML has Angular brackets and "ng" sounds like "Angular". It's an awesome framework and you should start using it right now :)