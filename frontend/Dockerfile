FROM ubuntu:16.04
MAINTAINER Xabush Semrie <hsamireh@gmail.com>

#Run apt-get in NONINTERACTIVE mode
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y curl git

#install node
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs

RUN npm install -g @angular/cli
RUN npm install -g nodemon 

ENV HOME /root
RUN mkdir ${HOME}/mozi
WORKDIR ${HOME}/mozi

#RUN npm install

EXPOSE 4200

#ENTRYPOINT  npm install && ng serve
