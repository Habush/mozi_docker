FROM ubuntu:16.04
MAINTAINER Xabush Semrie <hsamireh@gmail.com>

#Run apt-get in NONINTERACTIVE mode
ENV DEBIAN_FRONTEND noninteractive

#Define HOME Var
ENV HOME /root
RUN mkdir /root/mozi_backend
ENV MOZI $HOME/mozi_backend

RUN apt-get update

#Make python3 the default python
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 0

RUN apt-get install -y wget rlwrap telnet netcat-openbsd less curl vim python3-dbg \
                       tmux man git valgrind gdb cmake gcc g++



# Install Java.

RUN \
  apt-get install -y openjdk-8-jdk && \
  rm -rf /var/lib/apt/lists/*

# Define commonly used JAVA_HOME variable

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/  

#tmp install opencog tools
ADD https://raw.githubusercontent.com/Habush/mozi_docker/master/ocpkg /tmp/octool

RUN chmod 755 /tmp/octool;  sed -i 's/sudo//g' /tmp/octool; sync; /tmp/octool -rsdopscamv

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

WORKDIR $HOME

RUN echo '(use-modules (ice-9 readline))\n(activate-readline)\n(add-to-load-path "/usr/local/share/opencog/scm")\n(add-to-load-path "/usr/local/share/opencog/scm/opencog")\n(add-to-load-path ".")\n(use-modules (opencog))\n(use-modules (opencog query))\n(use-modules (opencog exec))\n(use-modules (opencog) (opencog bioscience) (opencog openpsi))\n(use-modules (opencog)(opencog nlp relex2logic) (opencog openpsi) (opencog eva-behavior))\n(use-modules (opencog ghost) (opencog python))\n(use-modules (srfi srfi-1))\n(use-modules (ice-9 regex))\n(use-modules (json))(load "/root/ghost/pm_functions.scm")\n(load "/root/ghost/utils.scm")\n(load "/root/ghost/ghost_test.scm")\n(load-scm-from-file "/root/bio-data/scheme-representations/current/GO.scm")\n(load-scm-from-file "/root/bio-data/scheme-representations/current/GO_annotation.scm")\n(ghost-parse-file "/root/ghost/chatrules.top")' > /root/.guile 

EXPOSE 5000

CMD [ "/bin/bash" ]
