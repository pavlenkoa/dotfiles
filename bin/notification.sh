#!/usr/bin/python
from os import system
from sys import argv
blacklist = ["Spotify", "Telegram", "Thunderbird", "Youtube"]
play_sound = 1
system("echo %s" % argv[2] ) # this line is for debug proposes only, comment if necessary
try:
    if [ argv[2] != "" ]:
        summary = argv[2]
except:
    summary = ""

if  summary != "" :
    for i in blacklist:
        if summary == i:
            play_sound = 0

if play_sound == 1:
    system("paplay /usr/share/sounds/freedesktop/stereo/message.oga")

