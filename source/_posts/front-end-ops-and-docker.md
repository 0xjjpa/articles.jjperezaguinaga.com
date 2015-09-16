title: Using Docker as part of the workflow of a Front End Engineer
date: 2015-09-06 16:27:53
tags:
---

<img style="max-width: 100%;" src="http://assets.jjperezaguinaga.com/articles/v1/front-end-ops-and-docker/01-front-end-ops-and-docker.png"/>

Over the last few months I had been working with a multiple set of technologies that range from the usual Front End Stack ([Angular.js 2.0](https://angular.io/), [React.js](http://facebook.github.io/react/), [Gulp.js](http://gulpjs.com/), [Browserify](http://browserify.org/)), to the more Backend-ish area type ([Nginx](http://nginx.org/en/), [Lua](http://www.lua.org/), [Python](https://www.python.org/)).

During that journey, I stumbled upon [Docker](https://www.docker.com/), and started using it for my entire development workflow. After working with it actively for a few months, I’ve increased my own personal productivity as a Front End Engineer, allowing me to take full control of the entire Web Application cycle.<!--more-->



# The challenges of a Front End Engineer

To begin with, the development workflow of a Front End Engineer can be quite complicated. Unless you are coding HTML/CSS/JS directly, chances are that you need to setup a series of dependencies and tools that help you deal with one of the multiple tasks required for getting a proper website out there: processing your styles, concatenating them, minifying them alongside your scripts (which were also compiled or transpiled), reviewing the code standards with a linting tool, versioning your assets, serving them on a local development environment with a live reload setup, etc. Nowadays a production ready site requires precise fine tuning to deliver the best quality web experience in the market.

Managing all those dependencies as part of the Front End workflow isn't always simple or a straightforward task. Depending on each project, there's a chance you are using a combination of a task runner ([grunt](http://gruntjs.com/)/[gulp](http://gulpjs.com/)), a module manager loader ([RequireJS](http://requirejs.org/docs/whyamd.html), [Browserify](http://browserify.org/), [Webpack](https://webpack.github.io/)), some sort of javascript transpiler ([Babel](https://babeljs.io/), [Traceur](https://github.com/google/traceur-compiler)) and all sorts of post and pre processing languages and tools to handle HTML, CSS and Javascript. Ensuring that all team members or contributors of a project have everything figured it out and ready for production can be sometimes challenging and requires proper [DevOps](https://en.wikipedia.org/wiki/DevOps) knowledge.

{% wide_image http://assets.jjperezaguinaga.com/articles/v1/front-end-ops-and-docker/02-front-end-ops-and-docker-tasks.png "Assembly all the dependencies inside a Front End project isn't really complex, but requires precise tweaking to ensure all components work correctly, from javascript scripts to the hosted web fonts." %}

<br/>

Another challenge Front End Engineers frequently face, is that after successfully developing their application, they are limited to the web server configuration their application uses. Due the nature of web applications, a production configuration setup can't always be easily repricable and thus, development and production isn't tested all the time. An example of this case is the usage [Gulp/Connect](https://www.npmjs.com/package/gulp-connect) to serve an application on development, while in production it's actually behind a Web Server like [Nginx](http://nginx.org/), which requires additional configuration to perform the same task.

As a result of this, a Front End Engineer needs to have a surprisingly large set of skills that sometimes cover the entire stack of a Web Application. Depending on the size of his/her team, he or she might need to develop the [Virtual development environemt](https://www.vagrantup.com/), handle the [Content Security Policies](http://content-security-policy.com/) of the web server, install it alongside a [Load Balancer](https://aws.amazon.com/elasticloadbalancing/), setup a [SSL certificate](https://en.wikipedia.org/wiki/Transport_Layer_Security), define the [Virtual Private Cloud](https://aws.amazon.com/vpc/), setup a [Logging Strategy](https://www.elastic.co/products), apply a [Monitoring toolset](https://www.nagios.org/) to the infrastructure or even define the overall [Deployment workflow](http://www.go.cd/). It is of no surprise there's an incredible amount of SaaS startups that leverage those tasks from developers in general, and that those Engineers that take over those challenges are [quite hard to find](http://jjperezaguinaga.com/2014/03/19/why-cant-we-find-front-end-developers/).

{% wide_image http://assets.jjperezaguinaga.com/articles/v1/front-end-ops-and-docker/03-front-end-ops-and-docker-components.png "Should a Front End Engineer deal with all those tasks? The line between being a Front End Engineer and a Full Stack Engineer has become more and more blurry. After all, if the application doesn't load, who's responsible of it? A good *-Engineer takes ownership of its product, and learns what needs to be learn to ensure its success." %}

<br/>


# Introducing Docker

**Docker is a virtualisation technology that allows you to wrap your application and its dependencies in an easy standardized package**. In other words, Docker allows you to define your entire application in a way that can be easily transfered and manipulated from one place to another.

The “standardized package” approach provides developers many benefits. For instance, it eases the transition from a one monolithic architecture to a small [Microservices](http://martinfowler.com/articles/microservices.html) one, since each service can be defined as a Docker image. Although this could had been done in the past, Docker technologies like [Compose](https://docs.docker.com/compose/) allow you to define the entire application in one single file.

Another benefit of Docker is its footprint size. Unlike other technologies like [Virtual Machines](https://en.wikipedia.org/wiki/Virtual_machine), Docker is stripped from all the bits that aren't required for running specific applications. As a comparison, the smallest [virtual machine listed](http://www.vagrantbox.es/) for development is around 100MBs, while a virtual machine explicitely used to run docker ([Boot2Docker](http://boot2docker.io/)) is around 27MBs. Companies like [Rancher Labs](http://rancher.com/) have gone as far as [“Dockerising” the OS](http://rancher.com/rancher-os/), allowing you to swap and upgrade elements of the OS, such as the [console](https://en.wikipedia.org/wiki/Linux_console).

{% wide_image http://assets.jjperezaguinaga.com/articles/v1/front-end-ops-and-docker/04-front-end-ops-and-docker-containers.png "For further details about Docker, see the Docker's webpage at https://www.docker.com/whatisdocker." %}

<br/>

# Docker and Front End Engineers

Where does Docker fits in the daily job of a Front End Engineer? In reality, Front End Engineers don't work with only the UI of an application, but also with a set of API's defined by other developers. This means that in most cases, Front End Engineers constanly perform operations that reach Backend services. In short, the job of a Front End Engineer will be as hard or as easy as the time it takes to work with the Backend services their application connects to.

