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

As a result of this, a Front End Engineer needs to have a surprisingly large set of skills that sometimes cover the entire stack of a Web Application. Depending on the size of his/her team, he or she might need to develop the [Virtual development environemt](https://www.vagrantup.com/), handle the [Content Security Policies](http://content-security-policy.com/) of the web server, install it alongside a [Load Balancer](https://aws.amazon.com/elasticloadbalancing/), setup a [SSL certificate](https://en.wikipedia.org/wiki/Transport_Layer_Security), define the [Virtual Private Cloud](https://aws.amazon.com/vpc/), setup a [Logging Strategy](https://www.elastic.co/products), apply a [Monitoring toolset](https://www.nagios.org/) to the infrastructure or even define the overall [Deployment workflow](http://www.go.cd/). It is of no surprise there's an incredible amount of SaaS startups that leverage those tasks from developers in general.

{% wide_image http://assets.jjperezaguinaga.com/articles/v1/front-end-ops-and-docker/03-front-end-ops-and-docker-components.png "Should a Front End Engineer deal with all those tasks? Probably not, but after all, if the application doesn't load, who's responsible of it? A good Engineer takes ownership of the product, and learns what needs to be learn to ensure its success." %}

<br/>


# Introducing Docker

**Docker is a virtualisation technology that allows you to wrap your application and its dependencies in an easy standardized package**. In other words, Docker allows you to define your entire application in a way that can be easily transfered and manipulated from one place to another.

The “standardized package” approach provides developers many benefits. For instance, it eases the transition from a one monolithic architecture to a small [Microservices](http://martinfowler.com/articles/microservices.html) one, since each service can be defined as a Docker image. Although this could had been done in the past, Docker technologies like [Compose](https://docs.docker.com/compose/) allow you to define the entire application in one single file.

Another benefit of Docker is its footprint size. Unlike other technologies like [Virtual Machines](https://en.wikipedia.org/wiki/Virtual_machine), Docker is stripped from all the bits that aren't required for running specific applications. As a comparison, the smallest [virtual machine listed](http://www.vagrantbox.es/) for development is around 100MBs, while a virtual machine explicitely used to run docker ([Boot2Docker](http://boot2docker.io/)) is around 27MBs. Companies like [Rancher Labs](http://rancher.com/) have gone as far as [“Dockerising” the OS](http://rancher.com/rancher-os/), allowing you to swap and upgrade elements of the OS, such as the [console](https://en.wikipedia.org/wiki/Linux_console).

{% wide_image http://assets.jjperezaguinaga.com/articles/v1/front-end-ops-and-docker/04-front-end-ops-and-docker-containers.png "For further details about Docker, see the Docker's webpage at https://www.docker.com/whatisdocker." %}

<br/>

# Docker and Front End Engineers

Docker can help us tackle the challenges Front End Engineers face in terms of dependency management by **defining exactly what our application requires**. Equally, it can help us bridge the gap between our development and production environments by **defining all  the services used inside our applications in all environments**.

### Defining exactly what our application requires

Take for instance an application that requires the following commands:

{% codeblock %}
npm install -g <GLOBAL_PACKAGE>
npm install
<GLOBAL_PACKAGE> some_command
{% endcodeblock %}


To anyone that has worked with NodeJS, it's pretty straightforward what it's going on in here: we are installing a global package like *bower* or *ember* to then make it perform a specific task; this, however, requires NodeJS installed, and installs the dependencies as part of our local system. If we wanted our CI system to work and test this application, we would need to provision it with [Ansible](http://www.ansible.com/) or [Puppet](https://puppetlabs.com/), usually managed by an external DevOps team.

With docker, we can solve this through the following [Dockerfile](https://github.com/https://github.com/dockerfile/nodejs/blob/master/Dockerfile/nodejs) which can sit inside our repository defining how the application needs to build. Because we can now use [Vagrant with Docker](https://docs.vagrantup.com/v2/provisioning/docker.html), we can first use our setup for development and then on our CI for testing and deployment. We could then have a simple setup command through a Makefile that looks like this:

{% codeblock %}
make build
{% endcodeblock %}

{% codeblock Makefile %}
build:
	docker build -f=./docker/Dockerfile ./docker
{% endcodeblock %}

{% codeblock Dockerfile %}
FROM dockerfile/nodejs

ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN mkdir -p /opt/app && cp -a /tmp/node_modules /opt/app/

WORKDIR /opt/app
ADD . /opt/app

CMD ["npm", "build"]
{% endcodeblock %}


By creating a Docker image with our NodeJS services, dependencies, and instructions to install and running the application, we can then run that application to any environment that supports Docker without having to require any provisioning from the Host machine whatsoever. This will help removing some load from your local DevOps or Sysadmin team, while ensuring you have full control of how your application is run.

### Defining all  the services used inside our applications in all environments

If I were to test this website, I would need to require a [Vagrantfile](https://docs.vagrantup.com/v2/vagrantfile/) that defines all the machines I'm using for the application. Since this website has two application servers and one web server, I would need to test against 3 virtual machines. This would not only be expensive, but also slow and hard disk consuming. Even then, I would need to define the machines network inside the Vagrantfile in order to ensure they can communicate with each other.

Instead of doing so, I can use a [Docker Compose file](https://docs.docker.com/compose/yml/) that can define the entire system:

{% codeblock docker-compose.yml %}
balancer:
  image: tutum.co/jjperezaguinaga/balancer
  restart: always
  ports:
    - "80:80"
  links:
    - index:index
    - articles:articles

index:
  image: tutum.co/jjperezaguinaga/webpage
  restart: always
  ports:
    - "8080"

articles:
  image: tutum.co/jjperezaguinaga/articles
  restart: always
  ports:
    - "8080"
{% endcodeblock %}

Here I am using [Tutum's](https://www.tutum.co/) private repository to store the built images, although [Docker Hub's](https://hub.docker.com/) could do as well. I could be running the application servers with NodeJS, but because I prefer generating the static files, I can easily use any sort of HTTP Server to deliver these files. Each image then can have only the static files, saving disk space by removing all the NodeJS dependencies.

{% codeblock Dockerfile%}
FROM gliderlabs/alpine:3.1
MAINTAINER "Jose Aguinaga <me+docker@jjperezaguinaga.com>"
RUN apk-install python

ADD . /opt/www/articles
WORKDIR /opt/www
USER daemon
CMD python -m SimpleHTTPServer 8080
EXPOSE 8080
{% endcodeblock %}

*This isn't necessarily a good practice. I'm building the static files locally with [Hexo](https://hexo.io/) and just serving those. Ideally the build process is part of the Docker image so it can then be tested against a CI system*

# Conclusion

Docker can heavily improve the development workflow of any Software Engineer. Front End Engineers benefit from understanding and using Docker by taking their own share of responsibility in the deployment workflow while helping defining, proposing and testing the entire architecture of the webpage. 

Due the speed and flexibility of Docker, testing technologies like Nginx becomes way easier for a Front End Engineer, and helps lowering the amount of work that other team members have. Although I wasn't familiar with Nginx as I am with other Front End technologies, through Docker I was able to define an architecture that although has its flaws, helps me to deliver what I need for this particular site. 

In case you are curious, [the following is a diagram showcasing each component of the architecture](http://codepen.io/jjperezaguinaga/full/WQbBQe/), and each repository is now available publicly in [Github](https://github.com/jjperezaguinaga). I'm aware the current setup isn't the ideal, so please feel free to describe in the comments overall improvements to the system; currently due it being a one-man operation, the images are build locally and tested against a local machine managed by [Docker Machine](https://docs.docker.com/machine/) and then published through Docker Compose inside [Digital Ocean](https://www.digitalocean.com/) dropplets managed by Docker Machine as well.