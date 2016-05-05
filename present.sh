#!/bin/bash

#
# A script for reading a text file containing shell commands, and executing
# them one-by-one.
#
# Usage: present.sh <commands-file>
#
#   where <commands-file> is a plain-text file containing shell commmands to
#   execute, one per line.
#
# When invoked as described, this script will:
#   - read a line from the supplied text file that represents a command
#   - echo the line to stdout (with colors!)
#   - wait for any input on the tty (aka waitd for you to hit Enter)
#   - run the command
#   - repeat until the file is exhausted
#
# An example commands file would look like:
#
# cowsay "Hello World\!"
# date
# cowsay $(date)

# An easier way to do colorized output w/ printf/echo
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)

# prints a greeting, using cowsay if available
greeting() {
  if type cowsay >/dev/null 2>&1; then
    cowsay "time to present\!"
  else
    printf "time to present!\n"
  fi
}

greeting

read -p '' dummy </dev/tty

# IFS='' (or IFS=) prevents leading/trailing whitespace from being trimmed.
# -r prevents backslash escapes from being interpreted.
# || [[ -n $line ]] prevents the last line from being ignored if it doesn't end
#    with a \n (since read returns a non-zero exit code when it encounters EOF).
while IFS='' read -r line || [[ -n "$line" ]]; do
  printf "\n${LIME_YELLOW}$ %s${NORMAL}\n" "${line}"

  # we don't really care what $dummy contains, we just want to
  # pause until input is received
  read -p '' dummy </dev/tty

  eval $line
done < "$1"
