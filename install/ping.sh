#!/usr/bin/env bash
if ping -c 1 -W 1 $1 &> /dev/null
then
  echo -n 1
else
  echo -n 0
fi