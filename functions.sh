#!/bin/bash

# This script defines the function and calls them within the script.

log() {
  local MESSAGE="${@}"
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "Please find the message: ${MESSAGE}"
    echo "Adding this message to system logs."
    logger -t functions.sh 'Tagging on'
  fi
}

backup_file() {
  local FILE="${1}"
  # Make sure this file exists
  if [[ -f "${FILE}" ]]
  then
    local BACKUP_FILE="/var/tmp/$(basename ${FILE}.$(date +%F-%N))"
    cp -p "${FILE}" "${BACKUP_FILE}"
    echo 'Backup has been created successfully.'
  else
    return 1
  fi
}

log 'This is the first function call within the script'

# Declare global variable and use within the log function
# Marking it readonly so that other functions can also use it safely.
readonly VERBOSE='true'
log 'This is the second function call within the script'
backup_file '/etc/passwd'
backup_file '/fakefile'
