#! /usr/bin/bash
# Parses the volume using amixer
amixer -c1 sget Master | awk -F"[]%[]" '/dB/ { print $2 }'
