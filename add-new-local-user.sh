#!/bin/bash

# check if the script is being executed from teh super user or not.
if [[ "${UID}" -ne 0 ]]
then
  echo "Exiting from script as you are not super user"
  exit 1
fi

echo "Authentication successful. You are super user."

USER_NAME="${1}"
COMMENTS=${*}

if [[ ${#} -lt 1 ]]
then
  echo "Please provide username with script as an argument."
  exit 1
fi

echo "Username entered is: ${USER_NAME}"
shift
COMMENTS=${*}
echo "Comments are: ${COMMENTS}"

echo "Generating password for the newly added user..."

SPECIAL_CHARACTER='!@#$%^&*()_-+='
SPECIAL_CHARACTER=$(echo ${SPECIAL_CHARACTER} | fold -w1 | shuf | head -c1)
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c32)
PASSWORD=${PASSWORD}${SPECIAL_CHARACTER}

if [[ "${?}" -ne 0 ]]
then
  echo "Password could not be generated due to some error. Please try again."
  exit 1;
fi

echo "Password has been generated successfully."
# Now add the user
useradd -c "${COMMENTS}" -m "${USER_NAME}"

if [[ "${?}" -ne 0 ]]
then
  echo "User could not be executed due to some error. Please try again."
  exit 1;
fi

echo "User has been added succesfully."


echo ${PASSWORD} | passwd --stdin ${USER_NAME}

if [[ "${?}" -ne 0 ]]
then
  echo "Password could not be set to the user due to some error. Please try again."
  exit 1;
fi

# Force the password to be changed on the first login
passwd -e ${USER_NAME}

echo "Username : ${USER_NAME}"
echo "Password : ${PASSWORD}"
echo "Host : ${HOSTNAME}"
