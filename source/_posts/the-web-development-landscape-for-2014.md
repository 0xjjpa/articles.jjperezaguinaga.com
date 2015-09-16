title: The Web Development Landscape for 2014
tags:
  - angularjs
  - BaaS
  - css
  - emberjs
  - javascript
  - offline first
  - svg
  - UIaaS
  - Web Components
  - web development
  - yeoman
id: 362
categories:
  - Developer Stories
date: 2014-01-14 16:35:43
---

2013 was a great year for Web Development. Javascript [Single Page Application](http://en.wikipedia.org/wiki/Single-page_application "Single Page Application Definition") technologies like [AngularJS](http://angularjs.org/ "AngularJS") had [a tremendous growth](http://www.google.com/trends/explore#q=angularjs&amp;cmpt=q "Google Trends for AngularJS") during the year, because even though learning AngularJS can be [really hard](http://jjperezaguinaga.com/2013/09/21/angularjs-is-amazing-and-hard-as-hell/ "AngularJS is Amazing and Hard as Hell"), it allows you to create amazing [applications](http://builtwith.angularjs.org/ "Built with AngularJS") and [animations](http://jjperezaguinaga.com/2013/07/16/angularjs-scroll-animations/ "AngularJS Scroll Animations"). During 2013, web content driven companies like Techcrunch, Guardian and BBC News, invested an enormous amount of time and resources in order to push the web further: from doing a [full responsive redesign ](http://bradfrostweb.com/blog/post/techcrunch/ "Responsive Redesign for Techcrunch by Brad Frost")(Techcrunch), releasing their front end framework ([Guardian](https://github.com/guardian/frontend "Guardian Frontend Framework")), to developing tailor made applications for viewport testing with image diff tools ([BBC News](https://github.com/BBC-News/wraith "BBC News Github Image Diff Testing Project")).

If that were not enough, a good deal of standards, strategies and libraries, are gaining momentum over the web development community: [Flexbox](http://css-tricks.com/snippets/css/a-guide-to-flexbox/ "A guide to Flexbox") is becoming [more and more popular](http://www.google.com/trends/explore#q=flexbox "Google Trends on Flexbox"), by [showcasing scenarios](http://philipwalton.github.io/solved-by-flexbox/ "Solved by Flexbox") where CSS layout techniques were never enough; it even allows us to do [Content Choreography](http://www.jordanm.co.uk/lab/contentchoreography "Content Choreography with Flexbox") and by now [it's quite well supported](http://caniuse.com/#search=flexbox "Flexbox Support") (just don't get too excited for [mobile quite yet](http://onmobile.iwanttouse.com/#flexbox "Flexbox support on Mobile")). [Atomic Design](http://bradfrostweb.com/blog/post/atomic-web-design/ "Atomic Web Design"), an ideology and strategy coined by [Brad Frost](http://bradfrostweb.com/ "Brad Frost Homepage"), became quite popular too; it separates the structure of our designs in "atoms" and joins them into components ("modules") that will later become pages and web products. In conjunction with other [practices](http://csswizardry.com/2013/07/writing-dryer-vanilla-css/ "DRY Css by Harry Roberts") and [methodologies](http://csswizardry.com/2013/01/mindbemding-getting-your-head-round-bem-syntax/ "BEM as a CSS methodology"), CSS has become an easier code to maintain and has been pushed to [its limits](http://codepen.io/thebabydino/pen/uihbK "3D CSS"). Workflow tools like [Yeoman](http://yeoman.io/ "Yeoman") and [Grunt](http://gruntjs.com/ "GruntJS") allows us to [create mobile responsive web projects](https://github.com/yeoman/generator-mobile "Web Mobile Generator") in less than 5 minutes. [SVG got further](https://github.com/adobe-webplatform/Snap.svg "Snap SVG library") and [Web Components became famous](http://css-tricks.com/modular-future-web-components/ "Web Components").<!--more-->

Let's be honest, 2013 was the year where the title Front End Engineer/Developer/Ops was [catching fire](http://www.google.com/trends/explore#q=front%20end%20engineer "Google Trends on Front End Engineer"). Although not perfectly, people are [already interviewing for this specific job description](http://css-tricks.com/interviewing-front-end-engineer-san-francisco/ "Interviewing Front End Engineer in San Francisco").

So what's next?

# Predictions

I have my own personal predictions on how we the web development landscape is going to be for 2014\. Some of these technologies and trends were already on track for 2013, but I feel that 2014 is the year were most of these will actually be pushed forward by multiple parties. I'm not saying that those technologies or approaches will become mainstream, but that more open source projects will use them, more conferences will invite people to talk about them and actual products will use them to deliver top quality experiences.

## SVG Animations will replace other visual tools (gifs, icons).


SVG is nothing new, really. [SVG animations](http://codepen.io/jjperezaguinaga/pen/yuBdq "SVG Animation"), however, is. They come in many [flavours](http://codepen.io/noahblon/pen/lxukH "SVG Icons") and [purposes](http://css-tricks.com/using-svg/ "Learning SVG"). They use [Javascript](http://codepen.io/timkim/pen/jJdgk "Snap SVG Example"), [CSS](http://codepen.io/chriscoyier/pen/LixbE "SVG Tabs") or pure [SVG](http://codepen.io/jjperezaguinaga/full/mApqz "SVG Animation (no CSS or JS)"). They help us to shape our webpages, increase the user experience of a product or just provide visual aid. Sometimes they are just to bring cool effects, like [this shape hover effect](http://tympanus.net/codrops/2014/01/07/shape-hover-effect-with-svg/ "Shape hover Effect with SVG") or [this incredible drawing](http://tympanus.net/Development/SVGDrawingAnimation/ "SVG Drawing").

In general, I will expect more and more usage of SVG Animations during 2014\. With the arrival of libraries like [SnapSVG](http://snapsvg.io/ "Snap SVG"), not only SVG will take a major role in terms of visual aid, but will invade slowly but surely [forms](http://mattdsmith.com/float-label-pattern/ "Float Label Pattern") and [charts](http://zurb.com/playground/pizza-pie-charts "Responsive SVG charts"), and most likely gifs. By now, SVG has gone as far as to [replace icon fonts](http://ianfeather.co.uk/ten-reasons-we-switched-from-an-icon-font-to-svg/ "Ten reasons to switch from an icon font to SVG") in some places. That being said, maybe 2014 is the year where [Web Animations](http://dev.w3.org/fxtf/web-animations/ "Web Animations Working Draft") draft goes to the next stage.

## Offline First will become a trending/growing topic


I had been lucky enough to had worked in multiple countries including Germany, Mexico, United States, Switzerland and Canada. What I had learned from most of my trips is that **connectivity is a luxury. **Data plans all over the world are still a mess to arrange, a pain to set up and a gap between social classes. In Mexico, the internet connection is a joke; it has been rated by the OECD (Organisation for Economic Co-operation and Development) as one of the countries with the lowest connectivity in the world, and only [9% of the country has internet access](http://www.oecd-ilibrary.org/economics/country-statistical-profile-mexico_20752288-table-mex "OECD 2013 Report on Mexico"). In Switzerland, some foreigners with short term permits (L-Permits) can't get an actual data plan unless they provide a hefty fee upfront (around 1107.91 USD) to protect data providers. If Switzerland has such entry barriers, what about less developed countries? 2014 should be the year where **we realise that we need to develop the web taking internet speed in consideration.
**

Luckily, there are already some initiatives and tools going on to make this happen.

*   **[Offline First.org](http://offlinefirst.org/ "Offline First.org") **is the place that prompts developers to realise that we live in a "(...) disconnected a battery powered world" and that if we don't take in consideration the capabilities of the limitations of our users, we will just lose them.**
**
*   **HTTP Proxy to mimic low connectivity**. Tools like [Charles Proxy](http://www.charlesproxy.com/ "Charles Proxy HTTP Tool") allows you to setup a "low bandwidth" internet connection, while [Chrome DevTools ](http://www.igvita.com/slides/2012/devtools-tips-and-tricks/#11 "Networking Reports with Google Chrome") allow you to get Network Reports to further debugging.
*   [Chrome Apps](http://developer.chrome.com/apps/about_apps.html "Chrome Apps"), previously known as Packaged Apps, are "desktop" oriented apps that use web technologies. Last year they received a major "boost" in terms of API's and will be the key for web developers to extend their services and products to users without connectivity.

## Single Page Applications (Load Once™) will grow in popularity


I had always liked Javascript, but after working on [AngularJS](http://angularjs.org/ "AngularJS") for more than a year, I think I finally fell in love with the language. AngularJS gave me a taste of how beautiful web applications can be and how they should had been made to begin with. Not with jQuery-templates-spaghetti code. Not with full Sencha-screw-HTML libraries. But with future friendly, data-binding, model oriented, MVC structured, friendly testable code. Javascript at its very best.

AngularJS (and [EmberJS](http://emberjs.com/ "EmberJS") alike) allows you to create Single Page AJAX powered Apps, which go with the motto Load Once™ and then just load the data you require. Although they had been [criticised in the past](http://sighjavascript.tumblr.com/ "Progressive Enhancement"), with new [SEO friendly techniques](https://prerender.io/ "SEO for Javascript Applications") these frameworks will become more and more popular, to the extent of becoming the structure of Hybrid Apps for mobile devices. For instance, [Ionic Framework](http://ionicframework.com/ "HTML5 Hybrid Apps with Ionic Framework") is an example of the power of AngularJS on mobile, and in the future we can only expect more projects like this to born.

## Backend as a Service will fuel Single Apps


In order to match this Front End heavy approach (known as the [Fat Client, something that has been around ever since 2009](http://www.quirkey.com/blog/2009/09/15/sammy-js-couchdb-and-the-new-web-architecture/ "Sammy JS + REST")), Backends like [Parse](http://parse.com/ "Parse"), [Kinvey](http://www.kinvey.com/ "Kinvey"), [Hood.ie](http://hood.ie/ "Hoodie Homepage") and [Firebase](https://www.firebase.com/ "Firebase") will bring the required REST support. Known as the [NoBackend approach](http://nobackend.org/ "No Backend Approach"), Backend as a Service will grow up in demand, and companies will either switch to those provides or move to a REST architecture themselves. The demand for [API Engineers](http://www.google.com/trends/explore#q=API%20Engineer "API Engineer") will continue to grow and NodeJS frameworks like [KoaJS](http://koajs.com/ "KoaJS - ExpressJS Sucessor") will take preference in companies over heavy lifting frameworks like Ruby on Rails.

## Build workflows will slowly take over the "Fat Stack"


It's going to be build and compile all again. For standard marketing oriented webpages, instead of having to set up some sort of hosting service, an awkward shared VPS subscription, and some obscure back end language, **people will just serve plain html pages**. It's fast, it's easy, and it's most likely what people need. Unless you are building the next LinkedIn, Facebook, Pinterest, etc., your startup landing's page will probably be hosted on [Github Pages](http://pages.github.com/ "Github Pages") or even Amazon S3 with its new [Javascript SDK](http://aws.amazon.com/sdkforbrowser/ "Amazon Javascript SDK").

This has been going on for a while: using tools like [Yeoman](http://yeoman.io/ "Yeoman"), you set up your project; through some sort of MV** library you fetch up data from an external Back End and then through Task Runners like [Grunt](http://gruntjs.com/ "Grunt JS") you precompile anything you need (i18n, sass, coffee script, etc). There's nothing as fast as delivering a simple minified HTML. No server side template rendering mixed with I/O access. No complex data structures. Stacks like Rails, Spring, CodeIgniter, ASP will either move to REST or become simple providers of HTML pages.

_Although most business logic and other CPU consuming tasks will still require a Back End, projects like Parse had gone as far as to allow [to run your own code](https://parse.com/docs/cloud_code_guide "Parse Cloud Code") in their servers. Might as well use something like [WebScript.io](https://www.webscript.io/ "Webscript") that allows you to run server side logic with Lua through a web endpoint._

## Web components will be all over Codepen.io


I had written about [Web Components](http://css-tricks.com/modular-future-web-components/ "Web Components") before: Web Components are the perfect abstraction of style, logic and content that in the future it will be as easy as to fetch them remotely in order to use them in your own web product. I describe this  as [User Interfaces as a Service](http://jjperezaguinaga.com/2013/10/15/the-web-components-era-user-interfaces-as-a-service-uiaas/ "User Interfaces as a Service"), the ability to fetch widgets and modules that apply only to your page and are maintained by somebody else, enrich your content without fear of affecting other elements of your product.

Since the support of Web Components is still a work in progress, I don't see 2014 as they year where they finally kick-off. However, I do see them making an appearance on [Codepen.io](http://codepen.io/ "Codepen"), as small experiments people create in order to test them. The same way SVG projects started to rock all over the place, Web Components will soon be part of the family of funky experiments the site has to offer.

# Conclusion

Personally I'm quite excited about what 2014 has to offer. The demand for Web Technologies knowledge is going to be higher and higher, and more educational projects will boom as a result. During 2013 I saw projects like [Egghead.io](https://egghead.io/ "Egghead - AngularJS Lessons"), [Codeschool](https://www.codeschool.com/ "Codeschool") and [Treehouse](http://teamtreehouse.com/ "Treehouse - Code Learning") grow in size and content. Can we make 2014 another [code year](http://www.codeyear.com/ "Learn to Code this 2014!")?
