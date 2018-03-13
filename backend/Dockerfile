FROM ubuntu:16.04
MAINTAINER Xabush Semrie <hsamireh@gmail.com>

#Run apt-get in NONINTERACTIVE mode
ENV DEBIAN_FRONTEND noninteractive
#Define HOME Var
ENV HOME /root
ENV MOZI $HOME/mozi_backend
WORKDIR $HOME

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

CMD [ "/bin/bash" ]