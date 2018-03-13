FROM ubuntu:16.04
MAINTAINER Xabush Semrie <hsamireh@gmail.com>

#Run apt-get in NONINTERACTIVE mode
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install curl
#Install Node
RUN \
    curl -sL https://deb.nodesource.com/setup_7.x |bash - && \
    apt-get install -y nodejs

RUN npm install -g @angular/cli

RUN mkdir /mozi

WORKDIR /mozi

COPY ./mozi /mozi/

RUN npm install

EXPOSE 4200

CMD [ "/bin/bash" ]