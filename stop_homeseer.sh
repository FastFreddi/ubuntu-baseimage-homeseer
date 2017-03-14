#!/bin/bash
/usr/bin/curl 'http://127.0.0.1/LinuxTools' -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' --data 'ConfirmShutdownhs=Yes' --compressed
sleep 10s
