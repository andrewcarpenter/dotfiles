#!/usr/bin/bash

# http://superuser.com/questions/52483/terminal-tips-and-tricks-for-mac-os-x

function pman {
    man -t "${1}" | open -f -a /Applications/Preview.app
}

function preview {
  `groff -Tps > /tmp/tmp.ps && open -a Preview /tmp/tmp.ps`
}