FROM ubuntu:16.04
MAINTAINER Xabush Semrie <hsamireh@gmail.com>

#Run apt-get in NONINTERACTIVE mode
ENV DEBIAN_FRONTEND noninteractive
#Define HOME Var
ENV HOME /root
#Update the apt-repo

RUN apt-get update
RUN apt-get install --reinstall ca-certificates
RUN apt-get install -y software-properties-common python-software-properties wget rlwrap telnet \
                       netcat-openbsd less curl vim python2.7-dbg \
                       tmux man git valgrind gdb cmake

#1 ------------ System Dependencies -------------------

#Install Node
RUN \
    curl -sL https://deb.nodesource.com/setup_7.x |bash - && \
    apt-get install -y nodejs

RUN npm install -g @angular/cli


RUN apt-get install libboost-dev libboost-date-time-dev libboost-filesystem-dev libboost-program-options-dev libboost-regex-dev libboost-serialization-dev libboost-system-dev libboost-thread-dev -y

# Install Java.
RUN \
  apt-get install -y openjdk-8-jdk && \
  rm -rf /var/lib/apt/lists/*
# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/   


# Install Redis.
RUN add-apt-repository ppa:chris-lea/redis-server
RUN apt-get update
RUN apt-get install -y redis-server 

RUN service redis-server start

#Install Mongodb
RUN \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
  echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' > /etc/apt/sources.list.d/mongodb.list && \
  apt-get update && \
  apt install -y mongodb-server && \
  apt-get install -y mongodb-org && \
  rm -rf /var/lib/apt/lists/*

RUN service mongodb start

WORKDIR $HOME

#OpenCog Dependencies

ADD https://raw.githubusercontent.com/opencog/ocpkg/master/ocpkg \
    /tmp/octool
RUN chmod 755 /tmp/octool;  sed -i 's/sudo//g' /tmp/octool; sync; /tmp/octool -rsdpcalv

WORKDIR $HOME
RUN git clone https://github.com/opencog/opencog.git
WORKDIR opencog
RUN mkdir build
WORKDIR build
RUN \
    cmake .. && \
    make -j3 && \
    make install
#Install MOSES

WORKDIR $HOME
RUN git clone https://github.com/opencog/moses.git
WORKDIR moses
RUN mkdir build
WORKDIR build
RUN \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make -j2 && \
    make install

ENV JAVA_TOOL_OPTIONS -Dfile.encoding=UTF8
#Install Relex
WORKDIR $HOME
RUN git clone https://github.com/opencog/relex.git
WORKDIR relex/install-scripts
RUN sed -i 's/sudo//g' install-ubuntu-dependencies.sh; ./install-ubuntu-dependencies.sh


#Install AGI-BIO
WORKDIR $HOME
RUN git clone https://github.com/opencog/agi-bio.git
WORKDIR agi-bio
RUN mkdir build
WORKDIR build
RUN \
    cmake .. && \
    make -j2 && \
    make install


ENV AGIBIO /root/agi-bio/moses-scripts
ENV PYTHONPATH $PYTHONPATH:/root/mozi_backend_flask

#3----------------App Dependencies---------------

#install guile-json
WORKDIR $HOME
RUN git clone https://github.com/Habush/guile-json.git
WORKDIR guile-json
RUN \
    apt-get install -y dh-autoreconf && \
    autoreconf -vif && \
    ./configure --prefix=/usr    && \
    make && \
    make install 

WORKDIR $HOME

##Edit the .guile file
RUN echo '(use-modules (ice-9 readline))\n(activate-readline)\n(add-to-load-path "/usr/local/share/opencog/scm")\n(add-to-load-path "/usr/local/share/opencog/scm/opencog")\n(add-to-load-path ".")\n(use-modules (opencog))\n(use-modules (opencog query))\n(use-modules (opencog exec))\n(use-modules (opencog) (opencog bioscience) (opencog openpsi))\n(use-modules (opencog)(opencog nlp relex2logic) (opencog openpsi) (opencog eva-behavior))\n(use-modules (opencog ghost) (opencog python))\n(use-modules (srfi srfi-1))\n(use-modules (ice-9 regex))\n(use-modules (json))(load "/root/ghost/pm_functions.scm")\n(load "/root/ghost/utils.scm")\n(load "/root/ghost/ghost_test.scm")\n(load-scm-from-file "/root/bio-data/scheme-representations/current/GO.scm")\n(load-scm-from-file "/root/bio-data/scheme-representations/current/GO_annotation.scm")\n(ghost-parse-file "/root/ghost/chatrules.top")' > /root/.guile

#Enviroment variable to run celery as root
ENV C_FORCE_ROOT 1

EXPOSE 17001 18001

## REST api
EXPOSE 5000
EXPOSE 17001 18001

## REST api
EXPOSE 5000

## Default RelEx & RelEx2Logic port
EXPOSE 4444

##Default ng server port
EXPOSE 4200
