title: "Why can't we find Front End developers?"
tags:
  - css
  - front end engineering
  - interface
  - javascript
  - ux
  - web development
id: 406
categories:
  - Developer Stories
date: 2014-03-19 13:30:31
---

The other day I stumbled upon a [Quora's question related to Front End Engineering and Startups](http://www.reddit.com/r/javascript/comments/14zwpv/why_are_front_end_developers_so_high_in_demand_at/ "Why are Front End developers at high demand?") on "Why is it that startups have trouble finding front end developers?". The OP adds the following notes:
> (...) I think most people would agree that front end development is much easier than other fields of engineering. So why is it that startups have trouble finding front end developers?

I saw a few good answers, and most of them go straight to the point. Here's my own opinion, based on my work experience, looking for Front End jobs, interviewing Front End Engineers, and working on Front End projects on the daily basis.<!--more-->

# Relatively new field

The first and easiest answer to “Why can't we find Front End developers” is because **it's a new field**. Most people would disagree about this statement, since Front End Engineering is similar to Web Development, and Web Development has been around for more than 20 years. However, **the concept of Front End Engineering as** **the technical implementation of interfaces and user experiences as a specific “working” field**, is definitely quite new. **The “Engineering” part to Front End started to grow just few years ago.****

 **
[caption id="" align="aligncenter" width="639"][![A visualisation of the Front End Engineer trend in the last few years by Google Trends.](http://jjperezaguinaga.files.wordpress.com/2014/03/google-trends-front-end-engineer.png "Front End Engineering Google Trends")](http://jjperezaguinaga.files.wordpress.com/2014/03/google-trends-front-end-engineer.png) A visualisation of the Front End Engineer trend in the last few years by Google Trends.[/caption]

No one is to be blamed for this whole Web Development vs Front End Engineering confusion that circulates even today; for most people outside of the Web industry, **Web Development is a blurry line between the Visual Design of a webpage, and the technical implementation of it**; after all, Web Development is something Front End Engineers do, with the exception that **Front End Engineers focus only on the areas that involve the users.**

The concept of having a name for just the technical implementation of interfaces and user experiences as a working field started just recently. Fifteen or more years ago, resources were equally distributed between the Visual Design of a webpage and the technical implementations of the same; with the growth of the Web as something more than just a landing/marketing page, the need of more engineers resources became apparent. People started to learn Javascript, Backend technologies, UX, Databases, and even System Design only for the web. Today, **a Web Application like AirBnB, Facebook, or Quora, has way more Engineering resources invested than Design resources**; in other words, nowadays it's “faster” to come up with the Visual Design of a Webpage, than implementing it. **This** **doesn't mean that Visual Design is less important, or fewer resources are allocated into the Visual Design area compared to 20 years ago, but that a higher supply for Engineers is required for today's webpages demand**.
[caption id="attachment_450" align="aligncenter" width="639"][![Current Web Products require more Engineering resources than Visual Design resources.](http://jjperezaguinaga.files.wordpress.com/2014/03/webproduct.jpg "Web Product Resources")](http://jjperezaguinaga.files.wordpress.com/2014/03/webproduct.jpg) Current Web Applications require more Engineering resources than Visual Design resources.[/caption]

Since the technical implementation of a Web Application involves multiple areas, in the 90's Web “Engineers” were a bunch of **jack of all trades**: they were from temporal DBA's (Database Administrators) and SysAdmins (System Administrators), to Backend Engineers, DevOps, Software Engineers, UX Engineers and Front End Engineers. The latest was probably the layer people dreaded the most, tinkering with Javascript, HTML and CSS in order to make a Visual mock up make sense in all these things called browsers. **To enjoy Front End Engineering you must have some interest into Visual Design (and be kind of a masochist). **
[caption id="" align="aligncenter" width="639"][![This gif is still used to represent the pain that most beginners Front Engineers go through.](http://jjperezaguinaga.files.wordpress.com/2014/03/cssgif.gif "Playing with CSS")](http://jjperezaguinaga.files.wordpress.com/2014/03/cssgif.gif) This gif is still used to represent the pain that most beginners Front Engineers go through; CSS is the styling language used to make Visual Designs look properly inside a webpage. Most of the times it doesn't behave as you would expect it to.[/caption]

It became obvious after some time that in order to deal with the amount of work Web Applications required, a division of the technical tasks was needed in order to have multiple people to work in the Web Application. I don't know which task took the most amount of time, or which one was the hardest[1], but the fact that it was no longer possible to have a person to handle all the technical details soon became a concern in multiple web agencies and companies. As a result, all the previous Job Descriptions I used before (Backend Engineer, DBA, etc) got involved into to the Web Industry; take a note that **most of theses jobs had been around for ages, but having proper requirements for them inside of the Web Industry is something that started probably within the last 10 years**.
[caption id="attachment_466" align="aligncenter" width="639"][![Chart is relative, some products might not require all the “Web Stack”](http://jjperezaguinaga.files.wordpress.com/2014/03/webproducttoday.jpg "Web Product Requirements in Engineering")](http://jjperezaguinaga.files.wordpress.com/2014/03/webproducttoday.jpg) Nowadays we still have some poor souls that have to handle all the technical implementations of a Web Application; we call them Full Stack Engineers, and the really good ones are so few that it's easier finding unicorns[2]. Designers don't have it easy neither, refer to How to Hire Designers (https://insideintercom.io/how-to-hire-designers/) for more information.[/caption]

Nowadays Startups have it clear that if they want to succeed, they need to properly cover many technical areas of a Web Application: Front End, Backend, DBA, Operations and so on. PaaS (Platform as a Service) were created with the sole purpose of removing the Operations need from a Startup, while multiple BaaS (Backend as a Service) services such as [Parse.com](https://parse.com/ "Parse.com"), go as far as proving database schemas and endpoints for your applications (you still need someone to help you designing the Schema though). Front End hasn't been “serviced” yet, but there are [a few services out there](http://designmodo.com/startup/ "Designmodo Startup Framework") that allows you to buy Front End modules and components for your landing page; if you want to create the actual Web Application, there's no way around getting a good Front End Engineer, the same way you can't get your way around a Designer if you want to actually build a brand.

<small>[1] That's a lie, making a site functional in IE was the most time consuming task. You also lost some sort of life points when doing so.</small>

<small>[2] Most Full Stack Engineers lack depth in the skills required to create a full Web Application, either in the Front End side, Backend or Operations. Expecting a single person to handle the tasks that at least 3 people do full-time in an average well-funded Startup is unrealistic. However, I know a few ninja's out there that can tackle from a GUI to a zombie process; if you have one of those in your team, do everyone a favor and never let them go.</small>

# Misconceptions

Another important reason (and in my opinion the most important one) on why finding Front End is hard, is because it is **a misunderstood field**. As the OP of the original question described, most people think that Front End is a “relatively easier field”. In the old fashion “_What most people...”_, here's a detail on what Front End Engineers do:

**What most people think Front Engineering is**:

1.  Taking a Photoshop file, Image, or Wireframe and making it into a webpage.
2.  Sometimes design previous Photoshop file, Image or Wireframe.
3.  Code Javascript, which creates animations and makes transitions inside a webpage.
4.  Code HTML and CSS, which defines content and styling inside a webpage.

**What Front End Engineers actually do:**

1.  Establish a visual language between Designers and Engineers
2.  From a Visual Design, define a set of components that represent content, brand, features, etc.
3.  Establish a baseline for the Web Application in terms of conventions, frameworks, requirements, visual languages and specs.
4.  Define the scope of the Web Application in terms of devices, browsers, screens, animations.
5.  Develop a Quality Assurance guideline to ensure brand fidelity, code quality, review of product by stakeholders.
6.  Style the Web Application with proper spacings, typography, headings, face fonts, icons, margins, paddings, grids and so on.
7.  Style the Web Application with multiple resolution images, device oriented mockups, all while taking care of design guidelines.
8.  Markup the Web Application taking into account semantics, accessibility, SEO, schemas and microformats.
9.  Connect to an API to retrieve information in a friendly, non-battery consuming, device and client aware way.
10.  Develop client side code to perform smooth animations, transitions, lazy loading, interactions, application workflows, most of the time taking into consideration progressive enhancement and backwards compatible standards.
11.  Ensure Backend connections are secure, taking Cross Origin Resource Sharing (CORS) procedures into account, protect against Cross Site Scripting (XSS) and Cross Site Request Forgery (CSRF).
12.  Never forgetting that despite strict deadlines, stakeholders requests, and device limitations, **the User is, and will always be first**.

In order to achieve aforementioned goals, Front End Engineers use many tools that range from Visual Design tools (Photoshop, Adobe, Macaw, Sketch), to Programming Tools (IDE's, Command Line, Source Version Control, Bash scripts, Build tasks). Sometimes we even have to take care of Marketing (Newsletters, Campaigns, Analytics, SEO, Social Media), UX (animations, transitions, feedback, interfaces, visual language) to Content tweakes (breakpoints, avoiding orphan words, readability, colors).

# Bad Front End Engineers

Probably the most obvious reason on why it's hard to find good Front End Engineers, is because there are **many ****bad Front End Engineers. **As correctly stated by one of the answers inside the [Quora's post](http://www.quora.com/Startups/Why-are-front-end-developers-so-high-in-demand-at-startups-if-front-end-development-is-relatively-easier-than-other-fields-of-engineering "Quora Why FE hard to Find?"), Front End Engineering has a **really low entry barrier. **Javascript, CSS and HTML are not hard programming languages to grasp. Anyone can go to [CodeAcademy](http://www.codecademy.com/ "Code Academy") or [Codeschool](https://www.codeschool.com/ "Codeschool") and learn the basics within days, while learning things like Erlang (one of my favorite programming languages), Go or even ANSI C, requires you to grasp many of the mechanics of a computer. **Tweaking colours and images inside a webpage it's actually pretty easy, while understanding the underbelly of the Web is a whole different thing**.

At the end, the Front End Engineer market is plagued with guys that do many of the following:

**What bad Front End Engineerings do (and thus hurting real Front End Engineers):**

1.  Abuse of Javascript Libraries, since they don't really know the internals of Javascript (e.g. jQuery for everything).
2.  Abuse of Javascript Plugins, using other people's code without been able to even read it (e.g.  jQuery.doParallaxPls.js).
3.  Add to Web Application CSS Frameworks (Bootstrap, Foundation, Skeleton) while using 5% of the CSS/JS, without seeing any requirements, designs, or performing any kind of comparison/evaluation.
4.  Feed the idea that just because you add CSS Framework, a site is “Responsive”, or that responsiveness is some sort of spice you can just sprinkle into a Web Application at any time.
5.  Talking about “Responsive Web Design”, but being unaware of Server side techniques.
6.  Coding CSS without conventions, preprocessors, naming standards, good practices, and at the same time writing CSS with over qualified selectors, ids, magic numbers, !important.
7.  Ignoring performance, memory leaks (not knowing what's a memory leak _really _is), failing to audit their code or measure it.
8.  Presenting a product without any kind of metrics, or the metrics being “It works on my Computer/Browser/Device”™
9.  Pretty much creating Software while Ignoring 30 years of Software Engineering.

Most of the time you want a **Computer Science **guy or girl that **then decided to work with Front End Engineering. **It's not a requirement to have a CS background to be a good Front End Engineer, **but the fundamental mechanics of Computing and Software should always be taking into account even if you are coding in Javascript or in a browser. **Good Front End Engineers know that the web is probably one of the most powerful platforms and environments that exists, and as such, the code that is executed there, **must** be developed with the same care (or even more) than any other language in any other virtual machine or runtime.

A good Front End Engineer will not only take in account the mechanics of the Web and the languages it uses, but also has experiences in all the different components, systems, and concepts than interact with it. Here's a few things that an experienced Front End Engineer should know or do on top of just the normal Front End Engineering tasks:

**What experienced Front End Engineers need to know and do on top of good Front End Engineers **** (hint: this are the ones you want to hire)**:

1.  DNS Resolution, usage of Content Delivery Networks (CDN), and performance on multiple Hostnames as part of resources requests.
2.  HTTP Headers (Expires, Cache-Control, If-Modified-Since)
3.  All rules from Steve Souders ([High Performance Websites](http://shop.oreilly.com/product/9780596529307.do "Steve Souders High Performance Website"))
4.  How to solve all problems showd by PageSpeed, YSlow, Chrome Dev Tools Audit, Chrome Dev Tools Timeline.
5.  When to leverage tasks to the server and when to the client.
6.  Usage of cache, pre-fetching and post-load techniques
7.  Native Javascript, knowing when to do something from scratch and when to look up for someone else code, and at the same time being able to evaluate the pros and cons of doing so.
8.  Knowledge and usage of modern MVC Javascript libraries (e.g. AngularJS, EmberJS, ReactJS), graphic libraries (e.g. D3, SnapSVG), DOM manipulation libraries (e.g. jQuery, Zepto), lazy loading or package management libraries (e.g. RequireJS, CommonJS), task managers (e.g. Grunt, Gulp), package managers (e.g. Bower, Componentjs) and testing (e.g. Protractor, Selenium).
9.  Image Formats, benefits, when to use which one and how, Image Optimisation techniques, and loading strategies (sprites, lazy loading techniques, cache flushing, PNG interlaced)
10.  Knowledge and usage of CSS Standards, modern conventions and strategies (e.g. BEM, SMACSS, OOCSS)
11.  The Computer Science of Javascript (memory management, single threaded nature, garbage collector algorithms, timeouts, scoping, hoisting, patterns)

# Conclusion

<span style="line-height:1.5em;">Today, more than ever, **the web has a place for Front End Engineers**. It was probably due the evolution of multiple devices, browsers and Web Standards, that made it urgent finding people that focuses on the user side of Web Applications. Front End Engineers and developers around the world had been able to shape exciting products that defy the scope of what we thought the Web was ever going to be: a place to see your a restaurant menu or a company offices' hours. Now we have from entire [3D galleries](http://threejs.org/ "Three JS 3d Animation Library"), [real time Video communication](http://www.html5rocks.com/en/tutorials/webrtc/basics/?redirect_from_locale=de "WebRtc Example"), [Radio Stations](http://grooveshark.com/ "Grooveshark Online Radio Station"), and even entire Office Tools (e.g. Google Apps, Microsoft Office Online). All now on top of  **the Cloud, **the omnipresent entity that stores everything we write, listen, email and watch. </span>

<span style="line-height:1.5em;">Although is hard to find Front End Engineers, I know that more and more people will join the ranks of the Front End army. Not only because of amazing work environments or big pay checks most Front End Engineers job offer, but also because coding in the web is incredible exciting: you have the chance of touching the life of thousand of users, while providing thrilling services to anyone with an internet connection, all of this on top of these things called Browsers, that despite its limitations, they are able to parse, paint and render any kind of crazy ideas. Godspeed Front End Engineers, the Web is waiting for you.</span>