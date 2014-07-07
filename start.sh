#!/bin/bash

if [ ! -d LivelyKernel ]; then
  git clone https://github.com/LivelyKernel/LivelyKernel
fi

container_name=lively-web-server
if [ -z "$(docker ps -a | grep lively-web-server)" ]; then
  docker build --rm -t $container_name .
fi

docker run \
    -v $PWD/LivelyKernel:/var/www/LivelyKernel \
    -p 9001:9001 \
    -i -t $container_name
