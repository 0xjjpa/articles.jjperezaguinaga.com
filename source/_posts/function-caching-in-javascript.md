title: Function Caching in Javascript
tags:
  - cache data
  - caching
  - function
  - hash table
  - javascript
  - john resig
  - memento pattern
  - queue
  - stack
id: 319
categories:
  - Developer Stories
date: 2013-02-16 17:12:06
---

Today we are going to dive into Function Caching in Javascript. Read that again: C-A-C-H-I-N-G. Not **catching**, from `try` and `catch`, as I think there are enough resources in the web that cover that topic. We are going to see Caching, from Cache, like when your browser stores content previously loaded.

## What's Function Caching?

Function Caching, or just Caching means the use of **[memoization](http://en.wikipedia.org/wiki/Memoization)** in order to save processing time in our programs. Usually, this means that we have some sort of data structure that saves previous results so we don't compute them again. Since Javascript's functions behave like objects, we can use the functions themselves instead of external resources.

### Example [1]

    <span class="function"><span class="keyword">function</span> <span class="title">isPrime</span><span class="params">( num )</span> {</span> 
      <span class="keyword">if</span> ( isPrime.cache[ num ] != <span class="literal">null</span> ) 
        <span class="keyword">return</span> isPrime.cache[ num ]; 

      <span class="keyword">var</span> prime = num != <span class="number">1</span>; <span class="comment">// Everything but 1 can be prime </span>
      <span class="keyword">for</span> ( <span class="keyword">var</span> i = <span class="number">2</span>; i &lt; num; i++ ) { 
        <span class="keyword">if</span> ( num % i == <span class="number">0</span> ) { 
          prime = <span class="literal">false</span>; 
          <span class="keyword">break</span>; 
        } 
      } 

      isPrime.cache[ num ] = prime 

      <span class="keyword">return</span> prime; 
    } 

    isPrime.cache = {}; 

The catch is (pun intended) that functions can have properties as objects. In our case, we add a `cache` property which is an Object. An Object, due its nature in Javascript, can work as a [Hash Table](http://en.wikipedia.org/wiki/Hash_table) (actually more like a map or dictionary, but you get the drill) and thus work render the function of a Cache data structure.

## Usage of this feature

*   **Fetching data from a server**: Most of the time you have a function that retrieves information from a server. If you have a cache copy of it, you don't need to hit the server again. You could also add properties such as `lastTimeCalled` in order to save a timestamp on when it was called and only perform the call when the current time is bigger than that cache timestamp.
*   **Implementing a [Memento Pattern](http://en.wikipedia.org/wiki/Memento_pattern) function**: Instead of having a cache Object, have a cache Array (Stack). Push and pop the results of your calls in order to keep states of the results; through an interface, you can provide a "Undo" or "Restore" feature from the Client Side without having to hit a server.
*   **Message Queueing**: If your function is being called through `timeouts`, you can store analytics from it, or even recursive calls through a Cache Queue. You could even have a [Web Worker](https://developer.mozilla.org/en-US/docs/DOM/Using_web_workers) check your Queue every once and then and perform actions according to what it finds in the queue.
Obviously this is no replacement for more powerful features such as the [LocalStorage](https://developer.mozilla.org/en/docs/Storage) feature from HTML5, since it's store in the Javascript Memory Runtime. This means that it will disappear as soon as anyone refreshes the browser. However, this has the benefits of encapsulating the caching as part of the function, whereas other solutions require the creating of external variables, thus increasing dependency.

[1] From [John Resig's page](http://ejohn.org/apps/learn/#21)