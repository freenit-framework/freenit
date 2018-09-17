#!/bin/sh


export BIN_DIR=`dirname $0`
export PROJECT_ROOT=`readlink -f "${BIN_DIR}/.."`


if [ -e /usr/local/sbin/cbsd ]; then
  tmux new-session -s "tilda" -d "${PROJECT_ROOT}/services/backend/bin/devel.sh"
  tmux splitw -h -p 50 -t 0 "${PROJECT_ROOT}/services/frontend/bin/devel.sh"
  tmux a
else
  sudo tmux new-session -s "tilda" -d "cbsd jexec user=devel jname=backend /usr/src/bin/devel.sh"
  sudo tmux splitw -h -p 50 -t 0 "cbsd jexec user=devel jname=frontend /usr/src/bin/devel.sh"
  sudo tmux a
fi
