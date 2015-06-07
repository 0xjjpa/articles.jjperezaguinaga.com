title: Debugging Javascript Applications
tags:
  - chrome developer tools
  - debugging
  - firebug
  - function
  - javascript
  - this
  - web developer
id: 321
categories:
  - Developer Stories
date: 2013-03-09 02:45:01
---

![Picture](https://coderwall-assets-0.s3.amazonaws.com/uploads/picture/file/1351/tumblr_l7bykuDoQ01qag1ubo1_400.jpg)

Let's face it, if you don't know how to use [Chrome Developer Tools](https://developers.google.com/chrome-developer-tools/docs/console) or [Firebug](http://getfirebug.com/), you can hardly call yourself a web developer. However, despite all their amazing features, sometimes both tools fall short solving complex bugs when multiple libraries are involved: they have nested function calls that you don't know where they are or switch the value of 'this'!

In order to solve these sort of bugs, we need alternative strategies to help squash even the meanest bug around town. In this article we will discuss non-common ways and techniques to solve bugs that are hard to fix.

### Problem: Nested functions A.K.A. Who's calling me?

Imagine you have a function X that get's called every once and then with a parameter Y. Most of the time, Y is what you are expecting, but then, in one specific case, it's `undefined`. You know that code is triggered by function A in your super awesome library, yet function A calls multiple functions that can go as far as function B, function C and so on, until they finally hit your function.

If the code is obvious and you are good with the Chrome Dev Tools, you can use [breakpoints](https://developers.google.com/chrome-developer-tools/docs/scripts-breakpoints) to start tracing down the problem. However, if the functions are really nested and the flow of the calling is long, you might take a while before you can actually find a good place to breakpoint. In the other hand, if you have access to the function being used by the library A, then use `caller`:

    function <span class="built_in">X</span>(<span class="built_in">Y</span>){
        console<span class="preprocessor">.log</span>(<span class="built_in">X</span><span class="preprocessor">.caller</span>)<span class="comment">;</span>
    }
    `</pre>
    The `caller` method will tell you which function is calling your function. If the functions is anonymous, you can use the word `this`, given that the function context was not overridden. Other way to do this is through in case the function was not created with a `new` operator is through `arguments.callee`, so the same as before would be:
    <pre>`function <span class="built_in">X</span>(<span class="built_in">Y</span>){
        console<span class="preprocessor">.log</span>(arguments<span class="preprocessor">.callee</span><span class="preprocessor">.caller</span>)<span class="comment">;</span>
    }
    `</pre>
    Be wary that `arguments.callee` is not fully supported, and also discouraged. Can be part of your development code, but shouldn't even be in staging.

    ### Problem: Undefined/wrong values A.K.A. What's the value of `this`?

    With all the context switching Javacript can have and it's lack of scope, you could had been in a situation where the value of a variable is not what you were expecting it to be. One of my favorite examples is this one.
    <pre>`var count = <span class="number">0</span><span class="comment">; </span>
    for ( var i = <span class="number">0</span><span class="comment">; i &lt; 4; i++ ) { </span>
      setTimeout(function(){ 
        console<span class="preprocessor">.log</span>(<span class="string">"Value of i should be equal to count"</span>)<span class="comment">; </span>
        console<span class="preprocessor">.log</span>(<span class="string">"Value of i:"</span>+i)<span class="comment">;</span>
        console<span class="preprocessor">.log</span>(<span class="string">"value of count:"</span>+ ++count)<span class="comment">;</span>
      }, i * <span class="number">200</span>)<span class="comment">; </span>
    }
    `</pre>
    The value of `i` is always 4\. Why? Because the closure doesn't work anymore due the change of context made by the setTimeout. This will fix it:
    <pre>`var count = <span class="number">0</span><span class="comment">; </span>
        for ( var i = <span class="number">0</span><span class="comment">; i &lt; 4; i++ ) { (function(i){</span>
            setTimeout(function(){ 
            console<span class="preprocessor">.log</span>(<span class="string">"Value of i should be equal to count"</span>)<span class="comment">; </span>
            console<span class="preprocessor">.log</span>(<span class="string">"Value of i:"</span>+i)<span class="comment">;</span>
            console<span class="preprocessor">.log</span>(<span class="string">"value of count:"</span>+ count++)<span class="comment">;</span>
          }, i * <span class="number">200</span>)<span class="comment">;  </span>
        })(i)
    }
    `</pre>
    Sometimes problems are not that subtle. Now, imagine this code has fallen in your hands:
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
    _(If code like this actually falls in your hands, I feel sorry for you. This code comes from my [Protip about the keyword `this`](https://coderwall.com/p/qqrexq?i=5&amp;p=1&amp;q=author%3Ajjperezaguinaga&amp;t%5B%5D=jjperezaguinaga))_

    Run `town.whosTheKing()` and you get "undefined is the king of Christmas Town". Bananas. What's going on here? If you read my tip, then you would know that Javascript is breaking the reference to the `this` word, but otherwise, how could you debug this? `.call` to the rescue.

    `.call` changes the value of the `this` object to whatever is given. In this case, we want to see that some properties are properly tied. For example:
    <pre>`town<span class="preprocessor">.whosTheKing</span><span class="preprocessor">.call</span>({name:<span class="string">"Gotham City"</span>, king: <span class="string">"Batman"</span>}) // returns <span class="string">"undefined is the king of Gotham City"</span>
    `</pre>
    With this test, we now know that the method is not using the proper `this` value. Where is the value of `king` then? Let's use the window object now.
    <pre>`town<span class="preprocessor">.whosTheKing</span><span class="preprocessor">.call</span>(window) // returns <span class="string">"undefined is the king of "</span>
    `</pre>
    The properties are declared though, so they have to be stored _somewhere_. Could it be the global head object?
    <pre>`window<span class="preprocessor">.name</span> = <span class="string">"Arkham Asylum"</span><span class="comment">;</span>
    window<span class="preprocessor">.king</span> = <span class="string">"The Joker"</span><span class="comment">;</span>
    town<span class="preprocessor">.whosTheKing</span><span class="preprocessor">.call</span>(window) // returns <span class="string">"The Joker is the king of Arkham Asylum"</span>   

Aha! So they are indeed being stored at the `window` object, aka the global head object. Although it's a silly example, this could had probably been the pattern people figure it out that the reference was being broken when 2 nested levels of context were given.

### Conclusion

Both `.caller` and `.call` are extremely useful native javascript commands that can help you debug your applications. If properly used, they can even form part of your code in order to construct interesting design patterns. Use them in conjunction with your current debug toolset and start squashing bugs.