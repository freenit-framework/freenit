#!/bin/sh


export BIN_DIR=`dirname $0`
export PROJECT_ROOT="${BIN_DIR}/.."
. "${PROJECT_ROOT}/services/backend/name.py"
export backend_app_name=${app_name}
. "${PROJECT_ROOT}/services/frontend/name.ini"
export frontend_app_name=${app_name}


if [ -f /usr/local/bin/cbsd ]; then
  sudo cbsd jexec user=devel "jname=${backend_app_name}" /usr/src/bin/build.sh
  sudo cbsd jexec user=devel "jname=${frontend_app_name}front" /usr/src/bin/build.sh
else
  ${PROJECT_ROOT}/services/backend/bin/build.sh
  ${PROJECT_ROOT}/services/frontend/bin/build.sh
fi

rm -rf ${PROJECT_ROOT}/build/*
cp -r ${PROJECT_ROOT}/services/backend/application/static "${PROJECT_ROOT}/build/"
cp -r ${PROJECT_ROOT}/services/frontend/build/public/* "${PROJECT_ROOT}/build/"
