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


if [ "${1}" = "reggae" ]; then
  REGGAE="yes"
fi


if [ "${REGGAE}" = "yes" ]; then
  backend_hostname=$(sudo cbsd jexec user=devel "jname=${backend_app_name}" hostname)
  frontend_hostname=$(sudo cbsd jexec user=devel "jname=${frontend_app_name}front" hostname)
  sudo tmux new-session -s "${backend_app_name}" -d "make -C services/backend devel"
  sudo tmux split-window -h -p 50 -t 0 "make -C services/frontend BACKEND_URL=http://${backend_hostname}:5000 devel"
  sudo tmux a -t "${backend_app_name}"
else
  backend_hostname='localhost'
  "${BIN_DIR}/download_repos.sh"
  env OFFLINE=${OFFLINE} "${PROJECT_ROOT}/services/backend/bin/init.sh"
  tmux new-session -s "${backend_app_name}" -d "env OFFLINE=${OFFLINE} SYSPKG=${SYSPKG} ${PROJECT_ROOT}/services/backend/bin/devel.sh"
  tmux split-window -h -p 50 -t 0 "env OFFLINE=${OFFLINE} \"/usr/src/bin/init.sh && env OFFLINE=${OFFLINE} BACKEND_URL=http://${backend_hostname}:5000 /usr/src/bin/devel.sh\""
  tmux a -t "${backend_app_name}"
fi
