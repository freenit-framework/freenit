#!/bin/sh


export BIN_DIR=`dirname $0`
export PROJECT_ROOT="${BIN_DIR}/.."
. "${PROJECT_ROOT}/services/backend/name.py"
export backend_app_name=${app_name}
. "${PROJECT_ROOT}/services/frontend/name.ini"
export frontend_app_name=${app_name}
export OFFLINE=${OFFLINE:="no"}
export REGGAE="no"
export SYSPKG=${SYSPKG:="no"}
export LIB=${LIB:="no"}
export DESIGNER=${DESIGNER:="no"}


if [ "${1}" = "reggae" ]; then
  REGGAE="yes"
fi

if [ "${REGGAE}" = "yes" ]; then
  backend_hostname=$(sudo cbsd jexec user=devel "jname=${backend_app_name}" hostname)
  frontend_hostname=$(sudo cbsd jexec user=devel "jname=${frontend_app_name}front" hostname)
  sudo tmux new-session -s "${backend_app_name}" -d "make -C services/backend devel"
  sudo tmux split-window -h -p 50 -t 0 "make -C services/frontend BACKEND_URL=http://${backend_hostname}:5000 devel"
  if [ "${LIB}" != "no" ]; then
    sudo tmux split-window -v -p 50 -t 1 "make -C services/lib BACKEND_URL=http://${backend_hostname}:5000 devel"
  fi
  if [ "${DESIGNER}" != "no" ]; then
    sudo tmux split-window -v -p 50 -t 0 "make -C services/designer devel"
  fi
  sudo tmux a -t "${backend_app_name}"
else
  backend_hostname='localhost'
  "${BIN_DIR}/download_repos.sh"
  env OFFLINE=${OFFLINE} "${PROJECT_ROOT}/services/backend/bin/init.sh"
  tmux new-session -s "${backend_app_name}" -d "env OFFLINE=${OFFLINE} SYSPKG=${SYSPKG} ${PROJECT_ROOT}/services/backend/bin/devel.sh"
  tmux split-window -h -p 50 -t 0 "env OFFLINE=${OFFLINE} \"${PROJECT_ROOT}/services/frontend/bin/init.sh && env OFFLINE=${OFFLINE} BACKEND_URL=http://${backend_hostname}:5000 ${PROJECT_ROOT}/services/frontend/bin/devel.sh\""
  if [ "${LIB}" != "no" ]; then
    tmux split-window -v -p 50 -t 1 "env OFFLINE=${OFFLINE} \"${PROJECT_ROOT}/services/lib/bin/init.sh && env OFFLINE=${OFFLINE} BACKEND_URL=http://${backend_hostname}:5000 ${PROJECT_ROOT}/services/lib/bin/devel.sh\""
  fi
  tmux a -t "${backend_app_name}"
fi
