#!/bin/bash
echo $((`cat /sys/class/backlight/intel_backlight/brightness`+${1:-100})) | tee /sys/class/backlight/intel_backlight/brightness
