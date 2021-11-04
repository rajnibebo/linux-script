#!/bin/bash

# check the first three parameters

echo "Parameter 1: ${1}"
echo "Parameter 2: ${2}"
echo "Parameter 3: ${3}"
echo

echo "Running while loop now as below:"
# run while loop
while [[ "${#}" -gt 0 ]]
do
  echo "Parameter 1: ${1}"
  echo "Parameter 2: ${2}"
  echo "Parameter 3: ${3}"
  echo
  # shift will do teh shifting of parameters to left 2 will become 1 and 3 will become 2 in the second iteraion, 1 will be lost
shift
# Sleep will cause the program to delay for the specified amount of time
sleep 2s
done
