#!/bin/sh


export BIN_DIR=`dirname $0`
export PROJECT_ROOT="${BIN_DIR}/.."
. "${PROJECT_ROOT}/services/backend/name.py"
export backend_app_name=${app_name}
. "${PROJECT_ROOT}/services/frontend/name.ini"
export frontend_app_name=${app_name}
export OFFLINE="${OFFLINE:=no}"


if [ -f /usr/local/bin/cbsd ]; then
  backend_hostname=$(sudo cbsd jexec user=devel "jname=${backend_app_name}" hostname)
  frontend_hostname=$(sudo cbsd jexec user=devel "jname=${frontend_app_name}front" hostname)
  sudo cbsd jexec user=devel jname="${backend_app_name}back" env OFFLINE=${OFFLINE} /usr/src/bin/init.sh
  sudo tmux new-session -s "web" -d "cbsd jexec user=devel jname=${backend_app_name}back env OFFLINE=${OFFLINE} /usr/src/bin/devel.sh"
  sudo tmux split-window -h -p 50 -t 0 "cbsd jexec user=devel jname=${frontend_app_name}front env OFFLINE=${OFFLINE} BACKEND_URL=http://${backend_hostname}:5000 /usr/src/bin/devel.sh"
  sudo tmux a -t "web"
else
  backend_hostname='localhost:5000'
  "${BIN_DIR}/download_repos.sh"
  env OFFLINE=${OFFLINE} "${PROJECT_ROOT}/services/backend/bin/init.sh"
  tmux new-session -s "web" -d "env OFFLINE=${OFFLINE} ${PROJECT_ROOT}/services/backend/bin/devel.sh"
  tmux split-window -h -p 50 -t 0 "env OFFLINE=${OFFLINE} BACKEND_URL=\"http://${backend_hostname}:5000\" ${PROJECT_ROOT}/services/frontend/bin/devel.sh"
  tmux a -t "web"
fi
