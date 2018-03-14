FROM ubuntu:16.04
MAINTAINER Xabush Semrie <hsamireh@gmail.com>

#Run apt-get in NONINTERACTIVE mode
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y curl
#Install Node
RUN \
    curl -sL https://deb.nodesource.com/setup_7.x |bash - && \
    apt-get install -y nodejs

RUN npm install -g @angular/cli

ENV HOME /root

RUN mkdir /root/mozi

WORKDIR $HOME/mozi

EXPOSE 4200

ENTRYPOINT  npm install && ng serve
