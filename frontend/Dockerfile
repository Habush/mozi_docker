FROM ubuntu:16.04
MAINTAINER Xabush Semrie <hsamireh@gmail.com>

#Run apt-get in NONINTERACTIVE mode
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y curl git

#install node
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs

#ADD ssh keys
#ARG SSH_PRIVATE_KEY
#RUN mkdir /root/.ssh/
#RUN echo "${SSSH_PRIVATE_KEY}" > /root/.ssh/id_rsa
#RUN chmod 400 ~/.ssh/id_rsa

#add gitlab to known hosts
#RUN touch /root/.ssh/known_hosts
#RUN ssh-keyscan gitlab.com >> /root/.ssh/known_hosts
#
RUN npm install -g @angular/cli

ENV HOME /root
RUN mkdir ${HOME}/mozi
WORKDIR ${HOME}/mozi

#RUN npm install

EXPOSE 4200

#ENTRYPOINT  npm install && ng serve
