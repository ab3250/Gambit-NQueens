#!/bin/bash
sudo killall nq1
./nq1 &
disown
sleep 1
./node_modules/electron/dist/electron . &
disown
exit
