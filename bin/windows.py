#! /usr/bin/python2
import sys
import subprocess

# WIN+LEFT/RIGHT changes volume, WIN+SHIFT+LEFT/RIGHT makes volume 0 or 100
if sys.argv[1] == 'left':
    subprocess.Popen("/usr/bin/amixer -c 1 sset Master 5-", shell=True)
if sys.argv[1] == 'Left':
    subprocess.Popen("/usr/bin/amixer -c 1 sset Master 0", shell=True)

if sys.argv[1] == 'right':
    subprocess.Popen("/usr/bin/amixer -c 1 sset Master 5+", shell=True)
if sys.argv[1] == 'Right':
    subprocess.Popen("/usr/bin/amixer -c 1 sset Master 100", shell=True)

if sys.argv[1] == 'down':
    s = subprocess.check_output("/usr/bin/xbacklight -get", shell=True)
    if float(s.strip()) >=0:
        subprocess.Popen("/usr/bin/xbacklight -dec 1 -time 1 -steps 1", shell=True)
    else:
        subprocess.Popen("/usr/bin/xbacklight -set 0", shell=True)

# WIN+UP/DOWN changes brightness, WIN+SHIFT+UP/DOWN makes brightness very low or very high
if sys.argv[1] == 'Down':
    subprocess.Popen("/usr/bin/xbacklight -set 3", shell=True)

if sys.argv[1] == 'up':
    s = subprocess.check_output("/usr/bin/xbacklight -get", shell=True)
    subprocess.Popen("/usr/bin/xbacklight -inc 10 -time 1 -steps 1", shell=True)
if sys.argv[1] == 'Up':
    subprocess.Popen("/usr/bin/xbacklight -set 50", shell=True)
