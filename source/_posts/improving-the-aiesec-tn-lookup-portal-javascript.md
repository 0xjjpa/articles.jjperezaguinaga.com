title: 'Improving the AIESEC TN Lookup Portal [Javascript]'
tags:
  - AIESEC
  - chrome
  - console
  - dirty
  - internship
  - javascript
  - LC
  - OGX
  - portal
  - quick
  - summer
id: 202
categories:
  - Developer Stories
date: 2012-03-16 05:43:26
---

About a month ago I enrolled myself in [AIESEC](http://www.aiesec.org/ "AIESEC"), which for those who are too lazy to click on the link, is the biggest international organization made by young people; it's recognized by the UN and it's in over 110 countries. Through global interchanges and social programs we want to fulfill one goal: achieve world peace. Isn't that lovely?

Through AIESEC, I'll be likely going for GIP (Global Internship Program) this summer, in order to increase my technical skills in some areas (Software Engineering, Web Development), get to know other culture and share the awesomeness of the mexican culture. In order to do that, I need to look up for an organization enrolled in the AIESEC program; companies pay a fee in order to get in our database and from there they can pick students for a specific internships, and in the same way students pick a company (TN, Traineeship Nominee).

(Sorry about the background, I'll get to the point soon).

In order to see the database of TN, you go to the portal, made by our awesome global partner [TATA Consultant Services](http://www.tcs.com/homepage/Pages/default.aspx "TATA"), and then retrieve the ones you like the most (there's a bunch of other complicated procedures before applying to an internship that I won't go on, but that's the basic process).  Now, even though TATA did an amazing job with the whole portal, after a while trying the TN lookup part, I'm suspecting the Front-End engineer had too many breaks when designing it.

**Problems**

The first problem when trying to retrieve TN's is that there are at least two ways to get them. The first one makes you put the "Earliest Start Date" for your internship. This works, but some of the TN's specify a big time frame that not necessarily fits yours. For instance, let's say that I just want to do a summer internship, so I put only May to August. This will pop only those that it's start date goes from (duh) May, but for instance, avoid those who are preferred from before. So if company X puts that it's looking for a 16 weeks internship between January 1st of 2012 and December 31 of 2012... well, I'm pretty sure they mean anytime within the year.

[caption id="attachment_203" align="alignnone" width="590" caption="Browse Internships 1st option UI."][![](http://jjperezaguinaga.files.wordpress.com/2012/03/internships.png "Internships")](http://jjperezaguinaga.files.wordpress.com/2012/03/internships.png)[/caption]

In the sidebar, you can filter your areas, and that's pretty neat, but it doesn't say if you they are exclusive or just part of the data mining search; again, let's say Company X is looking experience in A and B in a student, and I have only B. Will it show up for me? The same way, Company X is looking for A and I say I have experience in both. Will it exclude Company X because it just needs A?

The other option is better, since it allows you to filter on country and weekframes of internship.

[caption id="attachment_204" align="alignnone" width="590" caption="Browse Internships UI option 2."][![](http://jjperezaguinaga.files.wordpress.com/2012/03/internships2.png "Internships2")](http://jjperezaguinaga.files.wordpress.com/2012/03/internships2.png)[/caption]

_Note of the author: Yeah, I think I should be diagnosed OCD because that not aligned  Search button just drives me crazy. Hey, you, yeah, the one that wrote the CSS. Have you ever heard of you know, divs? float? margins? What? Tables you say? Oh god, get out of here._

Looks good right? Well, yes it does, and it actually displays the internships per area, which is really nice (that's why it's called Demand Ranking). That way, you don't have to put skills that fit in an area but look up for an area instead. After you click on your area, a window will show up a list of internships with the companies and countries on them! Good! The information stops there though, because if you want to see more of that internship, guess what, you have to click on them.

_Note of the author: I mean, why don't just hover and show up some nice catch things? What happened to tooltips? You know, show up the requirements! The minimum weeks! The salary! Make me CLICK on you, give me a reason into why I have to perform a whole load request of a single item._

Excellent! Let's say that with the country and the company name you decided for one and click on it. A pop-up will appear with the content of the internship.

_Note of the author: Yes, a ghost of the 90's, a witness of our beloved so dead 0.5 web shows up. POP-UPS? Really? Ok, so maybe you want your grandpa to notice something in your webpage. Yeah, a pop-up may work. But for young people? What do you need my attention for? Who decided on that? Are you displaying a banner? Oh, let me bookmark that internship... wait, you CAN'T, because it's within a pop-frigging-up._

Way to go! Now, if you liked the internship, you save up the TN Id and then use it for later. When you close, you may have to scroll down because the webpage won't be save up which internship you click (neither focus it); it will just refresh the webpage and make you check again where you started.

_Note of the author: HTTP Referer? Anchors? Anyone?_

Remember our filters? well, there are no more filters, so if you want to check other information such as requirements, salary, objectives, goal, whatever, you had to click. On each. one. internship.

As my OCD side noted in italic, after doing this for 20 minutes this is probably who I looked like:

[caption id="attachment_205" align="alignnone" width="500" caption="Don't do this to a front-end developer obsessed with UX."][![](http://jjperezaguinaga.files.wordpress.com/2012/03/gun.jpg "Gun")](http://jjperezaguinaga.files.wordpress.com/2012/03/gun.jpg)[/caption]

**Me, ROBOT.**

See, the problem with all this is not only the horrible User Experience, but also the lack of data visualization. The portal is not helping the students at all to pick an internship. If that was not enough, I felt like a robot performing the SAME action over and over again. The one reason why I'm a developer is because I love to AUTOMATE things, my goal is to increase PRODUCTIVITY, not to diminish it in people's life!

So I though; "Ok, you are a developer, you can do something about this". I wrote down what I would want the portal to do for me in a bullet list:

*   Summarize the most important content of a specific internship
*   Compare and filter internships from a specific field
Having some goals in mind, I thought well, let's create an application right? Let's check on the business rules first:

First, I can't query the database from an outside application, since that would have legal issues, as the database is property of AIESEC, and even though I'm part of it, I have by no means legal rights to store or copy the information (specially as companies pay a fee to AIESEC to be there).

Second, TATA created a portal to provide an interface to the database; I could create a cliet that uses the AIESEC student credentials, but that may present an overhead for the portal, and could be seen as potential attacks or DOS. As half a system administrator, I wouldn't like gettings tons of request from an unknown source. Even a head-less browser in Python could make a sysadmin twitch. If I wanted to manipulate the data, I could only use what TATA allows students to use: a browser.

If I could sum up the application in one line, it would be the following:

<span style="color:#ff0000;">**The application must sum up the contents of the internships, allowing users to filter and compare specific fields from the internship. I can only use a browser, and by no means I can store or copy the internships data**</span>.

So first, the business rules. I know a specific tool that can solve those requirements easily: Javascript. Since javascript is a client-side language, I will only provide the functionality **anyone** can do. I will use the engine within the browser so **no outside application **will query the database. Actually, I will use the browser for it!

Behold, the Google Chrome console:

[![](http://jjperezaguinaga.files.wordpress.com/2012/03/console.png "console")](http://jjperezaguinaga.files.wordpress.com/2012/03/console.png)

The Google Chrome console is displayed in a webpage by right clicking on a webpage and select the bottom option that reads "Inspect Element"; from there, you can go to the console option and write down full-powered Javascript directly to a webpage. Safari and all web-kit based browsers have this feature (in Firefox Firebug has the same functionality).

So what if we put there our custom made juicy javascript? Here's the script!

[http://aiesec-crawler.xpdev-hosted.com/readTN.js](http://aiesec-crawler.xpdev-hosted.com/readTN.js)

Although it's not perfect, it serves the simple purpose of loading all the internships from within the system. Let's see how to use AIESEC'rs!

First, let's go to Demand Ranking (under AIESEC Programmes). Pick your region, country or just a global internship; then, select an area and open it in a new tab.

Second, let's fire up our Google Chrome console and past the following code (just click in the little paste bin icon at the top right). Then press enter.

[sourcecode language="javascript"]
var script=document.createElement(&quot;script&quot;);script.type=&quot;text/javascript&quot;;script.src=&quot;http://aiesec-crawler.xpdev-hosted.com/readTN.js&quot;;document.body.appendChild(script)
[/sourcecode]

If everything went right, you should be able to see something like this:

[![](http://jjperezaguinaga.files.wordpress.com/2012/03/script.png "Script")](http://jjperezaguinaga.files.wordpress.com/2012/03/script.png)

There are few things that can happen; the first one is that a red error pops it. Ignore it, press up and then enter again. If no errors show, then write down "Fields", and a couple fields will show up. Those are the fields that will be displayed for each TN. You can add some of using the command add() and a field like one of the following:

Department the intern will be working
Job Description1
Job Description2
Working Hours
Internship Earliest Start Date
Degree

(You can add any field that it's within a specific TN, so open one, see the gray colored column titles, copy and paste it).

So for instance, let's say we want to see working hours too for all those TN:

[![](http://jjperezaguinaga.files.wordpress.com/2012/03/add.png "add")](http://jjperezaguinaga.files.wordpress.com/2012/03/add.png)

Don't forget the quotes! When you are ready to see the magic happen, type "run();". I'll try to work on a UI later but right now I'm too busy; I'll be sharing this with my LC (Local Committee) and share it with more OGX members.

That's all for today! This was just a simple script that I made in about an hour, so it's not the most perfect or fancy one. I'll try to keep adding features to this script, such as hiding some of the TN's and other things. Any ideas?

&nbsp;