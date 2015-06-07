title: 3 Stages of Web Application Workflow
tags:
  - application
  - cloud
  - ftp
  - hosting
  - process
  - project management
  - source control
  - vps
  - web
  - web development
id: 96
categories:
  - Developer Stories
date: 2011-12-26 20:36:10
---

## **The Shared Hosting Stage**

_Pretty much a cheap garbage can that can host applications. But hey! It's YOUR cheap garbage can._

<span style="color:#ff0000;">**CONS**</span>

Different instances of applications in the same environment (such as Wordpress, Joomla, Magento) eat the already crappy performance of your server.

No organization whatsoever for file management, protection, quota. Nothing. You just upload, upload, and upload.

Development workflow? Fire up FTP client, download, change, upload, oh crap, download, change, upload. Still, don't think for a second that a real application will run here.

Client based source control or none at all. Backups? Manual, every time you heard that someone’s site got hacked.

No collaboration or bug tracking. God and you know what's in there, and at some point only God does.

<span style="color:#339966;">**PROS**</span>

Good for the initial freelancing business (Business card style webpage, personalized email)

A Grooveshark subscription is expensier than most Shared Hosting Providers

## **The VPS Stage**

_Internal Server Errors got the best of you and you got enough to buy your own VPS. Oh the joy! Your first VPS is like your first car, you twich every single thing you can._

<span style="color:#339966;">**<strong>PROS**</strong></span>

Hard Disk Quotas per User, Cpanel and VHM appear, helping you manage every single file in your server.

Data analysis, performance metrics appear. You are suddenly aware of memory leaks, hot linking.

Fantastico Deluxe is your best friend to manage instances of applications in a clean way for each of your clients.

Root access allows you to control anything you want in your server.

You start making sense on your applications by using Source Control, maybe Subversion. You may even have your own shell scripts to schedule a commit or an update.

<span style="color:#ff0000;">**<strong>CONS**</strong></span>

You start focusing more on System Administration more than Application Development; if you are a control freak, you start reporting yourself every single anomaly you encounter.

Installing things from scratch can be the most painful process ever. If you don’t have cPanel or WHM, even installing Wordpress can be annoying. You browse for Kickstart scripts for hours, just to realize that you got a different Linux distro.

Scaling can be hard. If your provider can expand your VP Box, great, if not, get ready to some migration nightmares that will make your worst dream be like walking on sunshine.

## **The Cloud/Application Hosting Stage**

_You got a great idea that will actually be used by a couple thousand users; you need flexibility and power without going all dedicated server. You find a cloud that hosts the programming language you are using with tons of performance improvements features. You fall in love._

<span style="color:#339966;">**<strong>PROS**</strong></span>

Everything is under source control, so you can track any issue, organize a road map or even redo a feature you didn’t want. Updating is a breeze, and providers like Github or Beanstalk are your new best friends to manage your project.

Applications have their own environment so they can run so fast that you may think it’s local.

Cloud providers will use all kind of performance technologies to improve your application in ways you didn’t even know existed. You don’t have to worry anymore about System Administration things like Whitelisting, Weekly backups… Your provider will do it for you.

Need more power? Just get your credit card and start sliding up RAM in your application in the dashboard section.

<span style="color:#ff0000;">**<strong>CONS**</strong></span>

The cost of some clouds will make your wallet cry more than when you were forced to buy presents for your whole family (even the long forgotten political uncle). However, if your application sells, you can find yourself with a promising start up in your hands.

You will miss the control-everything-you-want ability from a VPS or Dedicated Server. But at the same time you know it’s for your own good.