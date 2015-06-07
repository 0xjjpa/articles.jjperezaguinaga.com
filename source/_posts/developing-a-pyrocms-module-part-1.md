title: 'Developing a PyroCMS module: Part 1'
tags:
  - app environment
  - code editor
  - codeigniter
  - development framework
  - github
  - IDE
  - php
  - phpfog
  - programming
  - pyrocms
  - rapid application development
  - rational unified process
  - requirements
id: 31
categories:
  - Developer Stories
date: 2011-12-10 19:18:26
---

_This a small series of stories that I'm writing for a project I'm doing at my office. The focus is to describe all my programming techniques and steps, as well as tools and strategies used in order to create the project. The project involves creating a PyroCMS that handles information related to the company contractors._

Let's go to last week. I was assigned to create a project that handles information about the company contractors and helps them to update expenses and the amount of hours that they were working for the company. There I was figuring out how I was supposed to get it done.

**SOFTWARE DEVELOPMENT STRATEGY**

[caption id="attachment_39" align="alignleft" width="320" caption="The Rational Unified Process diagram"][![Rational Unified Process](http://jjperezaguinaga.files.wordpress.com/2011/12/rup.gif "RUP")](http://jjperezaguinaga.files.wordpress.com/2011/12/rup.gif)[/caption]

I'm a big fan of the Rational Unified Process (RUP), which uses an interative software development model in order to create software; it's based in 6 main steps and 4 stages. You can see the diagram at the left; the steps are Business Modeling (or Business Rules), Requirements (which includes Specifications), Analysis and Design (which includes Data Modeling), Implementation, Testing and Deployment. The 4 stages include Inception (which  is the limit of what can I do for a project for free, like, an overview of the project, and how much would that cost), Elaboration, which is the stage where you can consider the project is being worked on (and you should have been paid for), Construction, which depending on the amount of people in your team, can be divide in multiple sub-tasks and finally Transition, which is where you deploy the application, hand out all the manuals and make sure you get the last and final payment. As a rule of thumb, Transition is the stage where you start training the client to stop relying on you and start relying on the documentation provided.

Now, RUP is awesome, but it has a drawback: it's slow as hell. You can spend a whole week only in Business Modeling and Requirements, discussing with the client about what is supposed to happen. It's good when the client doesn't really have an idea of what the project is going to be like; he or she has just a business model, and wants YOU to make it happen. In my case, my boss had a really clear idea of what he wanted, he was just not sure how it was going to structured like. He wanted to see a prototype as fast as possible.

So let's ditch RUP and go for RAD. RAD stands for Rapid Application Development, which as its name suggest, prompts for quick prototyping. My task was to create something my boss could see within a week. Was I able to do that? Heck yeah.

TOOLKIT

After picking my Software Development Strategy, I had to start picking the following things:

*   App Environment: Will it be a desktop application or a web application?
*   Programming Language: Which one fits best the needs of the project?
*   Development Framework: Which one fits RAD best?
*   IDE: Which one integrates best all three of above?
**App Environment:** The application will be used by many clients around the world through multiple devices, sometimes not own by themselves (they work in multiple companies). A desktop solution will require them to download the client every single time. A web solution that works across multiple browsers will do the job. **Web** solution is it.

**Programming Language**: My experience in web includes PHP, Javascript, Java and Python. Java is everything but quick; Javascript can support me for the front-end, but I don't think node.js would be safe to use, as I don't manage the server the application will be hosted; Python and PHP are both options, but I'm better with PHP than I am with Python (and I still need to learn a few tricks with Python that I already know with PHP). **PHP** is then.

**Development Framework:** Here I only know CodeIgniter; now, the thing is, I will need to create a all the validation forms for users, all the users logic... no thanks, let's use PyroCMS, which is a CodeIgniter based CMS, that allows me to create modules complex enough to host the application. Of course I could also pick Joomla or Drupal, but I already have experience with **PyroCMS**.

**IDE:** I think I will settle with **Notepad++** for quick editions and **Netbeans** for actual development. Netbeans has a Git module integrated, and I can make it to auto complement PHP and CodeIgniter functions. Next time I'll try Aptana Studio, but I'm familiar with Netbeans, which behaves good with CSS and JS too.

Ok, so Software Development Strategy and Tookkit ready, what's next?

**DEVELOPMENT WORKFLOW**

In order to actually start developing, I need to structure how I'm going to move forward in the application development. I will use GIT for controlling my source code, then I'll push it to my host provider, which is [PHPFog](https://phpfog.com "Php Fog Cloud Hosting "). I will mirror the module creation with a local host for data manipulation and then I'll commit my changes to the repo, but only tags, since the development will be branched in a different repo.

(I think I will do a different post to illustrate this)

I have everything that I needed, so now it's time to work! No, wait I need something else, my playlist in Grooveshark! [Here](http://tinysong.com/p/2pkRH "Grooveshark Cloud Cult") is it, a Cloud Cult playlist, give it a try! See you next time!

Go the next part, [Developing a PyroCMS module: Part 2](http://jjperezaguinaga.wordpress.com/2011/12/11/developing-a-pyrocms-module-part-2/ "Developing a PyroCMS module").