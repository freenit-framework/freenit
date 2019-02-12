#!/bin/sh


export BIN_DIR=`dirname $0`
export PROJECT_ROOT=`readlink -f "${BIN_DIR}/.."`


if [ -f /usr/local/bin/cbsd ]; then
  backend_hostname=$(sudo cbsd jexec user=devel jname=backend hostname)
  echo "HTTP_PROXY=http://${backend_hostname}:5000" >"${PROJECT_ROOT}/services/frontend/project.conf"
  sudo cbsd jexec user=devel jname=backend /usr/src/bin/default_user.sh
  sudo tmux new-session -s "tilda" -d "cbsd jexec user=devel jname=backend /usr/src/bin/devel.sh"
  sudo tmux split-window -h -p 50 -t 0 "cbsd jexec user=devel jname=frontend /usr/src/bin/devel.sh"
  sudo tmux a
else
  backend_hostname='localhost:5000'
  "${PROJECT_ROOT}/bin/download_repos.sh"
  echo "HTTP_PROXY=http://${backend_hostname}:5000" >"${PROJECT_ROOT}/services/frontend/project.conf"
  "${PROJECT_ROOT}/services/backend/bin/default_user.sh"
  tmux new-session -s "tilda" -d "${PROJECT_ROOT}/services/backend/bin/devel.sh"
  tmux split-window -h -p 50 -t 0 "${PROJECT_ROOT}/services/frontend/bin/devel.sh"
  tmux a
fi
