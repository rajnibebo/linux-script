#!/bin/bash

# This script creates an account on the local system.
# You will be prompted for name and password.

# Ask for user USER_NAME
read -p 'Enter the username to create: ' USER_NAME
# Ask for real name
read -p 'Enter the name of the person who is using the account: ' COMMENT
# Ask for the password
read -p 'Enter the password for the account : ' PASSWORD
# Create the user.
useradd -c "${COMMENT}" -m ${USER_NAME}
# Set the password for the user
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Force password Change on first login.
passwd -e "${USER_NAME}"
