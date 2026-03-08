#!/bin/bash
# Pulls the temp, removes the header, and adds the degree symbol
temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)
echo "${temp}°C"
