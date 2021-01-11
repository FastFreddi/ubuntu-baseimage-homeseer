#!/bin/bash
# shutdown_controller.sh - HSx-linux tools script
# supports: TOOLS->System->Shutdown System

mono=$(which mono) || exit

trap /sbin/poweroff EXIT

while pgrep -af $mono.'*'\(HSConsole\|HomeSeer\)
do
    sleep 2
done
