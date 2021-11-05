#!/bin/bash

# This script is using case statemnets to match the user input.

case "${1}" in
  start)
    echo 'Starting:'
    ;;
  stop)
    echo 'Stopping:'
    ;;
  status)
    echo 'Status:'
    ;;
  *)
    echo 'Please entre valid string' >&2
    #exit 1
    ;;
esac

# Alternative syntax to invoke

case "${1}" in
  start) echo 'Starting:' ;;
  stop) echo 'Stopping:' ;;
  status | state | --state | --status) echo 'Status:' ;;
  *) echo 'Please select valid option. Exiting' >&2
  exit 1
  ;;
esac
