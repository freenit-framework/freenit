#!/bin/sh


export BIN_DIR=`dirname $0`
export PROJECT_ROOT="${BIN_DIR}/.."
. "${PROJECT_ROOT}/services/backend/name.py"
export backend_app_name=${app_name}
. "${PROJECT_ROOT}/services/frontend/name.ini"
export frontend_app_name=${app_name}


if [ -f /usr/local/bin/cbsd ]; then
  make -C services/backend collect
  make -C services/frontend collect
else
  env SYSPKG=${SYSPKG} ${PROJECT_ROOT}/services/backend/bin/collect.sh
  env SYSPKG=${SYSPKG} ${PROJECT_ROOT}/services/frontend/bin/collect.sh
fi

rm -rf ${PROJECT_ROOT}/build/*
cp -r ${PROJECT_ROOT}/services/backend/static "${PROJECT_ROOT}/build/"
cp -r ${PROJECT_ROOT}/services/frontend/build/* "${PROJECT_ROOT}/build/"
