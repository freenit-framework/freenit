#!/bin/sh

export BIN_DIR=`dirname $0`
export PROJECT_ROOT="${BIN_DIR}/.."
. "${PROJECT_ROOT}/services/backend/name.py"
export backend_app_name=${app_name}
export OFFLINE=${OFFLINE:="no"}
export SYSPKG=${SYSPKG:="no"}
RAW_SERVICES=$@
export SERVICES=${RAW_SERVICES:="backend frontend"}
firstone="yes"

if [ "${REGGAE}" != "yes" ]; then
  "${BIN_DIR}/download_repos.sh"
fi

for service in ${SERVICES}; do
  if [ "backend" = "${service}" ]; then
    firstone="no"
    if [ "${REGGAE}" = "yes" ]; then
      export backend_hostname=$(sudo cbsd jexec user=devel "jname=${backend_app_name}" hostname)
      sudo tmux new-session -s "${backend_app_name}" -d "make -C services/${service} devel offline=${OFFLINE}"
    else
      export backend_hostname="localhost"
      tmux new-session -s "${backend_app_name}" -d "env OFFLINE=${OFFLINE} SYSPKG=${SYSPKG} ${PROJECT_ROOT}/services/${service}/bin/devel.sh"
    fi
  fi
done

for service in ${SERVICES}; do
  if [ "backend" = "${service}" ]; then
    continue
  fi
  if [ "${firstone}" = "yes" ]; then
    firstone="no"
    if [ "${REGGAE}" = "yes" ]; then
      sudo tmux new-session -s "${backend_app_name}" -d "make -C services/${service} devel offline=${OFFLINE}"
    else
      tmux new-session -s "${backend_app_name}" -d "env OFFLINE=${OFFLINE} SYSPKG=${SYSPKG} ${PROJECT_ROOT}/services/${service}/bin/devel.sh"
    fi
  else
    if [ "${REGGAE}" = "yes" ]; then
      sudo tmux split-window -h -p 50 -t 0 "make -C services/${service} BACKEND_URL=http://${backend_hostname}:5000 devel offline=${OFFLINE}"
    else
      tmux split-window -h -p 50 -t 0 "env OFFLINE=${OFFLINE} BACKEND_URL=http://${backend_hostname}:5000 ${PROJECT_ROOT}/services/${service}/bin/devel.sh"
    fi
  fi
done

if [ "${REGGAE}" = "yes" ]; then
  sudo tmux select-layout tiled
  sudo tmux a -t "${backend_app_name}"
else
  tmux select-layout tiled
  tmux a -t "${backend_app_name}"
fi
