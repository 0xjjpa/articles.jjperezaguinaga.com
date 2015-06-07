title: Understanding constructor and prototype
tags:
  - constructor
  - inheritance
  - javascript
  - oop
  - prototype
  - prototype chain
id: 305
categories:
  - Developer Stories
date: 2013-01-16 16:59:23
---

![Picture](https://coderwall-assets-0.s3.amazonaws.com/uploads/picture/file/1148/mark-pearson-cardboard-diy-iron-man-1-537x402.jpg)

We all know Javascript uses a [Prototype Chain](http://mdn.beonex.com/en/JavaScript/Guide/Inheritance_and_the_prototype_chain.html) in order to bring inheritance to the language. In this article we are going to analyze the different keywords `constructor` and `prototype` that help us to use the Prototype Chain properly.

## When, how and what is a ... `constructor`

A `constructor` is a **pointer**. It points to the **Function()** that created the point from which you are retrieving the `constructor` from. Let's see the following code:

    <span class="keyword">var</span> MarkBlueprints = <span class="function"><span class="keyword">function</span> <span class="title">StarkIndustries</span><span class="params">()</span>{</span>}
    `</pre>
    _(We are using named functions in order to show the differences between a simple variable and a function that works as a `constructor`. As a good practice, try to name your functions for easy debugging)_.

    If we used `StarkIndustries` to create an object (in our case a deadly robot), we can say that the object constructor is `StarkIndustries`.
    <pre>`var mark_I =  new MarkBlueprints();
    mark_I.constructor // returns <span class="function"><span class="keyword">function</span> <span class="title">StarkIndustries</span><span class="params">()</span></span>{}
    `</pre>
    Since the constructor is just a reference to a `Function()`, we can call it as many times as we want.
    <pre>`<span class="keyword">var</span> mark_II = <span class="keyword">new</span> (mark_I.constructor)()
    `</pre>
    You might have seen already that the `constructor` property only appears when we use the keyword `new` in our functions. Otherwise, we are just calling that function and not really creating and object but storing the result of that object's processing.

    Any object created through a `new` keyword has a constructor. Example:
    <pre>`new Boolean(<span class="keyword">true</span>).constructor // returns <span class="function"><span class="keyword">function</span> <span class="title">Boolean</span><span class="params">()</span></span> { [native code] }
    [].constructor // returns <span class="function"><span class="keyword">function</span> <span class="title">Array</span><span class="params">()</span></span> { [native code] }
    (<span class="number">10</span>).constructor // returns <span class="function"><span class="keyword">function</span> <span class="title">Number</span><span class="params">()</span></span> { [native code] }
    `</pre>
    _(Wait, why (10).constructor works? Because we are surrounding 10 with parenthesis, allowing Javascript to "wrap" the primitive native value "10" into a "complex object" that uses the Number constructor. Try doing `10.constructor` and you will get an error. Javascript automatically returns the primitive value to its native state after you finish treating it as an object, or in other words, it unwraps it)_

    One of the uses of the constructor is to help you create replicate copies of an object. Since the constructor property is a reference to the function that created the object, as long as you have a copy of the object, it will always point to the original constructor.
    <pre>`<span class="keyword">var</span> MarkBlueprints = <span class="function"><span class="keyword">function</span> <span class="title">StarkIndustries</span><span class="params">()</span><span class="comment">{}</span>
    <span class="title">var</span> <span class="title">mark_I</span> = <span class="title">new</span> <span class="title">MarkBlueprints</span><span class="params">()</span>;</span>
    mark_I.<span class="function"><span class="keyword">constructor</span>;</span> <span class="comment">// returns function StarkIndustries(){}</span>
    <span class="keyword">var</span> MarkBlueprints = <span class="function"><span class="keyword">function</span> <span class="title">StaneIndustries</span><span class="params">()</span><span class="comment">{}</span>
    <span class="title">mark_I</span>.<span class="title">constructor</span>;</span> <span class="comment">// still returns function StarkIndustries(){}</span>
    `</pre>
    The constructor is set by **object**, so changing an object `constructor` property will only change that specific object `constructor`.
    <pre>`<span class="keyword">var</span> mark_II = new (mark_I.<span class="function"><span class="keyword">constructor</span>)<span class="params">()</span>;</span>
    <span class="keyword">var</span> Mark2ndGenBlueprints = <span class="function"><span class="keyword">function</span> <span class="title">StarkEnterprises</span><span class="params">()</span><span class="comment">{}</span>;</span>
    mark_II.<span class="function"><span class="keyword">constructor</span> = <span class="title">Mark2ndGenBlueprints</span>;</span>
    <span class="keyword">var</span> mark_III = new (mark_II.<span class="function"><span class="keyword">constructor</span>)<span class="params">()</span>;</span>
    mark_III.<span class="function"><span class="keyword">constructor</span> // <span class="title">returns</span> <span class="title">function</span> <span class="title">StarkEnterprises</span><span class="params">()</span><span class="comment">{}</span>;</span>
    mark_II.<span class="function"><span class="keyword">constructor</span> = <span class="title">MarkBlueprints</span>;</span> <span class="comment">// Piper wants to rollback the model :(</span>
    mark_III.<span class="function"><span class="keyword">constructor</span> // <span class="title">returns</span> <span class="title">function</span> <span class="title">StarkEnterprises</span><span class="params">()</span><span class="comment">{}</span>, <span class="title">good</span> <span class="title">thing</span> <span class="title">I</span> <span class="title">kept</span> <span class="title">one</span> <span class="title">safe</span> :</span>D
    `</pre>
    There are some patterns that use the `constructor` in order to provide inheritance based patterns as well as to provide factory strategies. Here are some examples:
    <pre>`<span class="function"><span class="keyword">function</span> <span class="title">Robot</span><span class="params">()</span> <span class="comment">{}</span>;</span>
    Robot.prototype.fire = <span class="function"><span class="keyword">function</span><span class="params">()</span> <span class="comment">{ console.log("Sending rockets"); }</span>;</span>
    <span class="function"><span class="keyword">function</span> <span class="title">IronMan</span><span class="params">()</span> <span class="comment">{ Robot.call(this); }</span>;</span> <span class="comment">// calling "parent" constructor</span>
    IronMan.prototype = new Robot(); <span class="comment">// inheritance</span>
    IronMan.prototype.<span class="function"><span class="keyword">constructor</span> = <span class="title">IronMan</span>;</span> <span class="comment">// fixing prototype pointer.</span>
    <span class="keyword">var</span> mark_I = new IronMan();
    `</pre>
    The reason we "fixed" last prototype constructor is because we are expecting developers to use our object constructor in a clean OOP way.
    <pre>`mark_I <span class="keyword">instanceof</span> IronMan <span class="comment">// returns true, perform IronMan operations</span>
    mark_I <span class="keyword">instanceof</span> Robot <span class="comment">// returns true, perform Robot operations</span>
    `</pre>
    We can always rely on the Prototype chain to perform the lookup for methods, but that's a Javascript feature not everyone is familiar with. We used the `prototype` before to show this example, so let's describe `prototype` now.

    ## When, how and what is a ... `prototype`

    The keyword `prototype` is a **property of Function() objects**. No other type of objects have this property. By now you should realize that whenever you type in your console `Object` or `Array` you are actually calling the Javascript default _functions_; give it a try:
    <pre>`<span class="keyword">typeof</span> String <span class="comment">// returns function</span>
    <span class="keyword">typeof</span> Number <span class="comment">// returns function</span>
    <span class="keyword">typeof</span> Boolean <span class="comment">// returns function</span>
    ...
    `</pre>
    _(You are actually calling `window.String`, `window.Number`, `window.Boolean` and so on; since we need a place to store to store our native implementation of these functions, in the browser we use the Global/Head object `window`)_

    The **value of a `prototype` is the object `constructor` that created that specific object**. That's when things get funky. Let's see a couple prototypes:
    <pre>`Boolean.prototype // returns Object Boolean
    String.prototype // returns Object String with methods such as <span class="string">"toUpperCase"</span>
    Function.prototype // returns <span class="function"><span class="keyword">function</span><span class="params">()</span></span> {} <span class="keyword">or</span> <span class="function"><span class="keyword">function</span> <span class="title">Empty</span><span class="params">()</span></span> {}
    `</pre>
    All native and complex objects retrieve to their original constructors, which in this case are themselves. The only exception is the Function prototype, which returns the `Function()` function that created it. Don't confuse it with the constructor, as it's not the same.
    <pre>`<span class="keyword">Function</span>.prototype === <span class="keyword">Function</span>.constructor // returns false, <span class="keyword">Function</span>.constructor is <span class="keyword">function</span> <span class="keyword">Function</span>(){}
    `</pre>
    Most of the time you don't want to be middling with the native prototypes since modifying them will make all the objects that inherit from that prototype be modified as well. This is dangerous, because you don't know which "version" of the prototype you are developing with, the native ones or modified ones. Plus, whenever you do a `for ... in object`, all the prototype properties will show up.
    <pre>`var jerichoMissile = { amountOfMissiles: <span class="number">10</span> }
    Object.proto<span class="keyword">type</span>.<span class="title">containsShrapnel</span> = <span class="keyword">true</span>
    <span class="string">"containsShrapnel"</span> <span class="keyword">in</span> jerichoMissile <span class="comment">// returns true, although if you debug jerichoMissile it doesn't show it</span>
    `</pre>
    As a rule of thumb, don't modify the native prototypes **unless** you want to give missing functionality. For example, in Javascript 1.8.6 a we have the method [Object.watch](https://developer.mozilla.org/en-US/docs/JavaScript/Reference/Global_Objects/Object/watch). If we want to bring this functionality to Javascript 1.8.5, we can extend this functionality through a custom method:
    <pre>`<span class="keyword">if</span> (!Object.proto<span class="keyword">type</span>.<span class="title">watch</span>) { // <span class="title">we</span> <span class="title">ensure</span> <span class="title">we</span> <span class="title">are</span> <span class="title">not</span> <span class="title">overriden</span> <span class="title">a</span> <span class="title">default</span> <span class="title">property</span>
        <span class="title">Object</span>.<span class="title">prototype</span>.<span class="title">watch</span> = function(prop, handler) {
            <span class="comment">// Custom method here.</span>
        }
    }
    <span class="comment">// Full code [here](https://gist.github.com/384583)</span>
    `</pre>
    _(In Javascript 1.8.5 we use the `Object.defineProperty` as a cleaner way to extend an object)_

    What you probably want to do is use `prototype` to create nice reusable code for your custom functions. Let's use an example:
    <pre>`<span class="keyword">var</span> MarkBlueprints = <span class="function"><span class="keyword">function</span> <span class="title">RobotModels</span><span class="params">()</span><span class="comment">{}</span>
    <span class="title">MarkBlueprints</span>.<span class="title">prototype</span>.<span class="title">getRockets</span> = <span class="title">function</span><span class="params">()</span><span class="comment">{ return this.rockets; }</span>
    <span class="title">var</span> <span class="title">mark_I</span> =  <span class="title">new</span> <span class="title">MarkBlueprints</span><span class="params">()</span>;</span>
    mark_I.getRockets() <span class="comment">// returns undefined, boring.</span>

    <span class="comment">// Let's add some rockets!</span>
    <span class="keyword">var</span> Mark2ndGenBlueprints = <span class="function"><span class="keyword">function</span> <span class="title">RocketModels</span><span class="params">()</span><span class="comment">{ this.rockets = 6; }</span>
    // <span class="title">We</span> <span class="title">already</span> <span class="title">coded</span> <span class="title">a</span> <span class="title">way</span> <span class="title">to</span> <span class="title">retrieve</span> <span class="title">rockets</span>, <span class="title">so</span> <span class="title">we</span> <span class="title">update</span> <span class="title">our</span> <span class="title">prototype</span> <span class="title">to</span> <span class="title">use</span> <span class="title">a</span> <span class="title">RobotModel</span> <span class="title">instead</span>
    <span class="title">Mark2ndGenBlueprints</span>.<span class="title">prototype</span> = <span class="title">new</span> <span class="title">MarkBlueprints</span><span class="params">()</span>;</span>
    <span class="keyword">var</span> mark_II = new Mark2ndGenBlueprints();
    mark_II.getRockets() <span class="comment">// returns 6, yeah!</span>

    <span class="comment">// Let's add some lasers!</span>
    <span class="keyword">var</span> Mark3rdGenBlueprints = <span class="function"><span class="keyword">function</span> <span class="title">LaserModels</span><span class="params">()</span> <span class="comment">{ this.lasers = 2; }</span>
    // <span class="title">We</span> <span class="title">don</span>'<span class="title">t</span> <span class="title">have</span> <span class="title">yet</span> <span class="title">a</span> <span class="title">way</span> <span class="title">to</span> <span class="title">retrieve</span> <span class="title">lasers</span>, <span class="title">so</span> <span class="title">we</span> <span class="title">add</span> <span class="title">one</span>.
    <span class="title">Mark3rdGenBlueprints</span>.<span class="title">prototype</span>.<span class="title">getLasers</span> = <span class="title">function</span><span class="params">()</span> <span class="comment">{ return this.lasers; }</span>
    <span class="title">Mark3rdGenBlueprints</span>.<span class="title">prototype</span>.<span class="title">totalWeapons</span> = <span class="title">function</span><span class="params">()</span> <span class="comment">{ return this.lasers + this.rockets; }</span>
    // <span class="title">Shi</span>'<span class="title">em</span> <span class="title">with</span> <span class="title">rockets</span>!
    <span class="title">Mark3rdGenBlueprints</span>.<span class="title">prototype</span> = <span class="title">new</span> <span class="title">Mark2ndGenBlueprints</span><span class="params">()</span>;</span>
    <span class="keyword">var</span> mark_III = new Mark3rdGenBlueprints();
    mark_III.totalWeapons() <span class="comment">// returns TypeError: Object #&lt;RobotModels&gt; has no method 'totalWeapons'</span>
    `</pre>
    What happened? RobotModels? It's supposed to be LaserModel! Well, remember, the prototype's value is the **constructor that created the object**. After updating the prototype of the `LaserModels()` with `RobotModels()`, we also wrote over the constructor, because the constructor's value is the `Function()` that created the object! Then, we overwrote our getLasers and totalWeapons, because the RobotModels don't have such things.
    <pre>`<span class="comment">// Let's fix the reference.</span>
    Mark3rdGenBlueprints.prototype.<span class="function"><span class="keyword">constructor</span> = <span class="title">Mark3rdGenBlueprints</span>;</span>
    <span class="comment">// We need to tell again our methods because we overwrote in the prototype last time!</span>
    Mark3rdGenBlueprints.prototype.getLasers = <span class="function"><span class="keyword">function</span><span class="params">()</span> <span class="comment">{ return this.lasers; }</span>
    <span class="title">Mark3rdGenBlueprints</span>.<span class="title">prototype</span>.<span class="title">totalWeapons</span> = <span class="title">function</span><span class="params">()</span> <span class="comment">{ return this.lasers + this.rockets; }</span>
    <span class="title">var</span> <span class="title">mark_IV</span> = <span class="title">new</span> <span class="title">Mark3rdGenBlueprints</span><span class="params">()</span>;</span>
    mark_IV.totalWeapons() <span class="comment">// returns 8, it's on!</span>
    `</pre>
    There' one final note on prototypes. Prototypes **share** their properties with their objects; it's a good way to store functions, but properties can get messed up really easy if you describe them in the prototypes. Prototype properties work in a similar fashion than `static` variables in classes such as C and Java. Let's see an example:
    <pre>`var IronManBlueprints = function FlyingModel() {}
    IronManBlueprints.proto<span class="keyword">type</span>.<span class="title">missiles</span> = <span class="number">20</span>;
    IronManBlueprints.proto<span class="keyword">type</span>.<span class="title">fireMissiles</span> =  function() { 
        IronManBlueprints.proto<span class="keyword">type</span>.<span class="title">missiles</span>--; <span class="title">return</span> <span class="title">IronManBlueprints</span>.<span class="title">prototype</span>.<span class="title">missiles</span> + " <span class="title">missiles</span> <span class="title">left</span>"; 
    }

    <span class="title">var</span> <span class="title">mark_V</span> = new IronManBlueprints();
    var mark_VI = new IronManBlueprints();
    mark_V.fireMissiles() <span class="comment">// returns "19  missiles left"</span>
    mark_VI.fireMissiles() <span class="comment">// returns "18 missiles left"</span>
    IronManBlueprints.proto<span class="keyword">type</span>.<span class="title">missiles</span> = <span class="number">100</span>;
    mark_V.fireMissiles() <span class="comment">// returns "99  missiles left"</span>
    mark_VI.fireMissiles() <span class="comment">// returns "98 missiles left"</span>

That's why we always use `this` in order to reference a specific instance property. In this case, updating the prototype property changed all the instances properties because they were referencing to the prototype object.

### The [[proto]] property

There's an extra property, `__proto__`, which refers to the **internal [[proto]] property of instance objects**. Unlike `Function()` objects, every `Object` has a `__proto__`. It's not recommended to update the `prototype` of an instance object, as prototypes are not meant to be changed on runtime (you should be able to see who's the proto of who, otherwise you need to spent extra computation in ensuring no cyclic references). Also, this is a non-standard solution and browsers are [not obligated to implement it](http://stackoverflow.com/questions/7015693/how-to-set-the-prototype-of-a-javascript-object-that-has-already-been-instantiat)

Hopefully this helped out to clear out definitions a little bit; a prototype is just an object after all, while a constructor is the pointer to the function that created the object.
