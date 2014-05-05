#! /usr/bin/bash

# Pipes conky into my dzen2 with some options set
# todo: move these options to another config file?
conky | dzen2 -p -bg black -fg white -x 653 -y 900 -w 710 -h 16 -ta r -fn terminus
