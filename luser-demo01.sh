#!/bin/bash

# This is comment and will not be executed
# This script displays various information to the screen

# Display 'Hello Rajni'

echo 'Hello, Rajni'

#Assign a value to a variable
WORD='script'

#Display that value using variables
echo "$WORD"

#Demonstrate the single quotes versus double quotes
echo '$WORD'

# Combine the variable with hard-code text
echo "This is a shell $WORD"

#Display the variable using an alternative way
echo "This is a shell ${WORD}"

#Append text to the variable
echo "${WORD}ing is fun!"

# Show not to append any text after variables
echo "$WORDing is fun!"

#Creating a new variable
ENDING='ed'

#Combine two variables
echo "This is ${WORD}${ENDING}"

#Change the value stored in the variables
ENDING='ing'
#Combine two variables
echo "${WORD}${ENDING} is fun!"
