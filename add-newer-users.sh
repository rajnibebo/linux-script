#!/bin/bash

echo "This is the script executing for user setup on linux"

# Check if the user is super user or not, cover the output for logging in files
if [[ "${UID}" -ne 0 ]]
then
  #echo "$(date +%s): You are not a super user, exiting from script." &>> user_setup.err
  echo "$(date +%s): You are not a super user, exiting from script." >&2
  exit 1
fi

echo "$(date +%s): You are a super user, please continue: " >> /dev/null

# echo "$(date +%s): Enter Username for the user setup:" >> user_setup.out
USER_NAME=${1}
shift
COMMENT=${@}

echo "$(date +%s): Continuing setup for the user: ${USER_NAME}" >> /dev/null

echo "$(date +%s): Start generating password for the selected user: ${USER_NAME}, ${COMMENT}" >> /dev/null

SPECIAL_CHARACTER='!@#$%^&*()_-+='

PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c32)
SELECTED_SPECIAL_CHARACTER=$(echo "${SPECIAL_CHARACTER}" | fold -w1 | shuf | head -c1)

if [[ "${?}" -ne 0 ]]
then
  echo "Some error occurred while generating password. Please try again." &>> user_setup.err
fi

PASSWORD="${PASSWORD}${SELECTED_SPECIAL_CHARACTER}"
echo "Generated password: ${PASSWORD}" >> /dev/null

# Now create the user
useradd -c "${COMMENT}" -m ${USER_NAME}

if [[ "${?}" -ne 0 ]]
then
  echo "User could not be created due to some error. Please try again." &>> user_setup.err
  exit 1;
fi

# Now, pass the generated password to the assigned user using |
echo "${PASSWORD}" | passwd --stdin ${USER_NAME}

if [[ "${?}" -ne 0 ]]
then
  echo "Password could not be set to the user due to some error. Please try again." &>> user_setup.err
  exit 1;
fi

echo "User has been created succesfully." >> /dev/null

# Force the password to be changed on the first login
passwd -e ${USER_NAME}
