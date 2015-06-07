title: 'Showcase: Course Registration System'
tags:
  - javascript
  - knockoutjs
  - single resource commit
  - transaction based commit
  - ubc
  - user experience
  - user interface
id: 299
categories:
  - UX and UI
date: 2013-02-05 01:59:07
---

_The following project was created as part of the class Human Computer Interaction by Maclean, Karon, teacher at UBC in Vancouver Canada. Team members include Ali Alabbas, Ryan Taylor, Daniel Conde, Ricky Chen and myself. Responsibilities included UX design and UI prototyping through Javascript and [KnockoutJS](http://knockoutjs.com/ "KnockoutJS")._

Feel free to browse the code at [Github](https://github.com/jjperezaguinaga/UBC-CoursesWorklist "UBC Courses Worklist") and see the [demo](http://jjperezaguinaga.github.com/UBC-CoursesWorklist/ "UBC Courses List Demo").

[caption id="" align="alignnone" width="648"]![](https://raw.github.com/jjperezaguinaga/UBC-CoursesWorklist/master/app/images/prototypes/Worklist%20prototype%20v5.png) UBC Registration Course Redesign[/caption]

# The Problem

As a student, registering for courses is always a pain. I have seen multiple interfaces and I have yet to see one that doesn't want me to throw my laptop away. Since most systems have long transactions based steps, they have to load information multiple times in order to ensure the user gets the latest "state" of, let's say, a class status.

This architecture of ensuring the last state of the courses provides most of the time a poor user experience for students. Every action performed has to be checked on with the system in order to ensure that it's valid. This looks something like this:

[![Check every transaction](http://jjperezaguinaga.files.wordpress.com/2013/02/screen-shot-2013-02-04-at-7-26-48-pm.png)](http://jjperezaguinaga.files.wordpress.com/2013/02/screen-shot-2013-02-04-at-7-26-48-pm.png)

A rectangle represents a UI action performed by a student, while a circle a system check with the database. If a student wants to register N courses, he has to perform the UI action N times. This is defined as _Single Resource UI_, where each resource (in this case the course) is submitted to a system to check, and there's no way around it.

# The solution proposal

Our proposal for this problem was to create a **T****ransaction Based UI**.

[![Transaction UI](http://jjperezaguinaga.files.wordpress.com/2013/02/screen-shot-2013-02-04-at-7-35-01-pm.png)](http://jjperezaguinaga.files.wordpress.com/2013/02/screen-shot-2013-02-04-at-7-35-01-pm.png)

In comparison with our previous architecture, the user only needs to perform 1 UI action that performs N system checks. The results on whether the action succeeded or not can be displayed in a First-Come First-Serve (FCFS) fashion through a Message Queue the UI is listening too._
_

Advantages of a Transaction Based UI (TBUI) over a Single Resource UI (SRUI)

1.  <span style="color:#000000;">**Response is UI-Based instead of User-based**</span>: In the SRUI the orden in which the resource is submitted (which course is asked to be registered first) is the orden in which the system will check the resource. _The availability of the resource is given by the speed of the user to reserve the resource. _Through the TBUI the system has enough information to provide a _throttle _in order to allocate the resource to whoever performed the _entire_ transaction first: As long as the UI is fast enough, the allocation of the resource depends on who actually came first and no who picked one resource over other first.
2.  **State save: **Since we are performing transactions, even if one of them didn't succeed (as shown in the figure), we can save a state on that specific transaction in order to perform the same action later, without having to leverage the task to the user, but to the UI that stores the resource UI's. If an architecture change is proposed, even a _rollback _feature can be added to the system.
3.  **Message Queuing:** With the SRUI the system can only give as much as only 1 message per operation. In contrast, the TBUI can provide as many operations as the system can parallel the resource allocation. Through a _Message Queue_, the response can be given as soon as the system solves the allocation, without having to worry on what sort of implementation the underlaying system performs the operation.
The result is shown in the first image of this post. Through a Javascript based UI, we showed how a TBUI can be created. In our case, we used KnockoutJS in order to assemble the transaction while doing only O(1) operations on submission. We use AJAX to perform the transactions and although it was not coded, the _Promise _pattern from AJAX allows us to return results based on the response on the server. Future work could involve the use of Web Sockets were a creation of a biduplex sockets allow us to listen to the server as the course allocation is resolved.