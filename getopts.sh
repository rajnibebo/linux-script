#!/bin/bash

usage() {
  echo "USAGE ${0} with [-vs] [-l LENGTH]" >&2
  echo 'Generating a random password'
  echo '-l Specify the length parameter'
  echo '-s Specify if the special character needs to be appended'
  echo '-v Specify if the verbose mode is on'
}

log() {
  local MESSAGE=${@}
  if [[ ${VERBOSE} = 'true' ]]
  then
    echo "${MESSAGE}"
  fi
}
# This is default length
LENGTH=48

while getopts vl:s OPTION
do
  case {OPTION} in
    v) VERBOSE='true' echo log 'verbose mode on' ;;
    s) USE_SPECIAL_CHARACTER='true' echo log 'Special character check is enabled' ;;
    l) LENGTH=${OPTARG}
    ?) usage ;;
  esac
done

log 'Generating a password'

PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c${LENGTH})

if [[ ${USE_SPECIAL_CHARACTER} = 'true' ]]
then
  log 'Appending Special character to the password'
  SPECIAL_CHARACTER=$(echo '!@#$%^&*()_-+=' | fold -w1 | shuf | head -c1)
  PASSWORD=${PASSWORD}${SPECIAL_CHARACTER}
fi

log 'Done'
log 'Generated password is'

echo "${PASSWORD}"
