title: 'Diving into Clojure: A hello world with Light Table 0.2.0'
tags:
  - clojure
  - clojurescript
  - erlang
  - javascript
  - lein
  - leiningen
  - lighttable
  - scala
id: 256
categories:
  - Developer Stories
date: 2012-11-10 04:32:53
---

If you are like me and happen to lurk around new technologies to try, then you had been observing those fancy languages like Scala, Erlang and Clojure for a long time now. In my case I already tried Erlang (currently checking [Cowboy](https://github.com/extend/cowboy "Cowboy") and [Axiom](https://github.com/tsujigiri/axiom "Axiom"), Erlang flavoured web servers- I'm a web developer after all) a couple months ago and I'm still dealing with the syntax language and matching pattern. But now, it's Clojure turn.

Meet [Clojure](http://clojure.org/ "Clojure"), or actually, meet [LightTable](http://www.chris-granger.com/2012/11/05/meet-the-new-light-table/ "Light Table") first, which is the reason why I picked Clojure over any other language to start to extend my programming languages toolkit. After trying [LiveReload](http://livereload.com/ "LiveReload") and [Yeoman](http://yeoman.io/ "Yeoman") for Front End development, I was convinced that I wanted my next experience with a language to be on real-time basis fashion. I followed LightTable over Kickstart from the very beginning and now that they have an alpha-alpha-alpha product that I can run, I can finally play around

So first, let's get Clojure.

_My assumption is that you already googled what Clojure is and what is not, so I won't say much more than that it's a) a functional language inspired in Lisp b) targets the Java Virtual Machine and c) provides an opportunity for you to dig on distributed computing._

## Getting clojure

After enjoying the benefits of package management utilities, it's impossible to go back (nodijitsus and rubiers will get it). Hence, instead of building Clojure by ourselves, we are going to rely on [Homebrew](http://mxcl.github.com/homebrew/ "Homebrew") and [Leiningen](https://github.com/technomancy/leiningen "Leiningen - Clojure utility") for the job. Leiningen is a Clojure project manager, that helps you bootstrap your Clojure projects, and in our case will be the utility of choice to start playing with Clojure.

_Unixers can use apt-get as far as I know to install Leiningen._

    $ brew install leiningen
    `</pre>
    Now that you have leiningen, feel free to create a new Clojure project (we will dive in the language as soon as we start LightTable, just run the command for now).

    _Lein command will create a folder for you with the Clojure dependencies. Remember it._
    <pre>`$ lein new HelloWorld`</pre>
    All good. Let's get ourselves a copy of LightTable ok? Go [here](http://www.lighttable.com/ "Lightable") and pick your OS. Feel free to click in the "Learn More" section to read about the uses of the tool.

    If you did all correctly -download and install-, you will see this:

    [![](http://jjperezaguinaga.files.wordpress.com/2012/11/lighttable.png "Lighttable")](http://jjperezaguinaga.files.wordpress.com/2012/11/lighttable.png)

    Press the Cmd/Ctrl K to focus on the command bar and type "i" to see the command bar, prompting you to run "instarepl", an "instant" interactive clojure prompt. Press tab if you are lazy like me and then enter.

    [![](http://jjperezaguinaga.files.wordpress.com/2012/11/instarepl.png "instarepl")](http://jjperezaguinaga.files.wordpress.com/2012/11/instarepl.png)

    Exciting! Let's try to type the classic Hello world example ok? In clojure that's as easy as
    <pre>`(println "Hello world")

The first time you open LightTable it will be asking you where is your project.clj. We created this file with Lein, so just type the path where your project is. From there, it will "Connect" to your prompt in order to evaluate your code as you type it (is a little more complex than that, but it basically does this. Go to the LightTable webpage to read more about this).

[![](http://jjperezaguinaga.files.wordpress.com/2012/11/helloworld.png "Helloworld")](http://jjperezaguinaga.files.wordpress.com/2012/11/helloworld.png)

And ta-ta! I don't have much time, but I suggest you to try to play around with it in order to understand the language. If you are a Javascript junkie like me, go to the [Synonym comparison](http://himera.herokuapp.com/synonym.html "Clojurescript and Javascript") of Clojure and Javascript (actually, Clojurescript, but that will be for other day). Here are some tests I made just to test a little syntax, which is similar to Scheme, so it shouldn't be THAT hard. Until next time!

[![](http://jjperezaguinaga.files.wordpress.com/2012/11/experiments.png "Experiments")](http://jjperezaguinaga.files.wordpress.com/2012/11/experiments.png)