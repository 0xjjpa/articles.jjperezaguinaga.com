title: Add your geolocation to Git every time you commit
tags:
  - chrome apps
  - geolocation
  - javascript
  - network
id: 329
categories:
  - Developer Stories
date: 2013-07-19 10:25:57
---

A couple months ago, Github released a [Mapping geoJSON feature](https://help.github.com/articles/mapping-geojson-files-on-github), allowing them to parse any `.geojson` files you have in your repository as maps and easily add them in your website. The maps looks something like this

![Picture](https://coderwall-assets-0.s3.amazonaws.com/uploads/picture/file/1876/Screen_Shot_2013-07-19_at_1.23.08_AM.png)

In this article, I'll show you how to add your geolocation in your repository (and of anyone that wants to share it) every time you perform a commit. This can give as a result a colorful combination of cities and countries that you can showcase in your repository.

## Instructions

1) Install [Geomit](https://chrome.google.com/webstore/detail/geomit/nfneicimlhegkbjabkgceaekpaibobjp). It's a chrome packaged app that retrieves your geographic location through HTML5 and creates a listening TCP server on localhost:8888*.

2) Run Geomit. You will see two windows, one with the Geomit listening message and one with the Pre-commit Hook instructions. Click on the "Copy Pre-commit Hook" button.

3) Paste the pre-commit hook into any repository you want to add a`contributors.geojson`. Since I use sublime, I usually do the following.

![Picture](https://coderwall-assets-0.s3.amazonaws.com/uploads/picture/file/1878/Screen_Shot_2013-07-19_at_11.59.42_AM.png)

4) Continue working as you would. When you commit, Geomit will add a`contributors.geojson` to your repository, or just add your geolocation to it if there's an existing one. Be aware that your repository needs to have a remote origin branch to retrieve your username.

*<small>Disclaimer, I'm the creator of Geomit. Feel free to see the [source code on Github](https://github.com/jjperezaguinaga/Geomit), fork or do anything you want with it</small>.

## Why?

You might had stumbled upon projects like Jquery, Prototype, RaphaelJS, Backbone, AngularJS, Foundation, Twitter Foundation, etc. All of them had been created through many iterations from multiple developers. I had always wondered... where are those developers? From which countries? Is there any way we can say "thank you" with something more than just a "contributors.md"? After Github's Map parsing`contributors.geojson` came to my mind.

It's also a proof of concept. The fact that a browser extension can create a TCP server, transfer files and tag your geographic location is mind blowing. That was impossible just a few years ago.

## Security and Privacy

This project is solely an effort to bring recognition to people all over the world in a more "personal" way. This can only be done by people that is willing so; if no one uses it, no one can see anyone's location.

However, you should be aware that the accuracy your browser location has is scarily good. You are technically tagging your exact location to a possible public space browsable by anyone. There's no login, no anything. Your Github username, your location and the previous SHA of your commit is attached in a file form now on.

By no means you should share your location if you feel uncomfortable doing so, specially in a open source webpage such as Github where it's store in a historical fashion. You can see more details of the technology in the [Github page](https://github.com/jjperezaguinaga/Geomit).