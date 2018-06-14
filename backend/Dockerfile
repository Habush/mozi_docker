FROM ubuntu:16.04
MAINTAINER Xabush Semrie <hsamireh@gmail.com>

#Run apt-get in NONINTERACTIVE mode
ENV DEBIAN_FRONTEND noninteractive

#Define HOME Var
ENV HOME /root

RUN mkdir /root/mozi
RUN mkdir /root/bio-data
#Mozi dataset directories
RUN mkdir /root/mozi_datasets
RUN mkdir /root/mozi_datasets/result
#Ghost directories
RUN mkdir /root/ghost

RUN apt-get update

#Install and make python3 default
RUN apt-get install -y python3 python3-dev python3-pip

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 0

RUN update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 0

RUN pip --version

#Install cython
RUN pip install cython

RUN apt-get install -y wget rlwrap telnet netcat-openbsd less curl vim python3-dbg \
                       tmux man git valgrind gdb cmake gcc g++

# Install uwsgi

RUN pip install gunicorn 

# Install Java.

RUN \
  apt-get install -y openjdk-8-jdk && \
  rm -rf /var/lib/apt/lists/*

# Define commonly used JAVA_HOME variable

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/  

##tmp install opencog tools
#ADD https://raw.githubusercontent.com/Habush/mozi_docker/master/ocpkg /tmp/octool
#
#RUN chmod 755 /tmp/octool;  sed -i 's/sudo//g' /tmp/octool; sync; /tmp/octool -rsdscv
#

#Install cogutils dependencies
#Required dependencies

WORKDIR $HOME
RUN apt-get update
RUN apt-get install -y libboost-dev libboost-date-time-dev libboost-filesystem-dev libboost-program-options-dev libboost-regex-dev libboost-serialization-dev libboost-system-dev libboost-thread-dev cmake cxxtest

#Optional dependencies
RUN apt-get install -y binutils-dev libiberty-dev doxygen

#Clone and build cogutils
WORKDIR $HOME

RUN git clone https://github.com/opencog/cogutil.git
WORKDIR cogutil 
RUN git checkout bb2dee8f879e19abd2ea76b27b1b05e891ae2cc4
RUN mkdir build
WORKDIR build
RUN \
    cmake .. && \
    make -j4 && \
    make install

#Install moses dependencies
RUN apt-get install -y libopenmpi-dev

WORKDIR $HOME

RUN git clone https://github.com/opencog/moses.git
WORKDIR moses 
RUN git checkout f8932cb51442e08f7eda4f05814de90d50b41c0a 
RUN mkdir build
WORKDIR build
RUN \
    cmake .. && \
    make -j4 && \
    make install

#Install atomspace dependecies
RUN apt-get install -y  guile-2.0-dev libzmq3-dev libprotobuf-dev

#Clone and build atomspace
WORKDIR $HOME

RUN git clone https://github.com/opencog/atomspace.git
WORKDIR atomspace 
RUN git reset --hard 5f6889c62dd22c089c7fa02b91385d0656d825d5
RUN mkdir build
WORKDIR build
RUN \
    cmake .. && \
    make -j4 && \
    make install

WORKDIR $HOME

RUN git clone https://github.com/opencog/opencog.git
WORKDIR opencog
RUN git reset --hard 40d628c185a2c9fe393fa2e16a9d76cb17fa171b 
RUN mkdir build
WORKDIR build
RUN \
    cmake .. && \
    make -j4 && \
    make install

WORKDIR $HOME


RUN git clone https://github.com/opencog/agi-bio.git
WORKDIR agi-bio
RUN git checkout a461ab38bcf71894ebca1e42badff03a435eaa40 
RUN mkdir build
WORKDIR build
RUN \
    cmake .. && \
    make && \
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

WORKDIR $HOME

# INSTALL GROBID

RUN apt-get install -y unzip 
RUN wget https://github.com/kermitt2/grobid/archive/0.5.1.zip
RUN unzip 0.5.1.zip

WORKDIR grobid-0.5.1
RUN ./gradlew clean install

RUN echo '(use-modules (ice-9 readline))\n(activate-readline)\n(add-to-load-path "/usr/local/share/opencog/scm")\n(add-to-load-path "/usr/local/share/opencog/scm/opencog")\n(add-to-load-path ".")\n(use-modules (opencog))\n(use-modules (opencog query))\n(use-modules (opencog exec))\n(use-modules (opencog) (opencog bioscience))\n(use-modules (opencog nlp) (opencog pointmem) (opencog eva-model) (opencog eva-behavior) (opencog openpsi))\n(use-modules (opencog ghost) (opencog python))\n(use-modules (srfi srfi-1))\n(use-modules (ice-9 regex))\n(use-modules (json))(load "/root/ghost/pm_functions.scm")\n(load "/root/ghost/utils.scm")\n(load "/root/ghost/ghost_test.scm")\n(load-scm-from-file "/root/bio-data/scheme-representations/current/GO.scm")\n(load-scm-from-file "/root/bio-data/scheme-representations/current/GO_annotation.scm")\n(ghost-parse-file "/root/ghost/chatrules.top")' > /root/.guile 

WORKDIR $HOME/mozi

#COPY ./ /root/mozi

RUN pip install git+https://github.com/rantav/flask-restful-swagger.git#egg=flask-restful-swagger

EXPOSE 5000

#ENTRYPOINT exec gunicorn --worker-class eventlet -b 0.0.0.0:5000 wsgi:app 
