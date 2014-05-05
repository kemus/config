#! /usr/bin/bash
amixer -c0 sget Master | awk -F"[]%[]" '/dB/ { print $2 }'
