title: 'Converting String to Number in Javascript: Common Pitfalls'
tags:
  - converting string to number
  - dangerous
  - hexadecimal numbers
  - javascript
  - number
  - parseFloat
  - parseInt
  - pitfalls
  - risks
  - string
  - unary operator
  - unary operators
id: 301
categories:
  - Developer Stories
date: 2013-01-11 07:02:10
---

There are many ways to convert a String to a Number. I can think of at least 5 ways to convert a string into a number!

    <span class="function"><span class="title">parseInt</span><span class="params">(num)</span>;</span> // default way (no radix)
    <span class="function"><span class="title">parseInt</span><span class="params">(num, <span class="number">10</span>)</span>;</span> // parse<span class="variable">Int</span> with radix (decimal)
    <span class="function"><span class="title">parseFloat</span><span class="params">(num)</span> // <span class="title">floating</span> <span class="title">point</span>
    N<span class="title">umber</span><span class="params">(num)</span>;</span> // <span class="variable">Number</span> constructor
    ~~num //bitwise <span class="keyword">not</span>
    num / <span class="number">1</span> // diving by one
    num * <span class="number">1</span> // multiplying by one
    num - <span class="number">0</span> // minus <span class="number">0</span>
    +num // unary operator <span class="string">"+"</span>
    `</pre>
    Which one to use when? When? Why? This tip is an analysis of each one and it's common pitfalls.

    According to a couple [benchmarks](http://jsperf.com/number-vs-plus-vs-toint-vs-tofloat/20) in JsPerf.com most browsers have optimal response for ParseInt. Although it may be the fastest, here are some common mistakes parseInt does:
    <pre>`<span class="function"><span class="title">parseInt</span><span class="params">('<span class="number">08</span>')</span> // <span class="title">returns</span> 0 <span class="title">in</span> <span class="title">some</span> <span class="title">old</span> <span class="title">browsers</span>.</span>
    <span class="function"><span class="title">parseInt</span><span class="params">('<span class="number">44</span>.</span></span>jpg') // returns <span class="number">44</span>
    `</pre>
    **parseInt: Always use it with a radix = parseInt(num, 10), don't use it if you don't want it to guess from characters.**

    What about ParseFloat? It's all good if you never handle hexadecimal numbers; for instance:
    <pre>`parseInt(-<span class="number">0</span>xFF) <span class="comment">// returns -255</span>
    parseInt(<span class="string">"-0xFF"</span>) <span class="comment">// returns -255</span>
    parseFloat(-<span class="number">0</span>xFF) <span class="comment">// returns -255</span>
    parseFloat(<span class="string">"-0xFF"</span>) <span class="comment">// returns 0</span>
    `</pre>
    _(Note, a negative hexadecimal number in a string is a special case that will go funky town in your application if you are parsing it. Make sure to always check for NaN values in your app to avoid surprises)_

    Plus, it retains the problem as parseInt with characters in the number:
    <pre>`<span class="function"><span class="title">parseFloat</span><span class="params">('<span class="number">44</span>.</span></span>jpg') // returns <span class="number">44</span>
    `</pre>
    **parseFloat: Be careful with hexadecimal numbers, don't use it if you don't want it to guess from characters."

    The next one is Bitwise not (~). You can use that to convert a string to an integer only, but it's not for floating numbers. The good thing about it is that it will return "0" if a character appears.
    <pre>`~~<span class="number">1.23</span> <span class="comment">// returns 1</span>
    ~~<span class="string">"1.23"</span> <span class="comment">// returns 1</span>
    ~~<span class="string">"23"</span> <span class="comment">// returns 23</span>
    ~~<span class="string">"Hello world"</span> <span class="comment">// returns 0</span>
    `</pre>
    What is it doing? It's ["flipping"](https://developer.mozilla.org/en-US/docs/JavaScript/Reference/Operators/Bitwise_Operators#.7E_(Bitwise_NOT)) each bit, also known as the A1 complement of the number. You can use, but be aware that it's storing integers, so don't use it unless you are sure your number ranges between the values of a signed 32 bit integer (this is because in the spec it calls ToInt32).

    **Bitwise not, use it to ensure input doesn't have a character in it, only for integers**

    What about Number? Number has the same problem that parse* in a way that it will try to figure it out which number you are giving to it:
    <pre>`Number(<span class="string">"023"</span>) <span class="comment">// returns 23</span>
    Number(<span class="number">023</span>) <span class="comment">// returns 19</span>
    `</pre>
    _(Note, 023 is ACTUALLY an octal number. No matter what you do, it will return 19; goes the same for hexadecimal ones without double or single quotes)_

    Number was also one of the slowest outcomes in JsPerf.

    **Number, pretty much don't use it**

    The last ones are unary operators.
    <pre>`<span class="string">"1.23"</span> * <span class="number">1</span> <span class="comment">// returns 1.23</span>
    <span class="string">"0xFF"</span> - <span class="number">0</span> <span class="comment">// returns 255</span>
    <span class="string">"0xFF.jpg"</span> / <span class="number">1</span> <span class="comment">// returns NaN</span>
    +<span class="string">"023"</span> <span class="comment">// returns 23</span>

Unlike the others, unary operators will be really happy to throw you a `NaN` value if they see anything funky. **They are my favorite way to convert numbers**, because anything with a character shouldn't be considered neither 0 or "guessed" according to how many digits it has. I pick most of the time the `+` operator because is the least confusing one. They don't have the best performance though, although `-0` has been giving good results.

### Best way to convert string to a number?

Negative hexadecimal numbers are the only ones that break inside a string. Any other number should be first parsed into a String (through + "" for instance) and then parsed to a number with a unary operator or a parseInt with a radix. parseFloat takes advantage of performance, but can give you some numeric values where a `NaN` is more appropriate.