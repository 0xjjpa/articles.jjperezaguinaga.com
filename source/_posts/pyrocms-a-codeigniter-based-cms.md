title: 'PyroCMS: A CodeIgniter based CMS'
tags:
  - codeigniter
  - developer
  - github
  - helpers
  - modules
  - php
  - plugins
  - pyrocms
  - tag syntax
  - widgets
id: 28
categories:
  - Developer Stories
date: 2011-12-06 01:20:45
---

About a year ago, I started PHP development with CodeIgniter (as I describe [here](http://jjperezaguinaga.wordpress.com/2011/12/01/codeigniter-not-just-other-php-framework/ "A note about CodeIgniter")), and after developing a couple of projects I was able to see a pattern in most of them (e.g. restricted area, updatable content, email newsletters). I was not the only guy that saw that, and as a result the team of [PyroCMS](http://pyrocms.com "PyroCMS") developed its CodeIgniter based CMS solution. Here's a small introduction to PyroCMS.

PyroCMS is based on a modular MVC design, (or as [some](http://net.tutsplus.com/tutorials/php/hvmc-an-introduction-and-application/ "An introduction to HMVC") people refer to, hierarchy of parent-child MVC layers). This means that instead of only relying in the logic of controllers, a system can manage modules that allow to extend the functionality of other modules, including its models, views and controllers. This way, each module is isolated from the logic of the other ones, increasing the portability of the applications. Using PyroCMS, any developer can create modules can be literally drag-and-dropped into a webpage without any fuzz.

PyroCMS divides its modules in three categories, although only real modules are called modules (can't believe I repeated modules that many times). **[Widgets](http://www.pyrocms.com/docs/2.0/manuals/developers/creating-custom-widgets "Widgets in PyroCMS") **are small applications that can be dropped within a webpage with ease; they are the smallest kind of app that can be developed without actually coding that much. **[Plugins](http://www.pyrocms.com/docs/2.0/manuals/developers/creating-custom-plugins "PyroCMS Plugins")** are small applications too, but that rely on the PyroCMS [Tag Syntax](http://www.pyrocms.com/docs/2.0/manuals/designers/tag-syntax "Tag Syntax") in order to create a specific functionality within the webpage; this provides more flexibility on programming, although it may be a little more complicated to learn. Finally, **[Modules](http://www.pyrocms.com/docs/2.0/manuals/developers/creating-custom-modules "PyroCMS Modules")** are full-powered applications that resemble libraries in CodeIgniter but actually can nest libraries and even helpers by themselves (they even have their own config files!); their logic is more like a Wordpress Plugin, where you install and uninstall plugins that can interact with any element of Wordpress.

As an example, I would use **Widget for a html template** that will be rendered in the webpage multiple times; a calendar, an rss feed (actually PyroCMS has some default widgets, including Google Maps, RSS feed and Twitter feed); I would code a **Plugin for an input form** in order to post feedback from my webpage, or to push information from my database (the Tag Syntax really rocks). Finally I would code a **Module for an invoice system** within my application; a few input fields for my back-end, the front-end logic, and the interaction with both through the models and controllers.

Finally, since PyroCMS is still growing, it's worth to notice that some functionality is still undergoing maintenance (see [Roadmap](https://github.com/pyrocms/pyrocms/issues/milestones "PyroCMS roadmap")); feel free to fork or watch the project in [Github](https://github.com/pyrocms/pyrocms "PyroCMS Github") and post any issue you see!

_P.S. I know most of my posts had been plain texts, but my next one will be about implementing a plugin from scratch in PyroCMS; I think I'll publish it in EE or maybe in Net Tuts (if they want to), so stay tuned!_