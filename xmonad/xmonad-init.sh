#!/usr/bin/env bash
export PATH=$PATH:/home/chaospie/.local/bin/
compton --backend glx --vsync opengl &
hsetroot -solid black
xmonad 
