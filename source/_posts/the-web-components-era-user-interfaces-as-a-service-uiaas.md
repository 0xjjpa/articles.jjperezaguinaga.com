title: 'The Web Components Era: User Interfaces as a Service (UIaaS)'
tags:
  - css
  - javascript
  - modules
  - polymer
  - Web Components
  - webcomponents
id: 351
categories:
  - Developer Stories
date: 2013-10-15 02:10:20
---

Exactly a month ago, a bunch of skilled developers and designers got together to discuss some of the most exciting topics related to CSS. This was known as the [CSS Conf EU 2013](http://cssconf.eu/), executed at Berlin in September. Of all the talks given there, one of them struck my attention the most: [CSS Module System in Google+](http://www.youtube.com/watch?v=vAs9tjEkkKk), by the Google Engineer Shubhie Panicker.

In her talk, Shubhie states that CSS is not so simple. For instance, she mentions UI regressions, or in other words, how a style used by a specific module can override the style of another in a specific situation. To overcome this, Google+ uses an architecture that organizes the modules dependencies of each page, and then properly assembles the modules in a way that minimizes HTTP requests and allows future requests to be small as possible. This is achieved through [Google Closure Stylesheets](https://code.google.com/p/closure-stylesheets/) as well as other architecture patterns.<!--more-->

![Google+ CSS Module Dependency Graph](https://dl.dropboxusercontent.com/u/23857782/CSS-modules-dependency-graph-on-Google-Plus.png)

<small>In order to generate the proper assets for its multiple pages, the G+ team organizes the dependencies according to the needs of each page and servers only those.</small>

### Compile, link and build. Easy right?

The first feeling I had after watching most of Shubhie's talk, was frustation. She was telling me that Google, one of the most experienced web companies, needed to setup an entire architecture to just reuse a bunch of widgets in their multiple pages. It needed to graph out it's entire system, with patterns, practices and carefully named classes in order to avoid something that Web Developers have faced for years if not decades. It had to engineer a build system to assemble and deliver CSS to its end users. It had to have namespaces to ensure the team didn't mess each other up. It was telling me that after all this years, despite of the web CSS progress in terms of capabilities (border-radious, gradients, flexbox, transforms, 3d), we still need to struggle our way out in terms of portability, encapsulation, scalability and reusability.

It's was telling me that CSS will still be easy enough to invite people to learn it, just to kick them right in the face months later whenever they create a mid sized application and other people work on it.

### Handle with care

The harsh reality of CSS is that it's presented as a simple to learn language that anyone can touch and play with, but on major scales requires savy-like knowledge and experience in terms of architecture, design and scalability. In many places is treated lightly, and it's not uncommon to have other people to fiddle with it.

![Github](https://dl.dropboxusercontent.com/u/23857782/Github-CSS-Performance-Developers.jpg)

<small>[Github's 2012 CSS Performance by Jon Rojan](https://speakerdeck.com/jonrohan/githubs-css-performance), showcasing how any mid to large application is doomed to be touched by multiple develoers</small>

A part of me (the engineering, B.S on Computer Science part), thinks that everyone should touch the CSS. We should be able to allow any developer that has readed half of [Harry's](http://csswizardry.com/) blog and completed a Code Academy course on HTML/CSS to add up it's magic, colors and markup to our application. Not everyone needs to know about Typography, Responsive Design or Vertical Rhythm to create a button, and with the amount of tasks required to be done, the more hands, the better.

The other part of me (wannabe designer, Sidebar.io reader, Forrst, Dribbble, Behance stalker), thinks that I'm out of my freaking mind. That unless you know BEM, OOCSS, had purchased the print copy of SMACSS, can recognize a humanist typeface, know what "em" in CSS really stands for and has a secret fan crush on Chris Coyier <small>(Ok, that's creepy, sorry Chris)</small>, shouldn't be near the company CSS. He/she will use id's willy nilly, write overqualified selectors, smash a `!important` when he can't figure it out the specificity and use magic numbers everywhere.

As a Front End Engineer, my responsability is to balance between those two sides within a team, and know when to pick which hat: if the CSS quality is dropping, I invest my time cleaning it up, sharing my insights about how to improve with the team, and code review it; if deadlines are hard to met, I focus on the incoming tickets, the Javascript, and share the tasks with other qualified developers that might not excel on CSS, but can get the job done.

Because at the end, everybody wants to get the job done.

### Introducing Web Components

If you have sticked so far, you have probably realized that I haven't talked about Web Components at all, yet being the post's title. I needed to introduce the proper background to showcase were Web Components excel, and why I think we are about to face a new era in Web Development, a Web Components era.

[Web Components](http://www.youtube.com/watch?v=U45e-zq4bTs) [are amazing](http://www.youtube.com/watch?v=R0SjR_DpHMM). If you are too lazy to read the [Web Components spec](http://www.w3.org/TR/2013/WD-components-intro-20130606/)(I won't blame you), you can at least check [this introduction](http://html5-demos.appspot.com/static/webcomponents/index.html#1) by Eric Bidelman (Programs Engineer from the Google Chrome Team) to make yourself acquantied with the concept. Although it's quite a experimental technology, polyfills like [Polymer](http://www.polymer-project.org/polymer.html)can make it "production" ready. The tl;dr version of Web Components is that they allow Front End development to be truly reusable and scalable by wrapping DOM logic into scopable and bindable elements through native templates.

Web Components allow us to finally have reusable widgets that let multiple developers to work together on a CSS. Anyone can touch the CSS and even Markup as they come up with a component that achieves the goal.

I'm not sure if this was meant when creating the spec, but I find this one of the main advantages of the technology: any developer can create a specific component completely isolated from each other. In case this hasn't breaked into you, I'm going to pinpoint what does it means:

*   It means that as long as your component works, it doesn't matter how bad or good it was written, because bad styles won't replicate over your webpage. Usual good CSS practices are followed just to ensure new CSS doesn't break old one.
*   It means that you can use isolated metrics for measuring the quality of a component. For instance, you can care less what a developer does in his component, but state as a requirement that the size of the component can not be higher than Nkbs.
*   Do you need a specific job done? Hire a Freelancer and ask him to craft acomponent for you. Just put that `&lt;freelancer-made&gt;&lt;/freelancer-made&gt;` element and watch it do it's magic.
*   If the freelancer wants, it can make components responsive. Have you seen this [cool example of adaptable responsive elements](http://kumailht.com/responsive-elements/)? Imagine it's component, ready to be placed wherever it goes.
*   Have you heard of [Flexbox](http://philipwalton.github.io/solved-by-flexbox/)? Now image the previous responsive example bending at your will through flexbox order property. Things like [Content Choreography](http://trentwalton.com/2011/07/14/content-choreography/) are a breeze.
In terms of reusability, Web Components have something that I have foreseen for many, many years: User Interfaces as a Service. I'm not talking about those ugle WYSYWYG editors with clutter code, or those weird third parties widgets that force their styles on your site. I'm talking about carefully crafted components that can be easily consumed.


### Welcome to the new era

![Brad Forst Atomic Web Design](https://dl.dropboxusercontent.com/u/23857782/Brad-Frost-Atomic-Design-CSS-Modules.png)

For the components I showcased, I used Polymer. As soon as browsers start implementing most of this browser standards, this won't be required anymore. Browsers will implement all the specs that are part of Web Components, such as Shadow Dom, Decorators, Custom Elements, Imports and Templates. Unlike the other parts of Web Components, Decorators don't have a specification yet; however, through Polymer, you can use most of the other features today.

This is just the beginning, and of course, I'm being quite optimistic about it. We will still engineer craft and tailored solutions. For instance, not everyone has Google+ problems, or their user base. Their solution is also crafted in order to reduce HTTP requests, which falls in the reign of Optimization more than Module Management. The components approach might not work right out of the box, and they probably have other things in mind. I bet the solutions used at Facebook are as complicated as Google+ or even more sophisticated. We will still need guidelines, and review poor coded components. We will need other architectures, ways to review components, structures to assemble them.

But still... the future looks shiny, and I'm interested in what's going to be next. [Brad Frost Atomic's Web Design](http://bradfrostweb.com/blog/post/atomic-web-design/) is a CSS methodology that help designers create entire systems. What if we can merge this kind of methodologies, and Web Components technology, to really start assembling reusable components? What if we can create business models through UIaaS providers, that can showcase pixel perfect native components suitable for our needs? What if someone can make a living out of carefully crafted responsive mobile ready components?
