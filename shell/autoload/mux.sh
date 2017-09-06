#!/bin/bash
# Usage of this script:
# mux new_session_name
# mux existing_session_name
# mux (will list existing sessions)

mux() {
  local name="$1"

  if [ -z "$name" ]; then
    local sessions
    sessions="$(tmux ls)"
    echo "${sessions//: /:		}"
    return
  fi

  if [ "$name" = "-" ]; then
    [ -z "$2" ] && echo "Session name required" && return 1
    if gcd "$2"; then
      name="."
    else
      return 1
    fi
  fi

  if [ "$name" = "." ]; then
    name=${PWD##*/}
  fi

  name="${name//./}"

  if tmux has -t "$name" 2> /dev/null; then
    tmux attach -t "$name"
  else
    tmux new -s "$name"
  fi
}

alias gmux="mux -"

smux() {
  local hostname="$1"
  local session="$2"
  shift 2
  ssh "$hostname" "$@" -t "bash -lc 'mux \'$session\''"
}

sgmux() {
  local hostname="$1"
  local session="$2"
  shift 2
  ssh "$hostname" "$@" -t "bash -lc 'gmux \'$session\''"
}
