#!/bin/sh

name="$1"
list="$(dpkg -l | awk -v name="$name" '$2~name')"

if [ -z "$list" ]; then
  exit 0
else
  echo 'conflicted packages:'
  echo "$list"
  exit 1
fi
