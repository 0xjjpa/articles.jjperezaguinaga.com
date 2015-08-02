# Initial version
# docker run -d -p 80:8080 --name articles jjperezaguinaga/articles 
FROM gliderlabs/alpine:3.1
MAINTAINER "Jose Aguinaga <me+docker@jjperezaguinaga.com>"
RUN apk-install python

ADD ./public /opt/www
WORKDIR /opt/www
USER daemon
CMD python -m SimpleHTTPServer 8080
EXPOSE 8080
