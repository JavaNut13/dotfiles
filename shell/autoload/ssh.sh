#!/bin/bash

_ssh="$(which ssh)"

# Print the hostname when exiting from an ssh connection
ssh() {
  "$_ssh" "$@"
  local res=$?
  echo
  echo -e "Back on \033[38;5;${HOST_COLOR}m$(hostname -s)\033[0m as $(whoami)"
  return $res
}
