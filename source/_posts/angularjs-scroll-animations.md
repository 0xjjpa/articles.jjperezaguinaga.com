title: 'AngularJS: Scroll Animations'
tags:
  - angularjs
  - animations
  - javascript
id: 326
categories:
  - Developer Stories
date: 2013-07-16 22:21:09
---

# Introduction

Everyone has seen scroll based animations right? You know, the ones where you start scrolling down the webpage and animations start triggering around depending on how much you have scrolled. One of my favorite examples is [Let's free Congress](http://letsfreecongress.org/).

Now, sometimes we want to trigger an animation, but we don't want to make theentire page to rely on the scroll... maybe, just a little part of it. However, we can't trigger the animation until the user is viewing the part we want to animate, or else the animation will do all its magic without no audience. How do we do it?

## The scrollPosition directive

Let me introduce you the scrollPosition directive.

    .directive('scrollPosition', ['$window', '$timeout', '$parse', function($window, $timeout, $parse) {
        return function(scope, element, attrs) {

            var windowEl = angular.element($window)[0];
            var directionMap = {
              "up": 1,
              "down": -1,
              "left": 1,
              "right": -1
            };

            // We retrieve the element with the scroll
            scope.element = angular.element(element)[0];

            // We store all the elements that listen to this event
            windowEl._elementsList = $window._elementsList || [];
            windowEl._elementsList.push({element: scope.element, scope: scope, attrs: attrs});

            var element, direction, index, model, scrollAnimationFunction, tmpYOffset = 0, tmpXOffset = 0;
            var userViewportOffset = 200;

            function triggerScrollFunctions() {

              for (var i = windowEl._elementsList.length - 1; i &gt;= 0; i--) {
                element = windowEl._elementsList[i].element;
                if(!element.firedAnimation) {
                  directionY = tmpYOffset - windowEl.pageYOffset &gt; 0 ? "up" : "down";
                  directionX = tmpXOffset - windowEl.pageXOffset &gt; 0 ? "left" : "right";
                  tmpXOffset = windowEl.pageXOffset;  
                  tmpYOffset = windowEl.pageYOffset;  
                  if(element.offsetTop - userViewportOffset &lt; windowEl.pageYOffset &amp;&amp; element.offsetHeight &gt; (windowEl.pageYOffset - element.offsetTop)) {
                    model = $parse(windowEl._elementsList[i].attrs.scrollAnimation)
                    scrollAnimationFunction = model(windowEl._elementsList[i].scope)
                    windowEl._elementsList[i].scope.$apply(function() {
                      element.firedAnimation = scrollAnimationFunction(directionMap[directionX]);  
                    })
                    if(element.firedAnimation) {
                      windowEl._elementsList.splice(i, 1);
                    }
                  }
                } else {
                  index = windowEl._elementsList.indexOf(element); //TODO: Add indexOf polyfill for IE9 
                  if(index &gt; 0) windowEl._elementsList.splice(index, 1);
                }
              };
            };
            windowEl.onscroll = triggerScrollFunctions;
          };   
        }]);
    `</pre>

    This directive was used to craft the [following animation](https://www.centralway.com/en/career/design).

    ![Picture](https://coderwall-assets-0.s3.amazonaws.com/uploads/picture/file/1871/Screen_Shot_2013-07-17_at_12.08.44_AM.png)

    Pretty much, when you scroll down through the page, the slider starts going up until we reach the limit, and the animation only triggers when the user is currently viewing the element to animate.

    ## Usage

    First, we are going to see how we can use this directive in your project and then we are going to break it in little pieces to understand how it works.

    In the element you want to perform an animation, add the directive. In our case it was this (Jade HTML):
    <pre>`.row.show-for-large-up
      .teaser(scroll-position, scroll-animation='fireupApplicationDesignAnimation')
        .row
          .large-6.columns.left-align.margin-top
            h1(data-i18n="_CareerDesign_APPLICATIONDESIGNTITLE")
    `</pre>

    This tells AngularJS that when the user starts to scrolls within the area of this DOMelement, it will trigger the scroll-animation function. In your controller, you should have something like this
    <pre>`$scope.fireupApplicationDesignAnimation = function(scrollDirection) {
            scrollDirection &gt; 0 ? reduceAmount() : aumentAmount(); // We want to increase on scrollDown
            setOffsetForImage();
        };
    `</pre>

    The directive sends to your controller function the direction of the scroll, so you can even perform animations based on this. Sometimes, you need to trigger the animation only once, so you need to return `true` in order to do so. An example from the same page:
    <pre>`$scope.fireupMarketingDesignAnimation = function() {
          if(!firedMarketingAnimation) {
            window.animations.marketingAnimation.init();
            firedMarketingAnimation = true;
            return firedMarketingAnimation;  
          }
        }

In this one, we have an animation that only needs to be triggered once. Since we don't know at which point of the scroll the user will match the DOM viewport (remember, he/she can scroll really fast!), we ought to wrap our function in a flag that ensures this only happens once.

## How it works?

This directive performs the following:

*   Creates an array of elements that require an onScroll eventListener (you can have multiples, they will be stored and removed in case you return a `true` value from your triggering function in order to ensure memory usage)
*   Adds an eventLister onScroll that checks the current user position on the webage
*   Travels through all your binded elements (although I haven't had performance problems, this could be an issue if you have too many binded elements with the directive) and checks if they have triggered their animation.
*   If they haven't and the user is within the viewport of the scroll, they do. This makes heavy usage of `$parse`, so make sure to read it's docs in order to understand completely.
*   Pops the element that was binded with the directive if the animation called within the scope's function returned a true value.

## Conclusion

This directive is good when you need to perform many animations that are triggered through a specific amount of time. It's also effective when you want a specific behavior that relies on the user position, or even changing CSS3 values as you scroll. Imade a [Codepen](http://codepen.io/jjperezaguinaga/pen/pzoHE) to show off this, which also works in a horizontal scroll.

![Picture](https://coderwall-assets-0.s3.amazonaws.com/uploads/picture/file/1872/Screen_Shot_2013-07-17_at_12.15.40_AM.png)

Basically I'm moving and rotating the ball on each scroll, depending on which direction the user goes.

Be warned though, that if the user has a kick as screen that allows him to see all your content without scroll, he might not be able to see the show. Fill up a timeout to make sure he/she does. As a final note, I'm using indexOf which it's not IE friendly, but can be easily replaced with a simple for..loop.