title: '[AngularJS 1.x] Scroll Animations'
tags:
  - angularjs
  - animations
  - javascript
id: 326
categories:
  - Developer Stories
date: 2013-07-16 22:21:09
---

Everyone has seen scroll based animations right? You know, the ones where you start scrolling down the webpage and animations start triggering around depending on how much you have scrolled. One of my favorite examples is [Let's free Congress](http://letsfreecongress.org/).

Now, sometimes we want to trigger an animation, but we don't want to make theentire page to rely on the scroll... maybe, just a little part of it. However, we can't trigger the animation until the user is viewing the part we want to animate, or else the animation will do all its magic without no audience. How do we do this with AngularJS?<!--more-->

## Example 

<p data-height="268" data-theme-id="1773" data-slug-hash="pzoHE" data-default-tab="result" data-user="jjperezaguinaga" class='codepen'>See the Pen <a href='http://codepen.io/jjperezaguinaga/pen/pzoHE/'>Roll, Dribbble, Roll!</a> by jjperezaguinaga (<a href='http://codepen.io/jjperezaguinaga'>@jjperezaguinaga</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

## The code

<iframe height='586' scrolling='no' src='//codepen.io/jjperezaguinaga/embed/pzoHE/?height=586&theme-id=1773&default-tab=js' frameborder='no' allowtransparency='true' allowfullscreen='true' style='width: 100%;'>See the Pen <a href='http://codepen.io/jjperezaguinaga/pen/pzoHE/'>Roll, Dribbble, Roll!</a> by jjperezaguinaga (<a href='http://codepen.io/jjperezaguinaga'>@jjperezaguinaga</a>) on <a href='http://codepen.io'>CodePen</a>.
</iframe>

Pretty much, when you scroll down through the page, the slider starts going up until we reach the limit, and the animation only triggers when the user is currently viewing the element to animate.


First, we are going to see how we can use this directive in your project and then we are going to break it in little pieces to understand how it works.

In the element you want to perform an animation, add the directive. In our case it was this (Jade HTML):


```
.row.show-for-large-up
  .teaser(scroll-position, scroll-animation='fireupApplicationDesignAnimation')
    .row
      .large-6.columns.left-align.margin-top
        h1(data-i18n="_CareerDesign_APPLICATIONDESIGNTITLE")
```

This tells AngularJS that when the user starts to scrolls within the area of this DOMelement, it will trigger the scroll-animation function. In your controller, you should have something like this

```
$scope.fireupApplicationDesignAnimation = function(scrollDirection) {
   scrollDirection > 0 ? reduceAmount() : aumentAmount(); // We want to increase on scrollDown
   setOffsetForImage();
};
```

The directive sends to your controller function the direction of the scroll, so you can even perform animations based on this. Sometimes, you need to trigger the animation only once, so you need to return `true` in order to do so. An example from the same page:

```
$scope.fireupMarketingDesignAnimation = function() {
          if(!firedMarketingAnimation) {
            window.animations.marketingAnimation.init();
            firedMarketingAnimation = true;
            return firedMarketingAnimation;  
          }
        }
```

In this one, we have an animation that only needs to be triggered once. Since we don't know at which point of the scroll the user will match the DOM viewport (remember, he/she can scroll really fast!), we ought to wrap our function in a flag that ensures this only happens once.

## How it works?

This directive performs the following:

*   Creates an array of elements that require an onScroll eventListener (you can have multiples, they will be stored and removed in case you return a `true` value from your triggering function in order to ensure memory usage)
*   Adds an eventLister onScroll that checks the current user position on the webage
*   Travels through all your binded elements (although I haven't had performance problems, this could be an issue if you have too many binded elements with the directive) and checks if they have triggered their animation.
*   If they haven't and the user is within the viewport of the scroll, they do. This makes heavy usage of `$parse`, so make sure to read it's docs in order to understand completely.
*   Pops the element that was binded with the directive if the animation called within the scope's function returned a true value.

## Conclusion

This directive is good when you need to perform many animations that are triggered through a specific amount of time. It's also effective when you want a specific behavior that relies on the user position, or even changing CSS3 values as you scroll. 

Basically I'm moving and rotating the ball on each scroll, depending on which direction the user goes.

Be warned though, that if the user has a kick as screen that allows him to see all your content without scroll, he might not be able to see the show. Fill up a timeout to make sure he/she does. As a final note, I'm using indexOf which it's not IE friendly, but can be easily replaced with a simple for..loop.
