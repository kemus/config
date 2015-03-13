#! /usr/bin/bash

# Pipes conky into my dzen2 with some options set
# todo: move these options to another config file?
conky | dzen2 -p -bg black -fg white -x 1253 -y 1100 -w 710 -h 16 -ta r -fn terminus
