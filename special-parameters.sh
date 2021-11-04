#!/bin/bash

# Display what the user typed on the command line

echo "User typed in the following command:"
echo "${0}"

DIRECTORY_NAME=$(dirname ${0})
echo "Directory of the file name is: ${DIRECTORY_NAME}"

echo "File name is: $(basename ${0})"

echo "You used $(dirname ${0}) directory to run the $(basename ${0}) script"

NUMBER_OF_PARAMETERS=${#}
echo "Number of parameters used to run the script: ${NUMBER_OF_PARAMETERS}"


# For loop example - consider word with space
for X in 'Frank Reagan' 'Danny Reagan' 'Jamie Reagan'
do
  echo "Hello, ${X}"
done

# For loop example - consider word without space
for X in Frank Reagan Danny Reagan Jamie Reagan
do
  echo "Hello, ${X}"
done

# for loop syntax similar to other programming languages, like java
for (( i = 0; i < 10; i++ )); do
  echo "This is similar to java for loop: ${i} "
done

# for loop with ${*}
# Beware if you use ${*} without double quotes it will behave exactly like ${@}
for X in "${*}"
do
  echo "Hello, ${X}"
done

# for loop with ${@}
for X in "${@}"
do
  echo "Hello, ${X}"
done
