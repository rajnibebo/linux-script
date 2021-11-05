#!/bin/bash

# This script reads/writes standard input and standard output.

# create a file and save it in a variable
FILE="/tmp/data"

# Write data to the file
# Redirects output to the file
head -n1 /etc/passwd > ${FILE}

# Redirects output to the file by appending data to the file
head -n3 /etc/passwd >> ${FILE}

echo "Contents of file are "

# print the contents of the file
cat ${FILE}

# Read STDIN to program - Read line from the file
read LINE < ${FILE}
echo "Reading line from a file using STDIN"
echo "${LINE}"
echo

# Read using file descriptors - 0 is the default one but you can specify explicitly
# Always remember not to add space between file desciptor and >/< i.e. 0<, 1>, 2>
read LINE 0< /etc/centos-release
echo "Reading line from a file using File descriptor (FD0)"
echo "${LINE}"

# Write data to file using file descriptor (FD1)
head -n3 /etc/passwd /etc/hosts 1> head.out
echo "Reading standard output file"
echo
cat head.out
echo

# Standard error usage with file descriptor (FD2)
# Here first two files exist which will send output to head.out, third file does not exist, save in error file
head -n3 /etc/passwd /etc/hosts /fakefile > head.out 2> head.err
echo
echo "Read error files and see which errors have been added to head.err file"
cat head.err
echo

# There is a way to send stdout and stderr to the same file, command is as below:
head -n3 /etc/passwd /etc/hosts /fakefile > head.both 2>&1
echo
echo "head.both will have output for stdout as well as stderr"
cat head.both
echo

# Alternate way to send stdout and stderr to the same file
head -n3 /etc/passwd /etc/hosts /fakefile &> head.both
echo
echo "head.both will have output for stdout as well as stderr using alternate way to combine &>"
cat head.both
echo

# We can also append the data to files using file descriptors
# There is a way to send stdout and stderr to the same file, command is as below:
# Remember to use >> with stdout/stderr and not with file descriptors
head -n3 /etc/passwd /etc/hosts /fakefile >> head.append.both 2>&1
echo
echo "head.append.both will have output appended for stdout as well as stderr"
cat head.append.both
echo

# Alternate way to append stdout and stderr to the same file
head -n3 /etc/passwd /etc/hosts /fakefile &>> head.append.both
echo
echo "head.append.both will have output for stdout as well as stderr  appended using alternate way to combine &>"
cat head.append.both
echo

echo "===================================================="
# Standard error does not flow through pipe symbols
head -n1 /etc/passwd /etc/hosts /fakefile | cat -n

echo
echo "In order to pass erros also to pipe symbols use it with &"
head -n1 /etc/passwd /etc/hosts /fakefile 2>&1 | cat -n

echo
echo "Alternate way - In order to pass erros also to pipe symbols use it with &"
head -n1 /etc/passwd /etc/hosts /fakefile |& cat -n

# Null device - dont write output to any file - errors will be written to the console
echo "Following line is only showing standard errors"
head -n1 /etc/passwd /etc/hosts /fakefile > /dev/null
echo "====================================================="

# Null device - dont write any error to any file
echo "Following line is only showing standard output"
head -n1 /etc/passwd /etc/hosts /fakefile 2> /dev/null
echo "====================================================="

echo "You will not see any output in the following line"

# Dont write anything to console, neither STDOUT nor STDERR
head -n1 /etc/passwd /etc/hosts /fakefile &> /dev/null

# Clean up
rm ${FILE} >> /dev/null
