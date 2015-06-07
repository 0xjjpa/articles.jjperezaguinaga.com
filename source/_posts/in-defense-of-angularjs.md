title: "In Defense of 'AngularJS'"
tags:
  - angularjs
  - javascript
id: 499
categories:
  - Developer Stories
date: 2014-11-23 15:48:35
---

Lately AngularJS has been getting a lot of bashing. To mention a few articles, we got [<span class="s1">“The Reason AngularJS will fall”</span>](http://okmaya.com/2014/03/12/the-reason-angular-js-will-fail/), [<span class="s1">“AngularJS: The Bad Parts”</span>](http://larseidnes.com/2014/11/05/angularjs-the-bad-parts/), and [<span class="s1">“AngularJS kinda sucks”</span>](http://okmaya.com/2014/02/27/angular-js-kinda-sucks/). This is not only due the AngularJS philosophy, but that with the recent [<span class="s1">Announcement of version 2.0</span>](https://www.youtube.com/watch?v=gNmWybAyBHI), people are asking themselves whether the [<span class="s1">AngularJS team has lost its marbles</span>](http://blog.dantup.com/2014/10/have-the-angular-team-lost-their-marbles/).

While AngularJS is without doubt a very opinionated framework, by all means it's not the impossible to learn, bad practices/terminology/philosophy, horrible framework that it's being described as. The only issue with AngularJS is that **people are looking at it the wrong way**.

## **A little bit of history**

I started coding in AngularJS by accident, actually. In 2012, my framework of choice was [<span class="s1">KnockoutJS</span>](http://knockoutjs.com/), and by then I had already started coding native Javascript for a few years. By fall of 2012, I was learning about AngularJS (version 1.0.0 back then) and enjoyed the data-binding similarity with KnockoutJS. On January of 2013, I signed a contract for coding a large application with AngularJS with a few other people, a framework which all of us didn't know much about. My experience can be described in an article I wrote in September of 2013 called [<span class="s1">AngularJS is amazing... and hard as hell</span>](https://coderwall.com/p/3qclqg/angularjs-is-amazing-and-hard-as-hell).

Sadly, I can't share the code, but I can tell you something: it's a mess. It's the sum up of constant learnings over a year, mixed philosophies and strategies by people that did it's best to deliver a product. And you know what? **That's fine**. Because by 2014, I guarantee you that most of the people involved in the project could redo the application by painting a proper roadmap for its features, define the architecture, code guidelines and practices to avoid, while still meeting a deadline. And all of that in AngularJS.

## **A deep dive: Judging diving by swimming**

[caption id="" align="aligncenter" width="640"]![](https://c3.staticflickr.com/3/2418/1570016652_cf168c3595_z.jpg?zz=1) Wreck diving, courtesy of Flickr under CC license.[/caption]

Although most of the developers involved in the project didn't like AngularJS, all of them were able to see its benefits and power by the end of the year. It's not that we didn't see other frameworks (we evaluated so many before picking AngularJS), but AngularJS was the only one by the date **that could possibly deliver the product we were looking for**. After the choice was made, everyone in the team went through the documentation, learned the terms, and in our own way, battled through every single deadline for a long year.

Whenever a see an opinion about AngularJS, I realise something: **people are trying to describe diving by swimming**. In other words, most people try to apply their current mindset (e.g. jQuery, Backbone) to AngularJS philosophy. People try to give AngularJS a shoot, do a few lines, code a todo app, fix some code, and then jump to immediate conclusions:

> _AngularJS doesn't play well with other libraries._

False. You can use any other library as you want, but you need to “wrap it” properly for AngularJS to use it. In our case, we even got [<span class="s1">LungoJS</span>](http://lungo.tapquo.com/) to [<span class="s1">play with AngularJS</span>](https://github.com/centralway/lungo-angular-bridge)

> _AngularJS stops working the moment you minify your code._

False. You just need to use the proper syntax for the injector, and even if you don't want to, you can always use [<span class="s1">ng-annotate</span>](https://github.com/olov/ng-annotate).

> _AngularJS can't do simple things like jQuery do._

False. You can always use <span class="s2">angular.element</span> the same way jQuery does <span class="s2">$()</span> and work from there. Whether that's a good idea, that's a different topic.

> _AngularJS it's terrible for doing X and Y._

So it's cutting a paper with a chainsaw. It doesn't make the chainsaw bad, but its probably the incorrect tool for the job.

If you really want to understand why AngularJS became one of the most popular Javascript frameworks nowadays, why is that there's so much interest about it, you **need to stop going through the surface** and actually immerse yourself into its world.

AngularJS is a **heavy time investment framework.** It is not by any means a simple library you can plug-in to an existing project. It's an all-or-nothing approach you need to take in order to fully take advantage of it. Like the old phrase, it's not going to be easy, but it's going to be worth it.

## **Why so deep?**

[caption id="" align="aligncenter" width="1024"]![](https://c2.staticflickr.com/8/7071/7026149599_1a8b278c74_b.jpg) Deep diving in Okinawa, courtesy of Flickr under CC license[/caption]

Now, whenever I discuss this point of view with other developers, I'm given multiple arguments. I'm going to go through each of the most common ones, as well as the ones described in the aforementioned articles.

### _Why should I invest my time to learn AngularJS philosophy/terms/logic when there's already defined patterns/strategies/standards?_

Sure, AngularJS has some confusing terminology: delegators, factories, providers, directives, transclusion, etc. One would expect those to make sense as in the Software Engineering world, but they don't always do. Within the AngularJS world, it takes some time to differentiate when to use Services and when to use Factories, for instance. The same things you could do with a controller, you could do with a directive. When to use which one?

Here's the thing: building big Web Applications is a daunting and complex task. There's so many pitfalls that for the past few years, developers around the world had been working on building more and more libraries, that can ease the pain of it. Instead of trying to tackle specific programming needs that solve small problems, AngularJS takes a stand a brings its toolset to cover them all. To avoid confusion between multiple developers within this inside circle, AngularJS has it's own terminology that to “outsiders” seems ridiculous, but that brings a common base language that has its documentation and can be referenced by.

### _I don't need to learn AngularJS because I can do web applications with just a bunch of libraries and it's way simpler._

The power of AngularJS doesn't come from simplicity or a small codebase. If you had ever seen the [<span class="s1">TodoMVC</span>](http://todomvc.com/) project, the [<span class="s1">jQuery solution</span>](https://github.com/tastejs/todomvc/blob/gh-pages/examples/jquery/js/app.js) is way smaller and simpler than the [<span class="s1">AngularJS one</span>](https://github.com/tastejs/todomvc/tree/gh-pages/examples/angularjs).

However, which one it's easy to test? Which one has less dependencies? Which one is easier to maintain? See, the jQuery one could had been done in thousand of ways; using Mustache instead of Handlebars, wrapped all DOM's through a helper, etc. AngularJS clears that out: There's a module, a directive, a controller and a service. Any seasoned AngularJS developer could pick it up and understand what's going on. Would any jQuery developer understand the jQuery equivalent?

### _I don't have the time to go through such a heavy time consuming framework._

That's too bad, because the time investment will pay of. That being said, I can relate. Not everyone gets a whole year to work on a project with relative flexibility. Sometimes developers are required to deliver, and we don't get much time to learn or research. Things need to be done, and we need to do our best with the resources at our disposal.

If you don't have much time to learn AngularJS properly, then don't. If you just half invest yourself into it, you will get frustrated, upset and write an article about how AngularJS is bad. Like the kid that tries to get a $3 soda from a vending machine, putting $2.90 will get you nothing.

### _I had been working on an app for X years, and I still think AngularJS is bad._

Although AngularJS was a good tool for the project we did, I can see some scenarios where AngularJS might not fit. Heavy UI interactions SPA's with low Business logic are probably done better with small libraries that glue themselves together.

If you ever think that AngularJS is not the right candidate to the job, that's when you would need to ask yourself: would it had been easier with Backbone or MarionetteJs? jQuery and Handlebars? Sometimes a project isn't a Web App, and some tools are better than others for the job. Now, how would you ever know if that's the case without testing them first?

## Conclusion: AngularJS 2.0 &amp; the Kool-Aid Point

There's so many resources for learning AngularJS, so many sample applications, and so many contribution from the community, that by now one would think that most developers would be convinced that AngularJS is actually a pretty decent tool (see, as a rule of thumb not that many people can't be wrong). Not perfect, but pretty decent. However, with the <span class="s1">[Announcement of version 2.0](https://www.youtube.com/watch?v=gNmWybAyBHI), a lot of people instead took it as a chance to say “I told you, AngularJS IS bad, now they won't bring support, lead developers will leave, master will branch out, it's Python 3 all over the place, and all projects made in AngularJS will spontaneously burst in flames”.</span>

See, nothing of that will happen. What will happen is that mature projects with a decent codebase will eventually plan migration to AngularJS 2.0, because redoing the whole application in something else would be a waste of time and resources; by doing so, they will eventually benefit of the performance improvements (e.g. Observe). Developers that decide whether to learn or not AngularJS, will add the roadmap plan as a criteria to use it or not, as they should do with any other framework to begin with. AngularJS will continue, more books will be written about it, and more conferences will show up about it. That's it.

I came to the conclusion that what's happening with AngularJS at the moment is that it reached the [Kool-Aid Point ](https://en.wikipedia.org/wiki/Kathy_Sierra "Kool-Aid Point defined by Kathy Sierra (see “Harassment”)"). You see, doesn't matter the language, runtime environment, text editor or framework you use, [programming will always suck](http://stilldrinking.org/programming-sucks "Programming Sucks"). Having an open-source framework that makes our life easier should come to all developers as a something from heaven, but after it becomes so popular, it also becomes a target. I'm not saying that we shouldn't question the tools we use for our work, but that we should be aware that some very talented and smart people are behind of it. Give it a chance. Who knows, maybe you will enjoy it after some time. To be honest, it's really nice down here once you get used to it.

[caption id="" align="alignnone" width="1600"]![](https://c2.staticflickr.com/6/5566/15010170127_03bf0a2d8f_h.jpg) Diving, courtesy from Flickr under CC license[/caption]