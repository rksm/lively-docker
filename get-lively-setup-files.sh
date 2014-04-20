#!/bin/bash

rm objects.sqlite
scp -P 40922 root@127.0.0.1:/var/www/LivelyKernel/objects.sqlite .

rm -rfd PartsBin/
scp -P 40922 -r root@127.0.0.1:/var/www/LivelyKernel/PartsBin .
