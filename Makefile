SHELL=/bin/bash
HEXO=./node_modules/hexo/bin/hexo
DOCKER=/usr/local/bin/docker

# Configurable variables
DIST=./public
DOCKER-FILE=Dockerfile
DOCKER-REPO=jjperezaguinaga/articles
DOCKER-REGISTRY=tutum.co

build-app:
	$(HEXO) generate

build-image:
	cp $(DOCKER-FILE) $(DIST)
	$(DOCKER) build -t=$(DOCKER-REPO) $(DIST)
