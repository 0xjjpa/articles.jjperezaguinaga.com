title: 'Setting up new Mac Workstation for Developers (homebrew, node, ruby, vagrant, rvm, nvm)'
tags:
  - command line tools
  - gem
  - git
  - homebrew
  - javascript
  - mac
  - mercurial
  - node
  - npm
  - nvm
  - ruby
  - rvm
  - vagrant
  - xcode
id: 247
categories:
  - Developer Stories
date: 2012-10-21 21:10:34
---

I just got a new Mac! It has OSX Lion, so I need to set up all the proper tools for development. Here I'm describing the most up to date configuration I'm using for perform my Web Developer activities. Kuddos to [Svnlto](https://github.com/svnlto), who made the set up 9 months ago which today I just updated. Feel free to see the Gist I updated [here](https://gist.github.com/3925400).

## Install [Command Line Tools for Xcode](https://developer.apple.com/downloads/index.action)

Command Line Tools are required for Homebrew. Previously it was suggested to download Xcode 4, but since the new version doesn’t ship the proper gcc compiler for rvm, the command line tools are a better option and then using homebrew to get the gcc compiler. If preferred, install Xcode 4, although this setup doesn’t follow that set of instructions.

## [iTerm2](http://www.iterm2.com/)

Really the nicest choice for a terminal on OSX right now, especially with Lion style full screen support.

## [Homebrew](http://mxcl.github.com/homebrew/)

    ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"`</pre>
    Note that Xcode is a pre-req for Homebrew

    ## Set shell to ZSH and install oh-my-zsh

    <pre>`curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh`</pre>
    restart iTerm2

    ## SCM

    ### Git

    <pre>`brew install git`</pre>
    http://help.github.com/mac-set-up-git/

    ### Mercurial

    <pre>`brew install mercurial`</pre>
    Copy over your SSH Keys from your existing machine if you have them and want to carry over your existing SSH configs.

    ## [RVM](http://rvm.beginrescueend.com/rvm/install/)

    <pre>`\curl -L https://get.rvm.io | bash -s stable --ruby=rbx --gems=rails,puma`</pre>
    First make sure you run rvm requirements afterwards, and if required rvm reinstall all –force. Also note this command installs rails and puma. If you want plain Ruby use:
    <pre>`\curl -L https://get.rvm.io | bash -s stable --ruby`</pre>
    Some of instructions to pay attention to from rvm requirements:

    Install of apple-gcc42
    <pre>`brew update
    brew tap homebrew/dupes
    brew install autoconf automake apple-gcc42
    rvm pkg install openssl`</pre>
    Install Libksba for Ruby 1.9.3
    <pre>`brew install libksba`</pre>
    To use an RVM installed as default, instead of the system ruby:
    <pre>`rvm install 1.9.3 # installs patch 286: closest supported version
    rvm system ; rvm gemset export system.gems ; rvm 1.9.3 ; rvm gemset import system.gems # migrate your gems
    rvm alias create default 1.9.3  # don't forget to restart your terminal`</pre>

    ### .zshrc

    <pre>`[[ -s "$HOME/.rvm/scripts/rvm" ]] &amp;&amp; . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.`</pre>
    Start new shell session

    #### Install ruby

    <pre>`rvm install 1.9.2
    rvm install 1.8.7
    rvm notes`</pre>
    See if there is anything in the rvm notes you need to take action on. As of this writing the compiler needs to be overridden.

    Create a ~/.gemrc file and add the line

    `gem: --no-ri --no-rdoc`
    <pre>` rvm --default 1.8.7
     rvmsudo gem install bundler
     rvmsudo gem install lunchy`</pre>

    ## Node.js

    ### nvm

    From home (zsh may try to convert nvm to .nvm. Go nay): git clone git://github.com/creationix/nvm.git ~/.nvm

    ### .zshrc

    <pre>`[[ -s "$HOME/.nvm" ]] &amp;&amp; . "$HOME/.nvm/nvm.sh"`</pre>

    ### node.js

    <pre>`nvm install v0.8.12
    nvm alias default 0.8`</pre>
    Unlike RVM that adds the binary version of the node to .zshrc, you need to do it manually according to the version you are using. So for instance:
    <pre>`PATH=$PATH:$HOME/.nvm/v0.8.12/bin # Add NVM to PATH for scripting`</pre>

    ### npm (Latest version of Node already have npm included)

    <pre>`curl http://npmjs.org/install.sh | sh`</pre>

    ## [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

    ### Vagrant

    <pre>`gem install vagrant
    $ vagrant box add base http://files.vagrantup.com/lucid64.box
    $ vagrant init
    $ vagrant up

## ievms

https://github.com/xdissent/ievms

Download and unpack ievms:

Install IE versions 6, 7, 8 and 9.

`curl -s https://raw.github.com/xdissent/ievms/master/ievms.sh | bash`

Install specific IE versions (IE7 and IE9 only for example):

`curl -s https://raw.github.com/xdissent/ievms/master/ievms.sh | IEVMS_VERSIONS="7 9" bash`

Launch Virtual Box.

Choose ievms image from Virtual Box. Install VirtualBox Guest Additions (pre-mounted as CD image in the VM). IE6 only - Install network adapter drivers by opening the drivers CD image in the VM.

Setup new Mac with OSX Lion from