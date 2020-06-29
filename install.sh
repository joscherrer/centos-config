#!/bin/bash

# Installing these packages :
#   - epel-release
#   - xrdp
#   - xorgxrdp

# 

mkdir -p ~/.local/bin/yadm

sudo yum install epel-release
sudo yum groupinstall 'Development Tools'
sudo yum install xrdp xorgxrdp
curl -fLo ~/.local/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm && chmod a+x /usr/local/bin/yadm


