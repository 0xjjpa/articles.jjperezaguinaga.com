title: '[ Javascript Interview ] Coding a clock'
tags:
  - closures
  - computer science
  - intervals
  - interviews
  - javascript
  - javascript interview
  - knockoutjs
  - raphaeljs
id: 307
categories:
  - Just life
date: 2013-02-03 07:50:05
---

_This tip is part of series I'm intending to write about interviewing Javascript Engineers. Unlike common Software Engineers, Javascript Engineers should be familiar with concepts related to the web stack, the DOM, MVC architectures/libraries/frameworks, the language itself and even basic server-side skills. This questions are aimed to spot weakness in developers that although have strong programming skills, may still require some experience in the lingua franca of the web._

## Coding a clock

[![clock-in-javascript](http://jjperezaguinaga.files.wordpress.com/2013/02/clock-in-javascript.png)](http://jjperezaguinaga.files.wordpress.com/2013/02/clock-in-javascript.png)

The question:

    Create a <span class="string">"Clock"</span> <span class="class"><span class="keyword">class</span> <span class="id">that</span> <span class="id">displays</span> <span class="id">hours</span>, <span class="id">minutes</span> <span class="id">and</span> <span class="id">seconds</span> <span class="id">in</span> <span class="id">the</span> <span class="id">form</span> <span class="id">H</span>:<span class="id">M</span>:<span class="id">S</span> <span class="id">using</span> <span class="id">Javascript</span> <span class="id">and</span> <span class="id">HTML</span>. <span class="id">It</span>'<span class="id">s</span> <span class="id">behavior</span> <span class="id">should</span> <span class="id">be</span> <span class="id">the</span> <span class="id">one</span> <span class="id">of</span> <span class="id">a</span> <span class="id">functional</span> <span class="id">clock</span>, <span class="id">starting</span> <span class="id">in</span> 00:00:00, <span class="id">then</span> 00:00:01, 00:00:02 <span class="id">and</span> <span class="id">so</span> <span class="id">on</span>.</span>
    `</pre>
    The goal of this question is to test the developer in the following skills:

*   Knowledge of DOM manipulation and browser caveats.
*   Closures and Context Scope
*   Timeouts
*   Problem Solving skills
*   Client-Side Performance
    From there, the developer should be left alone in order to analyze the problem, and given maybe 15 to 25 minutes to solve the problem. The following list are possible specifications for the problem that could be given to the interviewee if he/she asks any questions; a good programming prospect will make sure to ask all the questions before starting to code.

    ### Specifications

*   The clock "display" has to be rewritten every time second changes. A solution that outputs
    <pre>`00<span class="pseudo">:00</span><span class="pseudo">:00</span>
    00<span class="pseudo">:00</span><span class="pseudo">:01</span>
    00<span class="pseudo">:00</span><span class="pseudo">:02</span>
    ...
    `</pre>
    without repainting the display demonstrates problem solving skills but no knowledge of the DOM or misunderstanding of the question. The developer shouldn't assume that this is expected (specially as this format is common in Programming Contests such as TopCoder or the ACM ICPC where use cases are given and the output is shown in the form of multiple lines with the answers), so asking this would be a good idea to be safe.
*   The format is not really important, so displaying the time in the form H:M:S or HH:MM:SS shouldn't be much of a difference. A developer that focuses too much time in the formating wants to avoid the real problem, it's probably nervous or his/her ideas are scrambling out. It should be stated that the format is a nice to have after he/she solved the problem, and could show of skills such as using the String form of numbers to get the length of them.
    <pre>`(<span class="number">59</span>).toString().length // returns <span class="number">2</span> (we could show a <span class="function"><span class="keyword">function</span> <span class="title">format</span><span class="params">(num)</span></span> using this <span class="keyword">and</span> ask why it works)

*   It's not expected to see style or perfect HTML markup. If he/she wants to use `&lt;p&gt;` for each element or the entire display, that's should be just fine. Again, formatting and style should be taking in consideration after finishing the problem.
*   Although solutions can render the entire display through a toString() function, solutions that separate the Hour, Minute and Seconds as different elements of the clock, are preferred in order to show OOP concepts. No solution should be preferred over the other as long as the developer is aware of the differences and can name some benefits about his/her solution.
*   It's not necessary that the developer knows the entire syntax of `setTimeout`, `setInterval` or `clearInterval`. Both functions prototypes can be given as a hint if the developer stumbles upon the "animation" stage. However, he/she should be able to use a closure in order to set up a proper context for calling the recursive function, either by biding the timeout or saving it in a variable.
*   The use of libraries are allowed, as long as it's for DOM manipulation. The timeout should be specified with Vanilla JS in order to show understanding of this feature.
*   Top performance is not required for this exercise, but asking to explaing how his/her code affects the application it's a must, specially if he or she uses a library for DOM manipulation. The complexity of these questions can go from why picking an ID for a HTML Element over a class, to explaining why Javascript how `timeouts` work.

### Analysis and Insights

The problem tries to force the developer to come up with a solution using his/her Javascript skills and knowledge on basic Computer Science topics. Although there are many ways to come up with the minutes and hours, there's a chance that during the interview the pressure could mess up with the developer, so giving hints on the mathematical calculations shouldn't score down that much.

The clarity of the code and speed of implementation are good indicators that the developer know what he/she's doing. An ideal code can take a little bit more than the expected time (maybe up to 30 minutes), but it clearly showcases separation of logic, isolation of componentes and variables, and proper usage of closures.

### Possible solutions

[Pure javascript solution](http://jsfiddle.net/jjperezaguinaga/sPSzu/)

[Data-binding solution with KnockoutJS](http://jsfiddle.net/jjperezaguinaga/kYEBf/)

[Analog clock solution with KnockoutJS and RaphaelJS](http://jsfiddle.net/jjperezaguinaga/WEaFx/)

### Follow-up questions

1.  Code a "Pause" and "Resume" button. What problems could happen if you resume a non-paused clock? (Depends on implementation)
2.  How would you test this application?
3.  Describe a couple test cases (use cases, stories, BDD or TDD syntax should be fine, even plain Gherkin language it's good. Usage of Jasmine, Mocha, Chai, Sinon, or other test frameworks can be showcased here).
4.  Imagine you are in debugging mode. A co-worker's code hour displays "1", after 60 minutes "11" and after other 60 minutes, "111". In short, the amount of hours are showed by the number "1". What's most likely to be the error?
5.  What libraries could help you out to solve this problem?
6.  One solution sums up seconds in a variable and then divides to minutes and hours. What are some problems of this solution?
7.  Is there a way to code a clock without using `setTimeout` or `setInterval`?
8.  Multiple calculations can slow down the application. Is there any way to cache some part of the calculations?
9.  How would you code an analog clock? What kind of problems would you encounter?
10.  You are sending the clock's information to a server every X time. What problems should be considering when sending this information?