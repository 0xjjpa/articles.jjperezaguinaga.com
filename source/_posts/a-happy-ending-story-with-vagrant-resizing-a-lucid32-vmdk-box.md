title: 'A happy ending story with Vagrant [Resizing a Lucid32 vmdk box]'
tags:
  - disk
  - drive
  - expand
  - extend
  - halt
  - hd
  - increase
  - lucid
  - resize
  - ubuntu
  - vagrant
  - vdi
  - virtualbox
  - vmdk
id: 221
categories:
  - Developer Stories
date: 2012-04-03 06:36:04
---

_This is an article focused on resizing an ubuntu lucid 32 vagrant box using gparted and other linux utilities. It's mixed with colorful stories so I don't get too bored while my server is copying my 100 gbs box._ _If you want to skip the colorful stories, click [here](#resize)._

Lately I had been working tons. Not only because college has been dreadfully demanding, but also because I needed to finish a project I was supposed to turn in **months ago**. Don't look at me, it was not my fault! The system I'm talking about was made by multiple entities (yeah, let's go for entities) and made testing, developing, deploying, well, almost anything in a common development process, plain impossible. If that was not enough, one of the components of the system takes about a **month **to run. (Yep, your eyes aren't fooling you, a month. I mean, for real, I don't even know how to code something that takes a month to run; pretty sure the OS would be like "Not so fast my friend, what the heck do you think you are doing? Have you ever heard about timeouts?").

Anyway, that's not so important. Actually, the project was a simple web app that interacted with Win32 components and managed their outputs in order to produce reports. That wasn't so bad, but back then my experience in web was mainly with PHP, so I decided to use that for the job (_If I could go back in time, I would had chosen C# for the job, seems a better fit for Windows like systems)_. And as you can imagine, PHP and Windows exes are the ingredients for a disaster.

**A Web Server Nightmare**

The problem was not *really* PHP. Usually, I develop under [XAMPP ](http://www.apachefriends.org/es/xampp.html "XAMPP") which is *OK* for development but a total no no for production. I realized that soon after I finished the project and tried to deploy it; debugging the windows exes was almost impossible, since I could barely run them and had no control whatsoever on their processes. Apache under Windows is configured in some way that logs are a nightmare, and I always forget where the files are. Where's my /var/www? /etc?

Since they were window exes, I thought the best option would be then [IIS](http://www.iis.net/ "IIS"), which is as you can guess Windows Web Server option. Then I remember, "Silly Jesus, you have no idea about IIS".

[caption id="attachment_222" align="alignnone" width="565" caption="This is how I feel when I'm coding in IIS. Active Directory? Can I chown it?"][![](http://jjperezaguinaga.files.wordpress.com/2012/04/i_have_no_idea_what_i_m_doing.jpg "I have no idea what I")](http://jjperezaguinaga.files.wordpress.com/2012/04/i_have_no_idea_what_i_m_doing.jpg)[/caption]

_Fine. You got me. I do know something about IIS, I just wanted to put that dog picture. Ain't he cute?_

So obviously my next choice was my beloved, plain [Apache](http://httpd.apache.org/ "A patched server!") under Ubuntu. Now, the reason why I didn't want to start with Ubuntu right away was because I was handed Window exes and had no source code whatsoever. However, after sniffling a little bit around them with [WinHex](http://www.winhex.com/winhex/index-e.html "WinHex") I discovered they were coded in Pascal, so a big ol' [Wine](http://www.winehq.org/ "Wine!") would do the job. I did the test and it did work indeed! (_You may think "Well, in which case does Wine fails?". I think it does with .NET based applications, from v 3.x &gt;, but of course, you have [Mono](http://www.mono-project.com/Main_Page "Mono mono mono") for that_).

It wasn't that easy though. I was handed a Windows server for deployment so I had to stick around Xampp for a long time. It wasn't until my tests failed in the server that I realized that I needed something to deploy my environment in the server so everything would actually work: the server, the application, and the windows components.

**Vagrant to the rescue!**

I didn't know about [Vagrant ](http://vagrantup.com/ "Vagrant")until a few weeks ago. To be honest, I never needed it; cloud environments had been making things so easy to deploy that this project was the first time I faced such an environmental challenge (pun intended).

Since this post is about Vagrant, I'm pretty sure you already know what's about. The tl;dr version describes vagrant as **virtualized development that you can share so people can stop using the excuse "it works in my computer".** It pretty much packages your environment in a virtual machine (which is a good strategy to not pollute your workstation) so you can share it to other people without breaking things up.

So how could I use it in my case? Well, I was installing tons of things in my Ubuntu for this project:

*   Wine
*   Apache
*   Php + Pear (PhpUnit)
*   Codeigniter
*   Configuration for all of the above, includin apache group permissions for wine...
Creating a manual for all that, was not only tiring but dangerous. What if the sysadmin of the server my app was going to deploy decided to chown the wrong folders? The application could get hacked easily and guess who will get the blame?

So I decided to use Vagrant :D at the beginning it was beautiful. I picked a 80gbs box (cause I was going to use tons of files, like, tons) with 320 ram and ubuntu lucid 32 bits in it. It was so simple, Vagrant up, install everything you need, and halt after you are done. Just ♥ it.

But then things got dark. **I used all my 80 gbs of hd and still needed about 40gbs for it.** I stumbled across many pages but with no effort: stackoverflow answers were specific about some systems while google groups had many unanswered questions. I thought it was going to be as easy as with a slider or a command but that was not the case. After struggling for 4 hours, I was able to successfully expand my box and continue with my project. Here's how I made it.

**<a name="resize"></a>Resizing a Vagrant Box (Using Windows Server as a Host, Ubuntu lucid32 sample box from Vagrant.es -third page, hosted by vagrant team- expanding from 80gbs to 300 gbs)**

_If you want to know how to expand an existing hard drive under a vagrant box, saying, a vmdk box, you are in the right place. I'll use some VirtualBox commands as well as the gui, so pay attention._

1.  **Make sure your VM is off (halt or down) and you unattach the disk from your VM:** You can do this by either halting the VM from command line with vagrant halt/down and then openning VirtualBox Gui. In the setting &gt;&gt; storage for that specific VM, right click in the vmdk you want to expand and then choose "Delete connection". (It's the only option, I'm using VirtualBox 4.1).
2.  **Clone your disk into a new, VDI format one:** There are two reasons we are doing. The first one is because you need a backup; if you mess up a stage, just go to the VirtualBox gui and attach your old disk and no warm will be done. The second is because VirtualBox can resize a virtual disk but only in VDI format. We clone it with the command _VBoxManage clonehd "PATH_TO_BOX.VMDK" "PATH_TO_BOX.VDI" --format VDI_
3.  **Resize your cloned disk:** Thanks to countless hours in the internet, I found that you can simple resize a box (Vagrant won't care) using the command_ VBoxManage modifyhd "PATH_TO_BOX.VDI" --resize 307200_. In my case, that was 300 gbs. (yikes!).
4.  **Attach the cloned, resized disk:** Using the VirtualBox gui, go to settings &gt;&gt; storage in your VM and then pick in your controller (SATA, IDE), add new Disk, then pick "Select an existing one".
5.  **Download a Gparted Live CD Iso:** I used [Gparted Live 0.12.0-5.iso](http://sourceforge.net/projects/gparted/files/gparted-live-stable/ "Gparted"). If you have an IDE controller with an empty CD, then you can just click it, and at the right sidebar click on the CD icon to browse it.
6.  **Load Gparted at boot:** Start the machine FROM VIRTUAL BOX (not vagrant). Just press ESC or in my case F12 when the VirtualBox screen shows up so the Gparted boot screen loads. Select the command line option, as you won't need the gui.
7.  **Follow the next 6 instructions from this page:** (No, I'm not kidding) [http://itknowledgeexchange.techtarget.com/itanswers/how-to-resize-an-lvm-root-partition/](http://itknowledgeexchange.techtarget.com/itanswers/how-to-resize-an-lvm-root-partition/) _(note, in the second step, don't do reboot, do shutdown instead, as you will need to load Gparted again, as the VM also simulates the eject of the CD in shutdown)._
8.  **Vagrant up all the way: **After all that, shutdown, close down VirtualBox and go to your command line and vagrant up. Everything should be as nothing happened but now you have more HD!
And that's it. You may say, well, that's a lot of things to do! Actually, they are not for the price of not foreseeing the use of a hard disk, but sure, I feel you. I had tried it with a couple of boxes and it does work perfectly, without harming my current environment whatsoever.

I hope you liked it! It did work for me, but of course, I can't assure anything, or make myself responsible for any damages. Remember, back up is your friend! See you next time!