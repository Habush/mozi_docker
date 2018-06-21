FROM opencog/opencog-dev:cli 
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

RUN python3 -m pip uninstall pip 

RUN python -m pip install pip==9.0.3

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
#RUN chmod 755 /tmp/octool;  sed -i 's/sudo//g' /tmp/octool; sync; /tmp/octool -rdops
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

#RUN /tmp/octool -aow; ccache -C

RUN git clone https://github.com/opencog/agi-bio.git
WORKDIR agi-bio
#RUN git checkout 1fc313d66dd330f46db14f002b87bd4122ba5445 
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

COPY .guile $HOME

WORKDIR $HOME/mozi

#COPY ./ /root/mozi

RUN pip install git+https://github.com/rantav/flask-restful-swagger.git#egg=flask-restful-swagger

EXPOSE 5000

#ENTRYPOINT exec gunicorn --worker-class eventlet -b 0.0.0.0:5000 wsgi:app 
