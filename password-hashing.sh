#!/bin/bash
# This script shows cryptography techniques and generating automatic passwords

# Generate random numbers
echo 'There is a Random variable provided by the shell builtin, see below:'
echo "${RANDOM}"

echo 'Using combination of two randoms as password as:'
PASSWORD="${RANDOM}${RANDOM}"
echo "${PASSWORD}"

echo 'Use date/time as the password as:'
PASSWORD=`date +%s`
echo "${PASSWORD}"

echo 'Use date/time with nanoseconds as the password as:'
PASSWORD=`date +%s%N` # somehow this is not working properly, please check
echo "${PASSWORD}"

echo 'An even better password is as below:'
PASSWORD=`date +%s%N$RANDOM$RANDOM | sha256sum | head -c32`
echo "${PASSWORD}"

echo 'Add special character to the password'
SPECIAL_CHARACTER='!@#$%^&*()_+-='
#echo "${SPECIAL_CHARACTER}" | fold -w1 | shuf | head -c1

SPECIAL_CHARACTER=`echo "${SPECIAL_CHARACTER}" | fold -w1 | shuf | head -c1`

echo "${PASSWORD}${SPECIAL_CHARACTER}"
