#!/bin/bash
number=$(expr $1 + $RANDOM % $2)
echo $number
