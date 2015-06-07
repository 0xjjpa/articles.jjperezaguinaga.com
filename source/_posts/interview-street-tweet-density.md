title: 'Interview Street: Tweet Density'
id: 132
categories:
  - Developer Stories
date: 2012-01-08 03:43:27
tags:
---

_This is a post I'm making while I'm solving a problem on Interview Street. I'm training for a couple of interviews coming soon, and I though that this was a fun exercise to do. Feel free to check more [here](http://www.interviewstreet.com/recruit/challenges/dashboard/?randhash=b3633b88d30579ff9c2e9154b0c79521 "Interview Street"). Hours showed are on UTC -6, and the commits on my repo are published on my twitter. I'll be updating this post during the day._

**9:32 pm** Created new project on Xp-Dev.com to manage it, the bugs that appear and my git repo. Then created my project with [BluePrinter](http://codecanyon.net/item/blueprinter/304021 "BluePrinter") to load an instance of CI. Got hello world easy. Cmd &gt; bash (Cygwin loaded on PC) &gt; Gi init on project. Push on Xp-Dev, forgot that changed Public Keys, grabbed it from Github, all done.

**9:44 pm** Forgot to delete user guide. Hm. Let's go with a simple controller that displays the GET params. Using the native object $this-&gt;input to hande the requests. So far no problem. Commit #2

**9:52 pm** Reading Twitter API; GET statuses/user_timeline seems to be what I'm needing. Let's print a small example with file_get_contents(). Seems that that's good enough, I'll read deeper to see what are the limits of the request (how often, how many tweets can I retrieve). I'll fire up my javascript to load the json in my console.log, way cleaner than a php print_r(). Urgh, usually I would load a the html5 boilerplate on my view, but I don't have time, I'll just go with a basic structure that I already have on BluePrinter.

**10:05 pm** Silly me, put htpp instead of http on config.php; loaded jQuery to help me with selecting dom and parsing Json. Commit #3\. I'm able to retrieve my own tweets, but it has a bunch of metada that we don't need, and I also need to process it based on the date and the params on my webservice. Count is easy, let's do that one first.

**10:21 pm** Ugh. Took me more time that I though cause empty() and isset() behave weird on input-&gt;get(). Resolved with implied value assign. Commit #4.

**10:23 pm** Duh. I just realized handle is name. That's an easy one too. Now, we have to make sure user exists though; we will check on file_get_contents. I have to silence CodeIgniter for that though, so I will just need to remeber to hide warnings on production (or I could create a constante that checks in which environment I am, if not local, hide warnings. That could work).

**10:33 pm** So far nothing impressive; let's start processing our feed now. First, let's remove useless metadata. I just assigned include entities to false. I just noticed the first problem: the problem asks a webservice with an example of count=500, but twitter only allows a max of 200\. This is a good time to stand up, strech up a bit a think how to solve this.

**10:50 pm** After spending a good deal on the Twitter API, I found that even though I can only retrieve 200 tweets max per call, I can get tweets from different pages. Now, at most I can retrieve 3200 tweets from an user with this method, which seems fair enough, for I checked the examples provided and they don't seem to be able to grab more than that (actually, xefer can't grab all mine because of that, it stops on March 2011, even though I opened my acount before that).

Now I could go with xefer approach and try to load all tweets and then filter the ones I want. This sees rather inefficient, as the Twitter API already gives me the latest ones. If I'm right, then by retrieving 200 tweets I'm retrieving 10 pages of 20 tweets each. I'll proceed to do some tests to check this up.

**10:57 pm** Great! My theory stands. I was able to retrieve 2 different pages with two requests of 20 each. Would it work on 200?

**11:03 pm** Yes it does :) So now the processing is a matter of diving the count given in 200 and adding the module to a 10*(counter). For instance, if we receive 500, 500%200 = 3, so we will do one request of 200 of page (10*0)+1, one request of 200 of page (10*1)+1 and one request of 100 of page (10*2)+1\. Well, what am I waiting for?

**11:23 pm** There you go. I put each request on a hidden div with a class so my jQuery can grab each and parse it. If the user tries to retrieve more than 3200 tweets, the program will fail gracefully (empty hash). I'll commit right now and then do it.

**11:28 pm** Good. I'm able to parse any count of tweets as I want. The next is to actual build the required JSON.  It has to look something like [this](http://linode.interviewstreet.com/tasks/4890/response1.json "Json Tweetdensity"). Ready? Let's see what I can come up with next.

**11:43 pm** That wasn't that bad. Two foreachs in order to go through the array of requests and then one for the tweets in each request. This has a O(n²) time complexity performance, but since I have to go through each tweet, there's no other better way. If there were only other data that Twitter would provide me (e.g. tweet days, pages filtering based on months) then I could come up with something better. Let's move on the date problem.

**12:05 am** This one took me a little longer. I forgot how to handle some dates in Php! Anyway, I managed to get the created_at value from the tweet, the parse it to UNIX Timestamp and use the Date php object to get the hour for me. Since Twitter puts the local time, there's no need to perform any other operation. Now I just need to build the density array with a final for loop.

**12:14 am** I'm getting closer! Just cleaning up the JSON.

**12:30 am** Ah, had to change a few things since I was grabbing the request in javascript instead of php. Parsed it up and now trying to getting it in the right format.

**12:35 am** Json done! Commit #5

**1:07 am** XML is taking me a long time... I hate XML! I will have to keep researching on this one...

**1:22 am** I was looking for libraries to help me with the XML... then I remembered, I'm a developer! So I hardcoded the parsing myself. Nothing fancy as a class (although I could, but not at 1:30 am). Now I'm just looking for outputing the right header.

**1:35 am** XML ready! But... a wild bug appears! It's showing really small numbers for count=3200\. Let's dig on this.

**1:46 am** Yikes, still debugging and can't find what's wrong... this kind of bugs are really hard to catch, specially when relying on a third party API like Twitter... besides, at this time their servers may just be down.

**2:04 am** It seems I understood the Twitter API the wrong way. I'll have to re-read the pages part.

**2:10 am** Well, the good news are that I found the bug. It seems that pages don't chunk tweets in a 20 tweets bucket as I thought. So for instance, if I put count=3 and page=1, the third tweet will be the same as if I put count=1 and page=3\. This makes no sense, then what's the purpose of pages? I just did other test... count=200 &amp; page=1 tweet is the same as count=1 &amp; page = 200 but 201 is not the case.

**2:16 am** I just confirmed that Twitter API makes no sense on the page parameter. Only if its over 200 it will actually "turn" to other page, but if it is less than that, it will use the page as an index of the tweet that you are trying to retrieve. Let's see how we deal with this.

**2:25 am** Great, I exceeded the amount of requests per hour. Either I wait or go to sleep to start tomorrow again. Fine. Sleep will be, I wanted to finish this today, but Twitter is not helping. See you in a few hours.

**8:59 am** Back! Oh god I hate being sick. Where was I? Checking Twitter API *again* to grab 3200 API. My last test with page=0&amp;count=200 and page=9&amp;count=1 confirmed me that if I want to walk over the tweets I can only do it with count=200\. Oh, and page=0 and page=1 are the same.

**9:09 am** Basically what I will do is if count &gt; 200, I will have to grab 400, then only display the difference of the actual count. I don't like it (if count=201, I'll grab 400) but Twitter doesn't help me out here. Let's do this.

**9:29 am** FINALLY! I could verify that Twitter walks its tweets in chunks of 200\. If count &lt; 200, page will have no effect in the query. However, if its &gt;= 200, you can successfully walk on pages. Here's a couple screenshoots of how I proved it:

[![](http://jjperezaguinaga.files.wordpress.com/2012/01/firsttweet.png "FirstTweet")](http://jjperezaguinaga.files.wordpress.com/2012/01/firsttweet.png)

[![](http://jjperezaguinaga.files.wordpress.com/2012/01/lasttweet.png "LastTweet")](http://jjperezaguinaga.files.wordpress.com/2012/01/lasttweet.png)[![](http://jjperezaguinaga.files.wordpress.com/2012/01/tweetfeed.png "TweetFeed")](http://jjperezaguinaga.files.wordpress.com/2012/01/tweetfeed.png)

&nbsp;

&nbsp;

**9:32 am** Array_slice will be my friend to just get what I want.

**9:55 am** Done. Comit #6\. Now, before moving on, there's a problem that ocurred me yesterday: when the requests go over 150 per hour twitter will block you. I see that other pages are quite fast on loading previous results, which makes me think they are storing the results in some way. This strategy is called Dynamic Programing, quite useful to speed information queries; the principle is simple, if you have load it before, display it. If you haven't, load it and save it to use it later. Obviously this impacts storage, but in exchange of time performance (the Tao of Programming) doesn't seem a bad exchange, as long as we can put a limit on the storage.

Would it be safe to store all the information in a database? See, a xml request of 200 tweets is about 2KB. Would it be safe to say that one of 3200 has about 16kb per user? 100 users will then have around 1.56 mgbs if all of them request their timelines. Depending on the non-functional requirements, this could be already too much.

What would be the best way to store the information? We could use the parameters of the query given and give a database a structure... How often would we be required to refresh the user timeline? Again, a non-functional requirement.

I think I'm overthinking this. I need more information to know if the tweets should be stored or not, so for now I won't store them and go for the HTML web service, the last one.

**10:18 am** Aww. I wanted to use Protovis (or actually D3.js) to display the html, but it uses only svg, which may or not be useful for the web service. Let's go for Google Charts then, which uses svg when supported, and older formats when required.

**11:09 am** Goole charts is annoying but I almost got a hold on it. I'm almost done!

[![](http://jjperezaguinaga.files.wordpress.com/2012/01/html.png "HTML")](http://jjperezaguinaga.files.wordpress.com/2012/01/html.png)

**11:20 am Done!** Check it out!

[![](http://jjperezaguinaga.files.wordpress.com/2012/01/html2.png "HTML2")](http://jjperezaguinaga.files.wordpress.com/2012/01/html2.png)

**11:22 am** Commit #7\. I will do more testing, but I may have reached my limit quota on my local machine, so I'm deploying on my phpfog cloud. Here it is: [http://tweetdensity.phpfogapp.com/?handle=jjperezaguinaga&amp;count=20&amp;type=xml](http://tweetdensity.phpfogapp.com/?handle=jjperezaguinaga&amp;count=20&amp;type=xml). The html version doesn't load (dunno why), but I need to have breakfast first, I'm starving. I need to fix the html version on deployment and then test, then test, then test, and well, test. Finally, after that, I will deploy the application in the EC2 instance that they offered.

**12:23 pm** Back! I forgot that phpfog disables file_get_contents from remote URLS. I think I'm used to file_get_contents(), but cURL should be good enough. I'll post the changes.

**12:32 pm** And had to restart my xampp because cURL was not being loaded. I think it's showtime! I'll get the EC2 instance and deploy there, either using file_get_contents (if it's allowed) or cURL. Oh, by the way, I used only one library for cURL, one made by Phil Sturgeon, one of the makers of CI and PyroCMS (so it's safe to use).

**1:05 pm** Alive! Got my EC2 with Apache2 up and running. Here it is! (will be valid only for one hour) http://ec2-107-20-88-64.compute-1.amazonaws.com

**2:02 pm** I concluded the Tweet Density Exercise, didn't update on the last hour because I was deploying like crazy the application. You can see it on my [GitHub](https://github.com/jjperezaguinaga/Tweet-Density "Tweet Density"), although I will likely deploy in on phpFog as soon as I fix my cURL errors.

Let's see hope for the best on my test cases. I have to admit that it was a lot, but a lot of fun. Unlike some algorithm exercises that I'm used to do on UVA Online Judge or TopCoder, this was applied CS and I just loved it. I couldn't type all the ideas that crossed my minds but all kind of data structures passed right through my mind when trying to solving the multiple problems this problem had.

Feel like coding a problem? Check the guys at [Interview Street](http://www.interviewstreet.com/recruit/challenges/dashboard/?randhash=b3633b88d30579ff9c2e9154b0c79521 "Interview Street Challenges")! They have plenty for us.