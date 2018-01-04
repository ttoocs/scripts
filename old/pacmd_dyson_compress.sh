#!/bin/bash

#MST=alsa_output.pci-0000_00_1b.0.analog-stereo
MST=$1
lbl=$2

pacmd load-module module-ladspa-sink sink_name=ladspa_sink master=$MST plugin=dyson_compress_1403 label=$2 control=0,1,0.5,0.99
#pacmd load-module module-ladspa-sink sink_name=ladspa_sink master=$MST plugin=dyson_compress_1403 label=dysonCompress control=0,1,0.5,0.99
