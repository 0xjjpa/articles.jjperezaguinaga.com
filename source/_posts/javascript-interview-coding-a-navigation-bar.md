title: '[ Javascript Interview ] Coding a Navigation Bar'
tags:
  - front-end
  - interview
  - javascript
  - javascript interview
  - navigation bar
  - ui
  - ux
id: 324
categories:
  - Developer Stories
date: 2013-03-10 17:27:35
---

_This tip is part of series I'm intending to write about interviewing Javascript Engineers. Unlike common Software Engineers, Javascript Engineers should be familiar with concepts related to the web stack, the DOM, MVC architectures/libraries/frameworks, the language itself and even basic server-side skills. This questions are aimed to spot weakness in developers that although have strong programming skills, may still require some experience in the lingua franca of the web._

## Coding a Navigation Bar

The question:

    The most common way to display tabular data in HTML is through tables. However, sometimes these tables have too many rows to be browsed by the user, who wants to find a specific entry in the table. In such cases, the table is separated in different views known as <span class="string">"Pages"</span>, and a GUI is used in order to browse the Pages.

    One <span class="class"><span class="keyword">interface</span> <span class="id">used</span> <span class="id">in</span> <span class="id">order</span> <span class="id">to</span> <span class="id">provide</span> <span class="id">a</span> <span class="id">better</span> <span class="id">experience</span> <span class="id">to</span> <span class="id">the</span> <span class="id">user</span> <span class="id">is</span> <span class="id">the</span> <span class="id">Navigation</span> <span class="id">Bar</span> (<span class="id">NB</span>). <span class="id">The</span> <span class="id">NB</span> <span class="id">is</span> <span class="id">usually</span> <span class="id">a</span> <span class="id">single</span> <span class="id">horizontal</span> <span class="id">row</span> <span class="id">with</span> <span class="id">multiple</span> <span class="id">cells</span> <span class="id">that</span> <span class="id">work</span> <span class="id">as</span> <span class="id">buttons</span>; <span class="id">although</span> <span class="id">there</span> <span class="id">are</span> <span class="id">many</span> <span class="id">implementations</span> <span class="id">of</span> <span class="id">NB</span>'<span class="id">s</span>, <span class="id">most</span> <span class="id">of</span> <span class="id">them</span> <span class="id">include</span> <span class="id">buttons</span> <span class="id">Numbers</span>, <span class="id">that</span> <span class="id">represent</span> <span class="id">the</span> <span class="id">Pages</span>, <span class="id">the</span> "<span class="id">Back</span>" <span class="id">and</span> "<span class="id">Forward</span>" <span class="id">button</span>, <span class="id">which</span> <span class="id">moves</span> <span class="id">to</span> <span class="id">the</span> <span class="id">next</span> <span class="id">page</span> <span class="id">depending</span> <span class="id">on</span> <span class="id">which</span> <span class="id">one</span> <span class="id">the</span> <span class="id">user</span> <span class="id">is</span> <span class="id">browsing</span>, <span class="id">as</span> <span class="id">well</span> <span class="id">as</span> <span class="id">the</span> "<span class="id">Fast</span> <span class="id">Backward</span>" <span class="id">and</span> "<span class="id">Fast</span> <span class="id">Forward</span>", <span class="id">which</span> <span class="id">take</span> <span class="id">the</span> <span class="id">user</span> <span class="id">to</span> <span class="id">the</span> <span class="id">first</span> <span class="id">or</span> <span class="id">last</span> <span class="id">page</span>.</span>

    Your task is to code a Navigation Bar that looks similar to <span class="keyword">this</span>:

    &lt; <span class="number">1</span> <span class="number">2</span> <span class="number">3</span> <span class="number">4</span> <span class="number">5</span> <span class="number">6</span> <span class="number">7</span> &gt;
    `</pre>
    Where:

*   The first button takes the user to the view of the previous page.
*   The last button takes the user to the view of the next page.
*   The rest of the buttons takes the user to the view of that number page.
*   The first button also updates the number of the pages displayed if the current view is smaller than the next page.
*   The last button also updates the number of the pages displayd if the current view is bigger than the previous page.

    ### Test Examples

    ("A" means active, the current page browsed and the current button selected)

    **Simple case**
    <pre>`<span class="tag">&lt; <span class="attribute">1</span> <span class="attribute">2</span> <span class="attribute">3</span> <span class="attribute">4</span> <span class="attribute">5</span> <span class="attribute">6</span> <span class="attribute">7</span> &gt;</span>
    <span class="emphasis">_ A _</span> <span class="emphasis">_ _</span> <span class="emphasis">_ _</span> <span class="emphasis">_ _</span>
    `</pre>
    _User Clicks next_
    <pre>`<span class="tag">&lt; <span class="attribute">1</span> <span class="attribute">2</span> <span class="attribute">3</span> <span class="attribute">4</span> <span class="attribute">5</span> <span class="attribute">6</span> <span class="attribute">7</span> &gt;</span>
    <span class="emphasis">_ _</span> A <span class="emphasis">_ _</span> <span class="emphasis">_ _</span> <span class="emphasis">_ _</span>
    `</pre>

    * * *

    **Number case**
    <pre>`<span class="tag">&lt; <span class="attribute">1</span> <span class="attribute">2</span> <span class="attribute">3</span> <span class="attribute">4</span> <span class="attribute">5</span> <span class="attribute">6</span> <span class="attribute">7</span> &gt;</span>
    <span class="emphasis">_ A _</span> <span class="emphasis">_ _</span> <span class="emphasis">_ _</span> <span class="emphasis">_ _</span>
    `</pre>
    _User Clicks 6_
    <pre>`<span class="tag">&lt; <span class="attribute">1</span> <span class="attribute">2</span> <span class="attribute">3</span> <span class="attribute">4</span> <span class="attribute">5</span> <span class="attribute">6</span> <span class="attribute">7</span> &gt;</span>
    <span class="emphasis">_ _</span> <span class="emphasis">_ _</span> <span class="emphasis">_ _</span> A <span class="emphasis">_ _</span>
    `</pre>

    * * *

    **Limits case**
    <pre>`<span class="tag">&lt; <span class="attribute">1</span> <span class="attribute">2</span> <span class="attribute">3</span> <span class="attribute">4</span> <span class="attribute">5</span> <span class="attribute">6</span> <span class="attribute">7</span> &gt;</span>
    <span class="emphasis">_ _</span> <span class="emphasis">_ _</span> <span class="emphasis">_ _</span> <span class="emphasis">_ A _</span>
    `</pre>
    _User Clicks next_
    <pre>`<span class="tag">&lt; <span class="attribute">2</span> <span class="attribute">3</span> <span class="attribute">4</span> <span class="attribute">5</span> <span class="attribute">6</span> <span class="attribute">7</span> <span class="attribute">8</span> &gt;</span>
    <span class="emphasis">_ _</span> <span class="emphasis">_ _</span> <span class="emphasis">_ _</span> <span class="emphasis">_ A _</span>
    `</pre>
    _User Clicks prev_
    <pre>`<span class="tag">&lt; <span class="attribute">2</span> <span class="attribute">3</span> <span class="attribute">4</span> <span class="attribute">5</span> <span class="attribute">6</span> <span class="attribute">7</span> <span class="attribute">8</span> &gt;</span>
    <span class="emphasis">_ _</span> <span class="emphasis">_ _</span> <span class="emphasis">_ _</span> A <span class="emphasis">_ _</span>
    `</pre>
    _User Clicks 2_
    <pre>`<span class="tag">&lt; <span class="attribute">2</span> <span class="attribute">3</span> <span class="attribute">4</span> <span class="attribute">5</span> <span class="attribute">6</span> <span class="attribute">7</span> <span class="attribute">8</span> &gt;</span>
    <span class="emphasis">_ A _</span> <span class="emphasis">_ _</span> <span class="emphasis">_ _</span> <span class="emphasis">_ _</span>
    `</pre>
    _User Clicks prev_
    <pre>`<span class="tag">&lt; <span class="attribute">1</span> <span class="attribute">2</span> <span class="attribute">3</span> <span class="attribute">4</span> <span class="attribute">5</span> <span class="attribute">6</span> <span class="attribute">7</span> &gt;</span>
    <span class="emphasis">_ A _</span> <span class="emphasis">_ _</span> <span class="emphasis">_ _</span> <span class="emphasis">_ _</span>

* * *

The goal of this question is to test the developer in the following skills:

*   Knowledge of DOM manipulation and browser caveats.
*   Problem Solving skills
*   Client-Side Performance
*   Data Structures in Javascript
*   XML Http Requests (AJAX)
*   GUI Design and Construction
From there, the developer should be left alone in order to analyze the problem, and given around 25 to 35 minutes to solve it. The following list are possible specifications for the problem that could be given to the interviewee if he/she asks any questions; a good programming interviewer will make sure to ask all the questions before starting to code.

### Specifications

*   The data for the table could be retrieved from a mock server through a GET Request. Then, the developer would had to request the information through a XML Http Request. A wrapper for the performing this request can be used through libraries such as jQuery, Zepto, Sammy, etc. The proper usage of these promises objects, checking status code and proper success/error callbacks should be expected if this is required. If the developer spends too much time trying to come up with the Request, giving him/her the data as a variable would be preferable.
*   The application is expected to repaint the rows for the table. Unless native javascript DOM manipulation is required to be tested, the developer should be provided with libraries to help him to perform this task, otherwise he/she might take too much time. MVC libraries such as Backbone.js, Knockout.js, Ember.js and Angular.js are expected to be used for job descriptions that require such knowledge, although any other data-binding or MVC library is also accepted; if the developer doesn't know any of those, jQuery or Zepto with its documentation should be enough. In a side note, a good javascript developer should be aware of native DOM manipulation functions even if they belong to the non-IE supported specifications of Javascript (e.g. querySelector). This goes the same way with Templating Systems such as jQuery.tmpl, Mustache, Handlebars and so on.
*   Code must check for when the user can perform specific actions; for instance, not allowing the user to click in an active page, or going to the first page if the user is already in that page. The developer should be aware of this UX components even if he/she doesn't code them (for instance, he/she can only mention this features, and that he/she would implement those given more time or after the main features are done).
*   The developer might mention about providing parameters to the GET request in order to retrieve only the information needed (search params). In some cases and depending on the data, this approach is better than just sending the entire data over the wire. In this case though, the developer should be given the entire data in order to show proper usage of data structures and Javascript performance. In case the developer mentions this, it could be a good chance to ask about the benefits and cons of this approach; job applicants for jobs such as Software Engineer and DevOps should be expected to ask this question and know the answer.
*   Wiring up the application by observing `location.hash` (onHashChange) should be looked up over adding up listeners to each of buttons, but both approaches are valid.
*   The applicant shouldn't focus much of his time in style or markup. Valid XHTML markup is good, but shouldn't be a deal breaker.

### Analysis and Insights

In this case the problem brings multiple areas related to Web Development and not only to Javascript. From DOM manipulation to Javascript performance, the applicant should be wary of all the possible pitfalls in developing a solution. He/She is expected to separate the problem in different components and tackle them one by one.

This problem has many caveats that the developer is expected to find by himself/herself BEFORE starting to write code. Although some fast code is expected, the amount of time spending thinking to solve the problem might be bigger than coding the solution. A developer that starts coding hastly without explaining his/her solution and then suddenly getting stuck could provide a warning flag.

An ideal solution will clearly separate the DOM from the Javascript manipulation without taking too much time (up to 40 minutes would still be fine). A proper walkthrough of the solution should be given all the time by the developer will coming up with the solution.

### Possible Solutions

[Pure Javascript Solution](http://jsfiddle.net/jjperezaguinaga/LFpDs/)

_I'll update this post with Backbone.js,Knockout.js and Angular.js solutions in the incoming days_

### Follow-up Questions

I. Code a "Go to first" and "Go to last" button. What problems would you be expecting to have while doing this task?
II. How would you test this application? From a browser perspective, how would you check that the viewed page is the right one?
III. In terms of User Experience, what problem does this interface represent? How would you improve it?
IV. Describe a couple test cases (use cases, stories, BDD or TDD syntax should be fine, even plain Gherkin language it's good. Usage of Jasmine, Mocha, Chai, Sinon, or other test frameworks can be showcased here).
V. On each view, the user is shown an entry record that has multiple columns. Sometimes entries have too many columns to be displayed in a single screen (in mobile layouts, for instance). How would you solve this?
VI. What libraries could make this task easier?
VII. Currently, you are given the entire data. As the application grows, the data increases, making the initial request bigger and slow. How would you improve the performance of the application from a Front End perspective?
VIII. Imagine you are in debugging mode. You notice that every time you update the page, the browser takes some time to repaint the DOM elements. How would you find the function that causes the problem?
IX. You want to record the user page browsing history (of the Navigation Bar). How would you do this? Which data structure would you use and why?
X. The user request a CRUD interface for the table. How would you implement this? What problems could arise when switching from views?
XI. The server updates the table information every X seconds for given entries. How would you update those entries? What elements would you use to notify the user about the updates?
XII. Other types of navigation bar include an input field in order to allow the user to input the page he/she wants to browse. What benefits this solution has over the proposed one? Which problems?