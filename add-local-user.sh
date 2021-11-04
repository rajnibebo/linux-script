#!/bin/bash

# This script creates a new user on the local system
# You will be prompted to enter username and password

# Enforce that the script is being executed from the root user
# Root user has the UID as 0.

if [[ "${UID}" -eq 0 ]]
then
  echo 'This script is being executed from root user.'
else
  echo 'Please exit, you dont have the priviledge to tun this script.'
  exit 1;
fi

#Prompt the person who executed the script
read -p 'Please enter the username: ' USER_NAME

read -p 'Enter password for the account: ' PASSWORD

#create the new user
useradd -c 'Adding new user with provided inputs' -m "${USER_NAME}"

# Check the exit status of the previous command, only proceed if its successful, else exit.
if [[ "${?}" -ne 0 ]]
then
  echo 'The user was not added successfully, exiting from the program'
  exit 1
fi

# Set the PASSWORD
echo ${PASSWORD} | passwd --stdin "${USER_NAME}"

# Check the exit status of the previous command, only proceed if its successful, else exit.
if [[ "${?}" -ne 0 ]]
then
  echo 'The user was not added successfully, exiting from the program'
  exit 1
fi

passwd -e "${USER_NAME}"

# Check the exit status of the previous command, only proceed if its successful, else exit.
if [[ "${?}" -ne 0 ]]
then
  echo 'The user was not added successfully, exiting from the program'
  exit 1
fi

#echo 'The user has been added successfully, please find the details as below'
echo
echo "Username: ${USER_NAME}"
echo "Password: ${PASSWORD}"
echo "Host: ${HOSTNAME}"
exit 0
