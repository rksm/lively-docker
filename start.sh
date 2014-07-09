#!/bin/bash

cd /home/lively/lively-docker

# if [ ! -d LivelyKernel ]; then
#   git clone https://github.com/LivelyKernel/LivelyKernel
# fi

mkdir -p logs

port=9001
container_name=lively-web-server
lively_host_dir=/home/lively/LivelyKernel

docker ps | grep ":$port" | awk '{ print $1 }' | xargs docker stop

if [ -z "$(docker ps -a | grep $container_name)" ]; then
  docker build --rm -t $container_name .
fi

docker run \
    -v $lively_host_dir:/home/lively/LivelyKernel \
    -p 9001:9001 \
    -p 9002:9002 \
    -p 9003:9003 \
    -p 9004:9004 \
    -i -t \
    $container_name \
    /bin/bash --login 
