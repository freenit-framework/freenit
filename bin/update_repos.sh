#!/bin/sh

export BIN_DIR=`dirname $0`
export PROJECT_ROOT="${BIN_DIR}/.."
SERVICES_ROOT="${PROJECT_ROOT}/services"

cd "${SERVICES_ROOT}"
ls -1 | while read service; do
  echo "${service}"
  cd "${service}"
  git pull
  cd -
done
cd ..
git pull
