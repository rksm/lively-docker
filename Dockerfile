# NVM as non root
#
# VERSION     0.2

FROM          ubuntu:trusty
MAINTAINER    Robert Krahn <robert.krahn@gmail.com>

# Install dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install build-essential libssl-dev curl git bzip2 unzip

# ssh
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:12345' |chpasswd

# node
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common python
RUN DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:chris-lea/node.js
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ precise universe" >> /etc/apt/sources.list
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs

# lively dependencies
RUN npm install forever -g

# sqlite
RUN apt-get -y install sqlite3 libsqlite3-dev

# lively helper: not absolutely required but nice to have
RUN apt-get -y install tidy

# lively
RUN mkdir -p /var/www/
RUN git clone https://github.com/LivelyKernel/LivelyKernel /var/www/LivelyKernel

WORKDIR /var/www/LivelyKernel
RUN npm install
ENV WORKSPACE_LK /var/www/LivelyKernel

# PartsBin
RUN node -e "require('./bin/env'); require('./bin/helper/download-partsbin')();"
# ADD PartsBin/ /var/www/LivelyKernel/PartsBin/ # <-- alternative

# object DB
ADD objects.sqlite.exported /var/www/LivelyKernel/objects.sqlite.exported
RUN sqlite3 objects.sqlite < objects.sqlite.exported
RUN rm objects.sqlite.exported

# Let it fly!
EXPOSE 22
EXPOSE 9001
CMD    /usr/sbin/sshd && forever bin/lk-server.js -p 9001
