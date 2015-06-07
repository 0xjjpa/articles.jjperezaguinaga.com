title: "What's this? What's this? There's something very wrong"
tags:
  - closure
  - ecmascript
  - javascript
  - new
  - scope
  - this
id: 303
categories:
  - Developer Stories
date: 2013-01-13 01:01:51
---

![Picture](https://coderwall-assets-0.s3.amazonaws.com/uploads/picture/file/1128/nightmare-before-christmas.jpg)

`this` is probably one of the hardest concepts to grasp in Javascript. Not because it's complicated, but because it's one of things of the Javascript language that developers need to memorize in order to understand how it works in specific scenarios. I'll try to explain what is `this` all about and yes, there are going to be tons of puns.

## What's this? What's this?

First, `this` is a **pointer**, a reference to an object. It's created **whenever a function it's created** and lives inside its scope in the same way the `arguments` variable. One major difference with the `arguments` variable is that you **can't modify it's value**.

    <span class="function"><span class="keyword">function</span><span class="params">()</span> { <span class="title">arguments</span> = <span class="params">[]</span> } // <span class="title">no</span> <span class="title">error</span></span>
    <span class="function"><span class="keyword">function</span><span class="params">()</span> { <span class="title">this</span> = {} } // <span class="title">throws</span> <span class="title">ReferenceError</span>: <span class="title">Invalid</span> <span class="title">left</span>-<span class="title">hand</span> <span class="title">side</span> <span class="title">in</span> <span class="title">assignment</span></span>
    `</pre>

    The object `this` points to refers to **the object of which that function is a property/method**. In Web Development, most of the time we are calling functions through the Global/Head, the `window` object inside our Browser, where all our Javascript object is being stored. In your favorite console, if you type `this`, you get the aforementioned Global/Head object.

    <pre>``<span class="keyword">this</span>` <span class="comment">// returns Window</span>
    `</pre>

    So in which scenarios does the `this` object changes its value from the Global/Head object? Here are them:

*   Whenever a function is called, `apply` or `call` are used.
*   Whenever a **nested** function is called
*   Whenever a function is called with the `new` keyword

    ## Whenever a function is called, apply or call are used.

    Let's start with the following object

    <pre>`<span class="keyword">var</span> pumpkin = {
      name: <span class="string">"Jack"</span>,
      status: <span class="string">"King"</span>,
      whoGrewSoTired: <span class="function"><span class="keyword">function</span><span class="params">()</span> {</span> <span class="keyword">return</span> <span class="string">"I, "</span> + pumpkin.name + <span class="string">"! The pumpkin "</span> + pumpkin.status}
    }
    `</pre>

    If you create this in your console, you will see that when you call `pumpkin.whoGrewSoTired()` will actually display a proper message (or lament if you will). This is because the variables `pumpkin.name` and `pumpkin.status` are actually browsable from the Head/Global object `window`. This would be the same as writing

    <pre>`<span class="keyword">var</span> pumpkin = {
      name: <span class="string">"Jack"</span>,
      status: <span class="string">"King"</span>,
      whoGrewSoTired: <span class="function"><span class="keyword">function</span><span class="params">()</span> {</span> <span class="keyword">return</span> <span class="string">"I, "</span> + window.pumpkin.name + <span class="string">"! The pumpkin "</span> + window.pumpkin.status}
    }
    `</pre>

    Now, you most likely had never seen this before (if you have, please send me the email of the developer, I will introduce him/her to a Oogie Boogie friend I have). The reason is because most developers in their good senses are aware of Object Oriented Programming (OOP) and what they want is to call the actual properties of the object. And `this`, my friends, is what `this` is for.

    <pre>`<span class="keyword">var</span> pumpkin = {
      name: <span class="string">"Jack"</span>,
      status: <span class="string">"King"</span>,
      whoGrewSoTired: <span class="function"><span class="keyword">function</span><span class="params">()</span> {</span> <span class="keyword">return</span> <span class="string">"I, "</span> + <span class="keyword">this</span>.name + <span class="string">"! The pumpkin "</span> + <span class="keyword">this</span>.status}
    }
    `</pre>

    So how does `this` changes when we call a function? In the previous code we had no problem in seeing that we are retrieving the name and status of the object `pumpkin`. Now see the following code:

    <pre>`<span class="keyword">var</span> season = <span class="string">"Christmas"</span>
    <span class="keyword">var</span> halloweenTown = { season: <span class="string">"Halloween"</span> }
    <span class="keyword">var</span> getHoliday = <span class="function"><span class="keyword">function</span><span class="params">()</span> {</span> <span class="keyword">return</span> <span class="keyword">this</span>.season }
    halloweenTown.getHoliday = getHoliday;
    halloweenTown.getHoliday() <span class="comment">// returns "Halloween"</span>
    getHoliday() <span class="comment">// returns "Christmas"</span>
    `</pre>

    Why are we retrieving the value "Halloween" for town? Well, because the value of `this` during the execution of that function is the object town, while on the latter it's the object window. Since we are storing all our variables in the Head/Global object, this would be the same as before:

    <pre>`window<span class="preprocessor">.halloweenTown</span><span class="preprocessor">.getHoliday</span>()
    window<span class="preprocessor">.getHoliday</span>()
    `</pre>

    Now, do you remember those Object methods `call` and `apply`? I bet they make more sense now with this example!

    <pre>`<span class="title">getHoliday</span>.call(halloweenTown, <span class="keyword">null</span>)
    <span class="title">getHoliday</span>.call(window, <span class="keyword">null</span>)
    `</pre>

    Basically, we are telling to the function `getHoliday` which value `this` should have. Let's move on to the next case!

    ### Whenever a **nested** function is called

    Now, there's a **special** case when `this` may get a little confused: nested functions. See the following code.

    <pre>`<span class="keyword">var</span> town = { 
      name: <span class="string">"Christmas Town"</span>, 
      king: <span class="string">"Santa"</span>, 
      whosTheKing: <span class="function"><span class="keyword">function</span><span class="params">()</span> {</span> 
        <span class="keyword">var</span> town = <span class="keyword">this</span>.name; 
        <span class="keyword">var</span> getKing = <span class="function"><span class="keyword">function</span><span class="params">()</span> {</span> 
          <span class="keyword">return</span> <span class="keyword">this</span>.king 
        }(); 
            <span class="keyword">return</span> getKing + <span class="string">" is the king of "</span>+ town 
        }
    }
    `</pre>

    Run `town.whosTheKing()` and wow, you get 'undefined is the king of Christmas Town'. What's this? What happened to Santa? Was he kidnapped? Most likely, but the true problem is that the second `this` was no longer referring to thte `town` object! You might say "Well, that's obvious, because `this` is being called by the `whosTheKing` function, and not `town` unlike the first one!". So, would you be happy if I do this?

    <pre>`<span class="keyword">var</span> town = { 
      name: <span class="string">"Christmas Town"</span>, 
      king: <span class="string">"Santa"</span>, 
      whosTheKing: <span class="function"><span class="keyword">function</span><span class="params">()</span> {</span> 
        <span class="keyword">var</span> town = <span class="keyword">this</span>.name; 
        <span class="keyword">var</span> king = <span class="keyword">this</span>.king; 
        <span class="keyword">var</span> getKing = <span class="function"><span class="keyword">function</span><span class="params">()</span> {</span> 
          <span class="keyword">return</span> <span class="keyword">this</span>.king 
        }(); 
        <span class="keyword">return</span> getKing + <span class="string">" is the king of "</span>+ town 
      }
    }
    `</pre>

    Run it. "undefined is the king of Christmas Town". If you are shocked by `this`, keep reading!

    _(I actually did something in purpose in order to keep this error. To find it, you just need to read [this answer in StackOverflow](http://stackoverflow.com/questions/1470488/difference-between-using-var-and-not-using-var-in-javascript) that explains the difference between using var and not using it)_

    Ok, so what's going on? Here's the answer: In ECMAScript 262 Ed.3, nested functions "lose" the reference to `this` value. Whenever they "lose" it, they refer to the Head/Global object. So the second function is actually looking outputting the `window.king` variable. I can prove it here:

    <pre>`window<span class="preprocessor">.king</span> = <span class="string">"Jack"</span>
    town<span class="preprocessor">.whosTheKing</span>()<span class="comment">; // "Jack is the king of Christmas Town"</span>
    `</pre>

    The good news is that in ECMAScript 262 Ed. 5 this is getting solved. In the meantime, a work around that you have probably seen in some code goes like this.

    <pre>`<span class="keyword">var</span> town = { 
      name: <span class="string">"Christmas Town"</span>, 
      king: <span class="string">"Santa"</span>, 
      whosTheKing: <span class="function"><span class="keyword">function</span><span class="params">()</span> {</span> 
        <span class="keyword">var</span> town = <span class="keyword">this</span>.name; 
        that = <span class="keyword">this</span>;
        <span class="keyword">var</span> getKing = <span class="function"><span class="keyword">function</span><span class="params">()</span> {</span> 
          <span class="keyword">return</span> that.king 
        }(); 
        <span class="keyword">return</span> getKing + <span class="string">" is the king of "</span>+ town 
      }
    }
    town.whosTheKing(); <span class="comment">// "Santa is the king of Christmas Town"</span>
    `</pre>

    In order to not lose the reference, we use a helper variable that stores the correct pointer to our variable. Another work around is to use a **Closure** that stores the variable with the proper scope. This, however, can get confusing really fast.

    <pre>`<span class="keyword">var</span> town = { 
      name: <span class="string">"Christmas Town"</span>, 
      king: <span class="string">"Santa"</span>, 
      whosTheKing: <span class="function"><span class="keyword">function</span><span class="params">()</span> {</span> 
        <span class="keyword">var</span> town = <span class="keyword">this</span>.name; 
        king = <span class="keyword">this</span>.king;
        <span class="keyword">var</span> getKing = <span class="function"><span class="keyword">function</span><span class="params">()</span> {</span> 
          <span class="keyword">return</span> <span class="keyword">this</span>.king 
        }(); 
        <span class="keyword">return</span> getKing + <span class="string">" is the king of "</span>+ town 
      }
    }
    town.whosTheKing(); <span class="comment">// "Santa is the king of Christmas Town"</span>
    `</pre>

    _(If you don't understand this, I suggest you to read the note I put previously about the StackOverflow answer)_

    ## Whenever a function is called with the new keyword

    Ok, so we are almost through all the behaviours of `this`; the missing one is when the `new` word comes to town (got it? to town! Ah, fine, I'll stop). Let me ask you, what do you think the value of `boogieMan.phrase` will be?

    <pre>`<span class="keyword">var</span> Monster = <span class="function"><span class="keyword">function</span><span class="params">(phrase)</span> {</span>
      <span class="keyword">this</span>.phrase = phrase;
    }

    <span class="keyword">var</span> boogieMan = Monster(<span class="string">"YOU'RE JOKIN', YOU'RE JOKIN', I CAN'T BELEVE MA EYEZ!"</span>);
    boogieMan.phrase <span class="comment">// returns ??</span>
    `</pre>

    It will return an error. Why? Because despite our bulletproof OOP design, we are just calling a function that returns `undefined` (all functions return a value, even if it's `undefined`). Without the `new` keyword, you just set up `window.phrase` instead of an instance of the "class" Monster with a property `phrase`.

    When a function is invoked with the `new` keyword, the value of `this` refers to the object itself, which is proper OOP design. From our previous code:

    <pre>`<span class="keyword">var</span> Monster = <span class="function"><span class="keyword">function</span><span class="params">(phrase)</span> {</span>
      <span class="keyword">this</span>.phrase = phrase;
    }

    <span class="keyword">var</span> boogieMan = <span class="keyword">new</span> Monster(<span class="string">"YOU'RE JOKIN', YOU'RE JOKIN', I CAN'T BELEVE MA EYEZ!"</span>);
    boogieMan.phrase <span class="comment">// returns "YOU'RE JOKIN', YOU'RE JOKIN', I CAN'T BELEVE MA EYEZ!"</span>
    `</pre>

    What if the object doesn't have the property we are looking for? Javascript will start looking up in the prototype chain for the right value, and thus the value of `this` will be updated accordingly.

    <pre>`<span class="keyword">var</span> Monster = <span class="function"><span class="keyword">function</span><span class="params">(phrase)</span> <span class="comment">{
      if(phrase) this.phrase = phrase;
    }</span>

    <span class="title">Object</span>.<span class="title">prototype</span>.<span class="title">phrase</span> = "<span class="title">Eureka</span>! <span class="title">This</span> <span class="title">year</span>, <span class="title">Christmas</span> <span class="title">will</span> <span class="title">be</span> <span class="title">OURS</span>";</span>
    <span class="keyword">var</span> pumpkinKing = new Monster(); <span class="comment">// We don't set the the property 'phrase'</span>
    pumpkinKing.phrase <span class="comment">// returns "Eureka! This year, Christmas will be OURS"</span>

In the previous code `this` first looked up in the `Monster` object; when it failed to find the property `phrase`, it started the prototype lookup process, where it found the `phrase` property as part of the Object prototype, the truly king of objects!

Hopefully this helped devs out there to understand better the `this` word. No Christmas or Halloween towns were damaged in the process of making this article.