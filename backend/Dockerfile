FROM ubuntu:16.04
MAINTAINER Xabush Semrie <hsamireh@gmail.com>

#Run apt-get in NONINTERACTIVE mode
ENV DEBIAN_FRONTEND noninteractive

#Define HOME Var
ENV HOME /root
RUN mkdir /root/mozi_backend
ENV MOZI $HOME/mozi_backend

RUN apt-get update

RUN apt-get install -y software-properties-common python-software-properties wget rlwrap telnet \
                       netcat-openbsd less curl vim python2.7-dbg \
                       tmux man git valgrind gdb cmake gcc g++

RUN apt-get install libboost-dev libboost-date-time-dev libboost-filesystem-dev libboost-program-options-dev libboost-regex-dev libboost-serialization-dev libboost-system-dev libboost-thread-dev -y

# Install Java.

RUN \
  apt-get install -y openjdk-8-jdk && \
  rm -rf /var/lib/apt/lists/*

# Define commonly used JAVA_HOME variable

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/  

#tmp install opencog tools
#ADD https://raw.githubusercontent.com/opencog/ocpkg/master/ocpkg /tmp/octool

#RUN chmod 755 /tmp/octool;  sed -i 's/sudo//g' /tmp/octool; sync; /tmp/octool -rsdopscamv

#Manually Install Cogutils
WORKDIR $HOME

RUN git clone https://github.com/opencog/cogutil.git

WORKDIR cogutil

RUN mkdir build

WORKDIR build

RUN \
    cmake .. && \
    make -j3 && \
    make install

WORKDIR $HOME

#Manually install the atomspace
RUN git clone https://github.com/opencog/atomspace.git

WORKDIR atomspace

RUN mkdir build

WORKDIR build

RUN \
    cmake .. && \
    make -j3 && \
    make install

WORKDIR $HOME


#Manually Install Opencog
RUN git clone https://github.com/opencog/opencog.git

WORKDIR opencog

RUN mkdir build

WORKDIR build

RUN \
    cmake .. && \
    make -j3 && \
    make install

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

WORKDIR $HOME
RUN git clone https://github.com/Habush/guile-json.git
WORKDIR guile-json
RUN \
    apt-get install -y dh-autoreconf && \
    autoreconf -vif && \
    ./configure --prefix=/usr    && \
    make && \
    make install 

WORKDIR $MOZI

EXPOSE 5000

CMD [ "/bin/bash" ]
