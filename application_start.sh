#!/bin/bash

# Stop all servers and start the server as a daemon
forever stopall
# forever start /home/ubuntu/nodejs/app.js
cd /home/ubuntu/nodejs
pm2 start ecosystem.config.js
