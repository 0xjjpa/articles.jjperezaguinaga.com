title: AngularJS is amazing... and hard as hell
tags:
  - angularjs
  - javascript
id: 341
categories:
  - Developer Stories
date: 2013-09-21 15:26:14
---

I had been working in AngularJS for almost a year now, just right after they put Google’s logo in the web page. That’s around 20-40 hours a week in the past 10 months plus free time. Using the technology, I have done Chrome Applications, Mobile Applications, Web Apps, Modules, Animations and Single Page Applications (SPA’s). I can’t link all of them due a NDA with my company, but you can see some of my work on my [Coderwall profile](https://coderwall.com/p/u/jjperezaguinaga) and [Codepen profile](http://codepen.io/jjperezaguinaga/public/) to have an idea. At my company, we even worked on a bridge with AngularJS and LungoJS to make mobile applications, known internally as [L.A.B](https://github.com/centralway/lungo-angular-bridge), in which I made a couple not too shabby PR’s.

With that introduction, I want to share the following statement:

## AngularJS is amazing… and hard as hell.

Although I had been working with it for such a long time in a bunch of projects, I don’t consider myself a guru on the technology; I had stumbled upon many errors on my own code, and if Misko or Igor were to browse my initial experiments with the technology, they will probably laugh their head off thinking I’m a joke. I had done interfaces that make no sense, and tightly coupled services. Not only me, but co-workers that I consider highly smart developers, have struggled with some of the basic concepts that show off in the software whenever a really large application appears. I refactored one of the biggest modules at my company just to realize that even a couple months ago, I had no idea on how to really use the power of AngularJS.

## And that's ok

It's ok if you don't really understand AngularJS all at once. Getting started with the software is completely different that actually using for real applications. It just really takes time, more than you think it will to really get AngularJS.

If you have ever felt frustrated by this framework you are trying to learn, the good news are that it just takes time. This won't be a quick jQuery example you can run up easily in a jsFiddle, but a whole journey that you need to embrace to truly understand the framework.

Pick your resources wisely. Here’s my top four sources of information for good AngularJS knowledge (in that order):

*   [Egghead.io Videos](http://egghead.io/). I was quite sceptical about the webpage, but after seeing some of the videos, I realized that John’s videos were actually on track. Specially for beginners, this is an amazing source of information. Heck, if you are on the run all the time, buy the offline videos.

*   [The Mastering Web Application Development with AngularJS book](http://www.packtpub.com/angularjs-web-application-development/book). I just finished reading the book, and this is just a complete must for any AngularJS developer. The book structures perfectly the concepts behind AngularJS, as well as the good practices and main gotchas of the software. AngularJS is probably popular by it’s power as well as by it’s lack of documentation; here’s the missing manual that everyone should have in their library or kindle. I’ll save you the jumbo wumbo on all the benefits of the book and just tell you again to buy it. There’s really no excuse.

*   [AngularJS App](https://github.com/angular-app/angular-app). The create-CRUD-applications reference. Fork it, run it, play with it. See how they created the directives, how they organized the code, how they structured the tests. Even today I always browse that project to see how they used interceptors, how they tested their directives and what naming convention they used in their providers.

*   [The AngularJS Wiki](https://github.com/angular/angular.js/wiki). Whenever you struggle with an AngularJS concept, go and read the wiki. If you don’t really grasp all the concepts about the scopes, go and read the wiki. If you really want to become a good AngularJS, go and read the wiki. If anything related to AngularJS makes go dizzy... you know the rest.

## Getting better

At some point you will understand most of AngularJS concepts, to which then the next step is to start creating projects, pens and fiddles... but with tests on them. I found that most of the good concepts of AngularJS can be realized by adding tests to your projects. If you are not testing your software, then stop coding. Delivering untested software is unprofessional, and it should be avoided. You can be more flexible when you share your knowledge to other people (cough cough, like me, that I haven’t posted any tests on my codepens cough cough), BUT at some point specify that your software is untested or that you will put some tests later.*

*   A special note on this one, I’ll be working on adding more samples for AngularJS with tests included. I’ll write another post on this later.

## Final notes

I believe that even though AngularJS is really easy to get started with, it's really complicated to get. Making mistakes on the road is just to be expected. If by now you consider yourself an amazing AngularJS developer, you already have a copy of the AngularJS book (heck, if you were asked to review it), and are over 10K on SO by just AngularJS answers, Congratulations! Your responsibilities are higher because people will really start taking you seriously, and your posts and samples will be replicated through the web. At that point you should then go to conferences, create PR's, monitor Github issues and start contributing to the community. You can do the latest by installing the [Question Monitor for Stack Exchange](https://chrome.google.com/webstore/detail/question-monitor-for-stac/bnnkhapbhkejookmhgpgaikfdoegkmdp), add the `angularjs` tag, and spin a Pomodoro for 25 minutes a day to answer a couple questions there. Apply to/go for the [AngularJS Conf](http://ng-conf.org/). The call for speakers closes the 30th of September, what are you waiting for?