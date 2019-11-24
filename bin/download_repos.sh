#!/bin/sh

export BIN_DIR=`dirname $0`
export PROJECT_ROOT="${BIN_DIR}/.."

if [ ! -d "${PROJECT_ROOT}/services" ]; then
  mkdir "${PROJECT_ROOT}/services"
fi

if [ ! -d "${PROJECT_ROOT}/services/backend" ]; then
  git clone https://github.com/krlex/freenit-backend"${PROJECT_ROOT}/services/backend"
fi
if [ ! -d "${PROJECT_ROOT}/services/frontend" ]; then
  git clone https://github.com/krlex/freenit-frontend"${PROJECT_ROOT}/services/frontend"
fi
