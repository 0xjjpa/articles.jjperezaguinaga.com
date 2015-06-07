title: REST HTTP Verbs in one image.
tags:
  - back-end
  - development
  - front-end
  - http verbs
  - rest
id: 294
categories:
  - Developer Stories
date: 2012-12-10 11:31:38
---

# Introduction

REST is a beautiful and simple way to represent the resources you have in your application; as a Front End Engineer, REST provides me a layer to communicate statelessly with my resources without having to worry about anything else. As a Back End Engineer, I can describe the behaviour of my system in resources and even mock them in the meantime for Front End Engineers so we can be in the same track how the application is being built.

Yet, I still see some developers using things like $.post(...) to perform a delete call inside a system. According to the [Richardson Maturity Model](http://martinfowler.com/articles/richardsonMaturityModel.html), we are to use the proper HTTP Verbs in order to take advantage of the benefits of REST such as the idempotence of specific verbs (GET, PUT, DELETE) and catching.

For people that still need a clear example on when to use which specific HTTP verb, I'm leaving here a diagram with an easy to understand example for each of the basics HTTP verbs (OPTIONS and HEAD not covered). This comes from the free ebook [Web API Design](http://info.apigee.com/Portals/62317/docs/web%20api.pdf). Hope it helps!

![REST Example](http://jjperezaguinaga.files.wordpress.com/2012/12/screen-shot-2012-12-10-at-3-16-18-am.png)