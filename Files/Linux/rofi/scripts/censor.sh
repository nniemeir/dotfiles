#!/bin/bash
while read -r line; do
grep -l -r "$line" "$1"
done <censor.txt
