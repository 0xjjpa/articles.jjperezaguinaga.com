title: Understanding Google Chrome Extensions
tags:
  - angularjs
  - background page
  - browse action
  - chrome
  - content script
  - development
  - google chrome
  - javascript
  - knockoutjs
  - page action
id: 288
categories:
  - Developer Stories
date: 2012-12-09 05:01:08
---

# Introduction

Developing Chrome Extensions is REALLY fun if you are a Front End engineer. If you, however, struggle with visualizing the architecture of an application, then developing a Chrome Extension is going to bite your butt multiple times due the amount of excessive components the extension works with. Here are some pointers in how to start, what problems I encounter and how to avoid them.

_Note: I'm not covering chrome package apps, which although similar, work in a different way. I also won't cover the page options api neither the new brand event pages. What I explain covers most basic chrome applications and should be enough to get you started._

### Table of Contents

1.  [Understand the Chrome Architecture](#understand)
2.  [Understand the Tabs-Extension Relationship](#tabs-extension)
3.  [Picking the right interface for the job](#picking)
4.  [Learn how to pass information between Interfaces](#message-passing)
5.  [Conclusion](#conclusion)

## <a name="understand"></a> 1) Understand the Chrome Architecture

I'm not telling you to go right away and read all the docs for Chrome Extension development, but to understand how the overall structure works. Actually, if you go read it right away, you are going to have a hard time understanding what is what and you will be learning a bunch of methods you won't ever use.

What helped me to understand is that the only thing you I end up dealing with are 2 things:

*   A tab (or multiple tabs).
*   An extension.
A **tab** is a webpage that's currently loaded in your window on Google Chrome (obvious right?), while the **extension** is your application that will provide a business layer over **ONE OR MORE** of those tabs. This means that you need to establish which tabs you want to modify/extend/upgrade and how.

Even if you are developing an "isolated" extension (an extension that doesn't rely/care on the page content and which solely purpose is to extend the functionality of your current application, e.g. a Facebook app), you need to be aware of how tabs work with your application.

## <a name="tabs-extension"></a> 2) Understand the Tabs-Extension Relationship

The relationship is quite simple: An extension "registers" **callbacks** to Chrome for a specific situation given you described a specific **interface** to do so. Depending on said interface, the tabs are going to display content, change it's content or modify the behaviour they have for a user.

The existing "interfaces" to do so are the following:

*   Content scripts
*   Background pages
*   Page Actions
*   Browser pages
_Note: The reason why I put interfaces in double quotes is because not all of them necessarily have a GUI that can be consumed in order to provide an action, which may be the strict definition of an interface for most people._

The first place where you state which interfaces you are going to use and how is in the **manifest file**. The manifest file is a json file that describes what your application intends to do, how and what permission it requires to do so for each of the interfaces.

So which ones should you use? Well, you need to pick the right one for the job.

## <a name="picking"></a> 3) Picking the right interface for the job

What your application intends to do? Modify content of a specific page? Add a menu option on right click? Provide an icon with a popup for short cuts for something?

There's an interface for that. Let's analyze each of them:

### Content Script

Content scripts are styles or javascript files that are injected into a specific page. Since javascript and css only can completely create a new page from code, you can create a new interface inside an existing page or completely override it.

**How to use it**
In the manifest file, you specify a pattern inside of the "contents_scripts" option. Pretty much, whenever a tab url matches that specific pattern (e.g. http://*.com) it will execute the directives you provide to the "content_scripts" option.

**When to use it**
When you want to enhance a page content, style or behaviour; whenever any change your chrome extension creates enhances the experience of the user somehow with what they are currently viewing in their screen.

### Background Pages

Background Pages come in two flavours: with markup or without markup. Background pages are the controllers of our application and exist through all the time our application is alive. They can be consumed by any tab at any time as long as the Background Page has registered an event listener. You can go to the Extensions section in the Setting part of Chrome and you will see a page that lives there.

![Background Pages](http://jjperezaguinaga.files.wordpress.com/2012/12/screen-shot-2012-12-08-at-7-43-24-pm.png)

Background pages usually just have either javascript inside them (which might as well be markupless) or iframes that help bootstrap some evals for applications. If you specify the background page as an html, they will be rendered as that, but if you just specify scripts in the "background" option of the manifest file, Google Chrome will generate one for you. Currently, I just use one option over the other to organize my scripts.

**How to use it**
In the manifest file, you either specify an .html page under the page directive inside the "background" option, or under the scripts directive in the same option. You can set up this as an array.

**When to use it**
I find background pages useful in 3 scenarios:

*   When multiple tabs consume your application and you need to have a common gateway for the interaction.
*   When you need communication between your content script and a page action/browser action for any reason.
*   When you need a specific task made in the background.

### Page Actions

Page actions are the little icons that show up next to the url on a specific tab. They provide an easy way to show up "something's going on" for your user.

![Page Action](http://jjperezaguinaga.files.wordpress.com/2012/12/screen-shot-2012-12-08-at-7-32-42-pm.png?w=96)

Again, Page Actions come in two flavours: with a Popup and without a popup. With a popup, they show a specific .html described in the .manifest file of your application and can even perform basic Javascript inside said popup. Trying to perform eval will require you to bootstrap it inside an iframe of the background page (see point 3 on when to use a background page). They are created as soon as you click on them, and destroyed when clicked elsewhere.

The popupless ones are just... there. Page Actions can perform actions when clicked on them, but they are quite limited and their behaviour is not as easy going as a click on an element of the DOM. I use popups most of the time and wrap a click functionality inside the popup, as I failed terrible on providing an action with just clicking the Page Action.

**How to use it**
In the manifest.json file, you can put the "page_action" option, and inside the directives default_icon, default_title and default_popup, which take a url for an icon, the hover title (string) and a url for the .html popup page.

**When to use it**
This one is tricky. It can be displayed in multiple tabs or just in one, depending on your code. Most of the time, they are tied to a background page that calls the pageAction.show(tab.id) where the tab.id is a previously obtained tab.

Page actions can have access to the content the tab has through the messaging system (I'll describe it later), but due their nature, they can also represent an state inside the page. Use it when small actions are required, but not heavy processing as they are destroyed on close.

A limitation of the page action popups is the management of Javascript. For security reasons, eval is restricted inside a popup, so if you where need to do something (such as to use a templating system inside it), you need to pass the information to the background page, render it safely inside a frame and send the parsed info back to the popup. You may want to do those operations in the Background and provide an interface through the same page or a Browse Action.

*Note: Templating systems are quite common in most libraries. If you try to use MVC or MMVC libraries, make sure they have a [CSP-compliant mode](https://developer.mozilla.org/en-US/docs/Security/CSP/Default_CSP_restrictions). For instance, Angular JS can be used inside a Page Action, but currently KnockoutJS will crash with some specific bindings. I haven't tested other libraries.

### Browse Action

Browse actions are probably the most common or well known interfaces for Chrome Extensions around. They are the little icons next to your url and are displayed in all the tabs as long as they are enabled.

![Browse Action](http://jjperezaguinaga.files.wordpress.com/2012/12/screen-shot-2012-12-08-at-7-59-42-pm.png)

Browse actions are also the most powerful ones of all the extensions, in the way that they can have access to the content of a tab (as long as it's selected and you have permissions for it) as well as to display an interface by themselves. Finally, they have a component none of the other 3 interfaces have, a _badge_, which is a small label under the icon that can provide information about the status of your application if you require so.

**How to use it**
Browse actions work the same way in the manifest file than to page actions but with the option "browse_action" instead and with the additional default_badge directive.

**When to use it**
As same with the Page Actions, their javascript must be bootstrapped as it doesn't live in the window document. However, unlike Page Actions, they don't need to be tell whether they should be displayed or not, and have a more range of API's as long as you ask the proper permissions for it.

## <a name="message-passing"></a> 4) Learn how to pass information between Interfaces.

Now that you know most of the architecture and components a Chrome Extension can be made of, the next most important thing to understand is Messaging Passing.

Message Passing is the ability to send information from one interface to other. Usually each interface holds the following:

*   Content Script: Access to the actual page the user is browsing.
*   Page Action: Access to an interface for a specific (or multiple) tab(s) through a click.
*   Browse Action: Access to an interface through a click.
*   Background Pages: Access to all of the interfaces.
Here's the relationship between all of them:

*   Both Page Actions and Browse Action have access to the Background page through the chrome.extension.getBackgroundPage(); command (returns a Window object)

    // Inside popup.html as popup.js defined in default_popup
    /**
    * Library that helps to manage the communication between the Chrome.PageAction Popup and Background Page
    * @class popupController
    **/
        a.popupController = function() {
            var backgroundWindow = chrome.extension.getBackgroundPage();
            var backgroundPageController = backgroundWindow.aiesec.backgroundPageController();
            backgroundPageController.loadBootstrap();
        };
    `</pre>

*   Content Scripts can communicate with the Background page only through an asynchronous request in the form:
    <pre>`// Inside content.js
    chrome.extension.sendMessage({greeting: "hello"}, function(response) {
      console.log(response.farewell);
    });
    `</pre>

*   Background page can have access to its own markup through native Javascript (useful when bootstrapping dangerous operations such as eval inside an iframe)
    <pre>`/**
    * Chrome Extension Bootstrap for Popup. Loads logic from Sandboxed HTML for eval-safe use into Popup.
    * @event loadBoostrap
    * @namespace backgroundPageController
    **/
            pg.loadBootstrap = function() {
                var iframe = document.getElementById("aiesec-frame");
                var data = {
                    command: "render"
                };

                iframe.contentWindow.postMessage(data, "*");
            };
    `</pre>

*   Background pages and Content Scripts can receive messages at any time. In the documentation, onRequest is used but that has been deprecated ever since Google V.17, so now we use onMessage.
    **Note:Careful, background pages load first than pages, so you want to make sure you check that the page was loaded successfully before sending a message or you will get a port connection error**
    <pre>`// Inside background.js
    /**
    * Listener for Displaying the Extension Page Action when the Tab is updated.
    * @private
    * @event displayPageAction
    * @param {Number} tabId The tabId given by the tabs listener to know which tab was updated.
    * @param {Object} changeInfo The current status of the tab.
    * @param {Object} tab The metadata of the tab.
    **/
        var displayPageAction = function (tabId, changeInfo, tab) {
            var match = regexAIESEC.exec(tab.url); // var regexAIESEC = new RegExp(/http:\/\/www.myaiesec.net\//);
            // We only display the Page Action if we are inside a MyAIESEC Tab.
            if(match &amp;&amp; changeInfo.status == 'complete') {
                //We send the proper information to the content script to render our app.
                 chrome.tabs.sendMessage(tab.id, {load: true}, function(response) { // We don't do anything if we don't have a response
                    if(response) {
                        console.log("Inside Background Response script, we had a response:");
                        //After successfully getting the response, we show a Page Action Icon.
                        chrome.pageAction.show(tab.id);     
                    }
                });
            }
        };

    ...

    // Inside content.js
    chrome.extension.onMessage.addListener(function(request, sender, sendResponse) {
        if(request.load) {
            var data = ... //Something from the page user browses.
            sendResponse({webpageContent: "data"})
            return true;
        }
    ...

The most common pattern I use is the following.

*   Background page checks whether the tab has been updated.
*   When it's complete, we start doing our application logic.
*   If we need something from the content page, we send them a request and wait for a response.
*   We perform an activity based on response, such as show a page action, storing information in a external server (for instance, you can't do that in the content script due the cross origin policy), etc.
*   We register callbacks in our background page to wait for actions from a Page Action Popup, Browse Action Popup or a Content Page (the last one usually injected by ourselves, as usually web pages don't have javascript code that sends things to a Chrome Extension)

## <a name="conclusion"></a> 5) Conclusion

Developing Chrome Extensions is quite fun as you can mimic a whole server inside a simple script through Javascript (the background.js can be your backend, and can benefit from resources such as web workers!). It can be quite complicated in the beginning, but as long as you understand the principles I just stated, the rest is easy.

Although I didn't share as much code as I wish, I have an existing Chrome Application that you can read freely in [Github](https://github.com/jjperezaguinaga/AIESEC-Chrome-Extension), [Bitbucket](https://bitbucket.org/jjperezaguinaga/aiesec-google-chrome) -if you prefer mercurial like me-. The master branch has a popup example I dished because KnockoutJS problem with eval, so I'm switching to a content page interface under the branch insideMyAIESEC because instead of aiding the user with a popup interface, I'll replace the content of the actual page with a new one.

Finally, here's the [Gist](https://gist.github.com/4243341#message-passing) in case you want to copy, fork, or update this article. Don't hesitate to reach me if you wanna know more.