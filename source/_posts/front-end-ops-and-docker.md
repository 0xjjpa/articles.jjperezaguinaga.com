title: Using Docker as part of the workflow of a Front End Engineer
date: 2015-09-06 16:27:53
tags:
---

<img style="max-width: 100%;" src="https://s3.eu-central-1.amazonaws.com/assets.jjperezaguinaga.com/articles/v1/front-end-ops-and-docker/01-front-end-ops-and-docker.png"/>

Over the last few months I had been working with a multiple set of technologies that range from the usual Front End Stack ([Angular.js 2.0](https://angular.io/), [React.js](http://facebook.github.io/react/), [Gulp.js](http://gulpjs.com/), [Browserify](http://browserify.org/)), to the more Backend-ish area type ([Nginx](http://nginx.org/en/), [Lua](http://www.lua.org/), [Python](https://www.python.org/)).

During that journey, I stumbled upon [Docker](https://www.docker.com/), and started using it for my entire development workflow. After working with it actively for a few months, I’ve increased my own personal productivity as a Front End Engineer, allowing me to finally take full control of the entire Web Application cycle.

<!--more-->

# The challenges of a Front End Engineer

To begin with, the development workflow of a Front End Engineer can be quite complicated. Unless you are coding HTML/CSS/JS directly, chances are that you need to setup a series of dependencies and tools that help you deal with one of the multiple tasks required for getting a proper website out there: processing your styles, concatenating them, minifying them alongside your scripts (which were also compiled or transpiled), reviewing the code standards with a linting tool, versioning your assets, serving them on a local development environment with a live reload setup, etc. Nowadays a production ready site requires precise fine tuning to deliver the best quality web experience in the market.

Managing all those dependencies as part of the Front End workflow isn't always simple or a straightforward task. Depending on each project, there's a chance you are using a combination of a task manager (grunt/gulp), a module manager loader (AMD, Browserify, Webpack), some sort of javascript transpiler (Babel, Traceur) and all sorts of post and pre processing languages and tools to handle HTML, CSS and Javascript). Ensuring that all team members or contributors of a project have everything figured it out and ready for production can be sometimes challenging and requires proper Dev Ops knowledge.

<IMAGE>
The tasks for Front End Engineers

Another challenge a Front End Engineer frequently faces is that after successfully developing their application, they are limited to the configuration of the web server the application is being hosted at. Due the nature of web applications, a production configuration setup can't be always easily repricable and thus, development and production can't be easily tested. An example of this case is the usage Gulp/Connect to serve an application on development, while in production it's actually behind a Web Server like Nginx, which requires additional configuration to make it happen.

As a result of this, a Front End Engineer needs to have a surprisingly large set of skills that sometimes cover the entire stack of a Web Application. Depending on the size of his/her team, he or she might need develop the [Virtual development environemt](https://www.vagrantup.com/), handle the [Content Security Policies](http://content-security-policy.com/) of the web server, install it alongside a [Load Balancer](https://aws.amazon.com/elasticloadbalancing/), setup a [SSL certificate](https://en.wikipedia.org/wiki/Transport_Layer_Security), define the [Virtual Private Cloud](https://aws.amazon.com/vpc/), setup a [Logging Strategy](https://www.elastic.co/products), apply a [Monitoring toolset](https://www.nagios.org/) to the infrastructure or even define the overall [Deployment workflow](http://www.cloud66.com/). It is of no surprise there's an incredible amount of SaaS startups that leverage those tasks 

The line between being a Front End Engineer and a Full Stack Engineer has become more and more blurry. After all, if the application doesn't load, who's responsible of it? A good *-Engineer takes ownership of its product, and learns what needs to be learn to ensure its success.


# Introducing docker

Missed docker. Compare with vagrant. Pros and cons.

