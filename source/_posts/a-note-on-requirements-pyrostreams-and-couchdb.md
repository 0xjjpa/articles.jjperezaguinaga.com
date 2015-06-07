title: 'A note on Requirements, PyroStreams and CouchDB'
tags:
  - agile development
  - couchdb
  - knockoutjs
  - mysql
  - php
  - pyrostreams
  - requirements
  - software-development
  - zombie jesus
id: 199
categories:
  - Developer Stories
date: 2012-03-15 11:40:16
---

It seems like it has been forever since I wrote a post. Oh wait, it _has been forever_.

I know I was supposed to write a lot of posts, but honestly, I haven’t had enough time. As I’m writing, the clock displays 4:40 am and who knows at what time this post will be published. There’s a time where any developer is so overwhelmed with work that breathing is almost a gift. Currently, I’m holding two jobs (one for a project that was supposed to be turned in months ago and didn’t expect to have to do it again) as well as studying my B.S. trying to get at least A- in all my grades to hold two scholarships.

Bla bla bla, cry me a river, let’s move on. The reason why I’m writing down this post is first to apologize to the people that actually relied on some of the content here for their projects (like the PyroCMS ones, those got some views actually), and as a reminder for myself that I need to gather more tools in my development arsenal.

See, in my first job (not in the one with the project that was supposed to be done months ago), the project I’m working on is to create a web application that creates invoices for specific consulters within the company. It may sound easy, but the data that has to be hold within the invoice changes according the consultant. I’m not talking about the content itself, but the metadata; for instance, let’s say we have one consulter, and we store the default data such as first name, last name and email. Other contractor, however, requires country of origin and country of residence (it’s an international company).

I had two options back then: in my users table, I could put on a column for each field and just leave empty the ones that I was not going to use. Now, if you have a couple of cols like that, well, that wouldn’t be that bad right? The thing is that it wasn’t a couple of columns, but above 20 cols! I had a hundred of rows with tons of empty fields all over the place, and it took me a second to realize that was not the best approach.

The other option was to design the data model of the application with tables for each metadata required, and just query the id of each row form that table. That sounded good, but then using a MVC approach, that would make have a model for each table… and that would be just ridiculous. That’s when PyroStreams came in place.

PyroStreams ([http://parse19.com/pyrostreams/](http://parse19.com/pyrostreams/)) is a PyroCMS ([http://www.pyrocms.com/](http://www.pyrocms.com/)) add-on made by Adam Fairholm ([http://adamfairholm.com/](http://adamfairholm.com/)) from Parse19 ([http://parse19.com/](http://parse19.com/)) that allows you to structure data. After reviewing it for a couple minutes I thought “This is just what I need”. Instead of having to do the data model all by myself, I could just use a front-end to manage tables and relate them to a specific contractor.

So I bought PyroCMS Pro which includes PyroStreams and also allows multiple sites within an installation. That was not required for my project, but I thought that learning such a nice CMS was worth the shot. If you have 45 GBP lying around, go for it, it’s really worth the investment.

Now, I wish I could end up the story here, saying that all my problems were solved and that the project was delivered on time. Sadly, that’s not the case.

See, PyroStreams was not the solution for my problem. It had nothing to do with PyroStreams (although a minor bug with the multiple relationships data field stopped me to continue my testing, but Adam was gently enough to reimburse my purchase within days, thanks Adam!), but with the approach I was trying to take. I was trying to construct relationships in a data model were relationships didn’t exist!

It took me three weeks of development to realize that I just had a hammer, and my project looked like a giant nail to me, although it was close to being a nail as I am to being rich (I have two scholarships for college, you got the point).

So what happened? I was two weeks from deadline, my iteration was close to the beginning and I had only the front-end (which I made with KnockoutJS, awesome stuff, give it a try [http://knockoutjs.com/](http://knockoutjs.com/)). The back-end was done in PHP and MySQL but was useless for this project. I remember just sitting in my lovely cubicle staring the roof and being like “I’m screwed”. When I reach that point, I did what any reasonable developer would do: cry for help in any possible media in the world.

It didn’t take much to reach an answer from a friend at college: “Seems like you need to try CouchDB”. Unlike the conventional relational database manager, CouchDB ([http://couchdb.apache.org/](http://couchdb.apache.org/)) is based on documents, which allows you to pretty much specify a real world document within a database. No relationships, no empty columns, just documents. I learned it in one week, and worked overtime the next one to finish the iteration. Guess what? It worked wonders.

(I’m not going to talk about CouchDB, just google it. There’s plenty of stuff around, even a free online book [http://guide.couchdb.org/](http://guide.couchdb.org/))

Now I’m on my second iteration and I’m pretty confident about it delivering on time (I’m writing again!). Since now my body seems to demand some rest, I’ll sum up my learning in a bullet list so awake future Jesus (my name, you know, not the actual Jesus –right now I hate my name-) can use it for future projects. So Jesus, listen up:

*   If you see that a project requirements change constantly, you need to not only use an iterative agile development process, but also use a programming tool that allows you to quickly display prototypes. Learn Python and automate builds (Phing for PHP for instance) for god’s sake. Learn other ways to store data, what about MongoDB?
*   PHP and MySQL are awesome. You love them, I love them, everybody loves them (yeah, haters, go away). But sometimes you need to use different tools according to the needs of the project; there’s no silver bullet, and learning other tools will provide you with multiple options.
*   Keep checking on PyroStreams and PyroCMS; they look quite promising and the team is quite awesome. Also, check FuelPHP ([http://fuelphp.com/](http://fuelphp.com/)). Finally, don’t forget to buy Phil and Adam a beer for the awesome support.
Since I don’t use PyroCMS anymore, I don’t think I’ll keep writing on those, although maybe on a future I will. Future posts will be likely about CouchDB and my struggles learning it. I’ll keep you guys posted and I’ll make sure it doesn’t take me two months to write other post.