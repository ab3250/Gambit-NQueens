#!/usr/bin/env bash
sudo killall nq1
sudo killall civetweb
#sudo killall wsServer
#sudo killall civetweb

civetweb -document_root ./www -listening_ports 8000 &
 LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH
./nq1 &
google-chrome-stable http://localhost:8000/index.html
