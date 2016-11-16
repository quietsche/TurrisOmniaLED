#!/bin/bash
 
cd /sys/devices/platform/soc/soc:internal-regs/f1011000.i2c/i2c-0/i2c-1/1-002b/leds
 
echo 0 | tee omnia-led:all/autonomous
echo "255" | tee omnia-led:all/brightness
 
leds=( {power,lan{0,1,2,3,4},wan,pci{1,2,3},user{1,2}} )
colors=( {255-{0,127,255}-0,{255,127,0}-255-0,0-{255-0,127-127,0-255},0-{0,127,255}-255,{63-0-127,127-0-255}} )
 
while sleep 0.01; do
  i=$(($i+1))
  echo $(echo ${colors[$(($i%${#colors[*]}))]} | tr '-' ' ') | tee omnia-led\:${leds[$(($i%${#leds[*]}))]}/color
  #echo $(echo ${colors[$(($RANDOM%${#colors[*]}))]} | tr '-' ' ') | tee omnia-led\:${leds[$(($i%${#leds[*]}))]}/color
done
