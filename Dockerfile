# NVM as non root
#
# VERSION     0.1

FROM          ubuntu
MAINTAINER    Robert Krahn <robert.krahn@gmail.com>


# Install dependencies
RUN apt-get update
RUN apt-get -y install build-essential libssl-dev curl git bzip2

# ssh
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:12345' |chpasswd

# node
RUN apt-get install -y python-software-properties python
RUN add-apt-repository ppa:chris-lea/node.js
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ precise universe" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y nodejs

# lively dependencies
RUN npm install forever -g

# sqlite
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get -y install sqlite3 libsqlite3-dev unzip

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
CMD    /usr/sbin/sshd && npm start
