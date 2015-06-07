title: 'Diving into Erlang - Part 1 Introduction, setting up and hello world'
tags:
  - computer science problems
  - devops
  - erlang
  - parallel computing
  - puppet
  - software
  - vagrant
id: 266
categories:
  - Developer Stories
date: 2012-11-15 07:12:39
---

_This is part of a series of posts I will be making about Erlang. I will be reviewing some of quirks of the language, implementing some computer science problems in Erlang and finally setting up a web server with either Cowboy or Jaws. This is by no means an extensive guide, from which you should look at [Learn Yourself Some Erlang](learnyousomeerlang.com/content "Erlang Tutorial")._

So, Erlang. As surprising as this may sound for many, it's a programming language that has been around for almost [thirty years](http://en.wikipedia.org/wiki/Erlang_(programming_language) "Wikipedia entry on Erlang"). It's a functional language that works through the Java Virtual machine and provides an easy to learn environment for topics such as distributed computing and parallel processing. You most likely are learning it for fun or because it suddenly started to become a more popular language. If so, welcome, we are going to have fun learning about this odd but really interesting language.

## The Hype

Of all the [languages](http://en.wikipedia.org/wiki/List_of_programming_languages "Programming Languages List") around, why Erlang became so famous suddenly*? I can think of two reasons: reason number one is Amazon. In 2007, when they released [SimpleDB](http://aws.amazon.com/simpledb/ "Simple DB"), they said that their backbone was Erlang, a language unheard by many (see foot note). Why did a well-known high infrastructure dependant picked this language? The second reason is that people started to create amazing things with Erlang; take for instance [CouchDB](http://couchdb.apache.org/ "CouchDB"), a mapreduce, distributable nosql json structured database management system and [RabbitMQ](http://www.rabbitmq.com/ "Rabbit MQ"), a queue messaging passing system applications. Those both applications work really well and people had been lurking around wondering what where they made in. The answer, Erlang.

_*By famous I refer that it's being used more in colleges and universities. Plus, online sites such as [InterviewStreet](https://www.interviewstreet.com/challenges/ "Interview Street") now allow developers to use it as a language to solve ACM-ICPC/Top Coder style programming challenges. If that's not famous in the Computer Science world, I don't know what it is. And by suddenly, I mean around 5 years, which for a 30 years old language, it's pretty good if you ask me._

## Setting up

If you got to this point then you might be itching for some Erlang now. First, we need to set it up, and to do so we are going to use a virtual machine. Why? Because unless you know what you are doing, you probably want to keep your workstation empty. Also, Erlang versions may get updated and trying new releases can get messy and pollute your $PATH. As a rule, you should always try to contain experiments in a controlled environment (you don't see scientists running with bottles around the street do you?)

For that, we are going to use [Vagrant](http://vagrantup.com/ "Vagrant"), which allows us to create Virtual Machines on the go. If you don't have it, download it already for your operating system or through Ruby, install the Gem:

    gem install vagrant`</pre>
    (I'm assuming you are using Ruby through [RVM](https://rvm.io/ "RVM") right? Right? You should also create a gemset for experiments, or something like that)

    From there, we are going to add up a Virtual machine to work as our little lab. I personally love Ubuntu, but you could pick something else. Go to [VagrantBox.es](http://www.vagrantbox.es/ "Vagrant Box"), which has a lists of already wrapped Vagrant Boxes for us to play around with and download one that has Puppet in it (we are going to use it to manage install Erlang in our local machine). After you picked it up, use the following command:
    <pre>`vagrant box add {title} {url}`</pre>
    So in my case, and for reference of the tutorial, I did this:
    <pre>`vagrant box add Ubuntu https://dl.dropbox.com/u/1543052/Boxes/UbuntuServer12.04amd64.box`</pre>
    Good! Let's go to a folder and start our vagrant file, and then use Puppet magic to install Erlang.

    ## Puppet

    [Puppet](http://puppetlabs.com/ "Puppet by Puppet Labs") is a configuration management tool that allow us to control the packages installed inside our virtual machine. The reason why I pick using Puppet instead of just using my distro package manager (classic apt-get install, for instance) is because that way I know the state of my machine. Even better, you don't need to care about which OS you are using, as Puppet will do this for you. I can also upgrade or change the packages in that machine if required, or discard it if I what it's inside is of no use anymore. In my case, I have many machines with experiments in it, and sometimes I just need to add the proper puppet files to add up a package to an existing "lab".

    **Installing Erlang**

    Ready to install Erlang? Go to your project file with the command line,  and do the following commands; remember that I wrote Ubuntu because that's the box I picked previously.
    <pre>`$ vagrant init Ubuntu
    `</pre>
    A VagrantFile was created, open it up with your favorite code editor and modify it to add of provisioning with Puppet. Here's the code for that:
    <pre>`Vagrant::Config.run do |config|  
      config.vm.box = "Ubuntu" #Replace it with your own Box.
      config.vm.provision :puppet
    end`</pre>
    Before we do the vagrant up, we need to create the actual Puppet manifest file. By default, vagrant uses the folder "manifests" and the puppet file "default.pp" Here's the initial config.
    <pre>`$ mkdir manifests
    $ vi manifests/default.pp`</pre>
    Add the following.
    <pre>`package {'erlang':
      ensure =&gt; present,
    }`</pre>
    _Note: This will install Erlang in your Virtual machine using your distro package manager. At the moment, most package managers will have 14B version installed, which is fine for a Hello World but not useful for later. Have this in mind, as I will update this later for a Puppet Module._

    All good! Ready to vagrant up?
    <pre>`$ vagrant up`</pre>
    _Note: This may take some time depending on your internet connection. If you have any problems, write it down in a comment... I most likely already encounter it. _

    As a final step and after the prompt tells you all the packages were "ensured", just ssh inside the Virtual Machine with the following command.
    <pre>`$ vagrant ssh`</pre>

    ## Hello world, Erlang!

    We are now inside in our Virtual Machine and we have Erlang installed. To test it out, just type the interactive erlang prompter command, erl.
    <pre>`$ erl `</pre>
    If you just type and enter, nothing happens. As a first note, Erlang finishes all their statements with a dot ("."). Think of it at's the semi-colon of Java. To exit the prompt, use q(). Don't forget the dot at the end.
    <pre>`&gt; q().`</pre>
    Well, that wasn't very exciting right? You probably would want to try the Pattern Matching concept in Erlang by using the common variable assign example.
    <pre>`&gt;A = 5.
     ok.
    &gt;B = 5.
     ok.
    &gt;A = 8.
    ** exception error: no match of right hand side value 
    Erlang will freak out, because you already assigned 5 to A. This is a principle of functional programming. Refresh your Variables with f().`</pre>
    What about Atoms and Variables? Atoms are lowercase, Variables are uppercase. A variable can hold an atom, while an atom can't.
    <pre>`&gt;A = atom.
    atom
    &gt;atom = 5.
    ** exception error: no match of right hand side value 5
    `</pre>
    Just to finish this section, I'll show you the hello world of Erlang.
    <pre>`&gt;io:format("Hello ~w~n", [world])

That's all for this time! I suggest you that before the next post, read more about Erlang, as I will most likely dive directly into CS problems, parallelism and process. I will also dig into using the Debugging and Appmon utilities from Erlang. Until next time!

P.S. Try using World uppercase, and use it with quotes ;)