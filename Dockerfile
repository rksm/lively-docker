FROM          dockerfile/nodejs
MAINTAINER    Robert Krahn <robert.krahn@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install curl git bzip2 unzip

# nodejs tooling
RUN npm install -g node-inspector
RUN apt-get install lsof
RUN npm install forever -g

# lively
ENV WORKSPACE_LK /var/www/LivelyKernel
RUN mkdir -p /var/www/
ENV livelyport 9001

EXPOSE 9001
EXPOSE 9002
EXPOSE 9003
EXPOSE 9004

CMD chown -R lively:lively $WORKSPACE_LK; \
    cd $WORKSPACE_LK; \
    npm start
