#!/bin/sh

export BIN_DIR=`dirname $0`
export PROJECT_ROOT="${BIN_DIR}/.."

if [ ! -d "${PROJECT_ROOT}/services" ]; then
  mkdir "${PROJECT_ROOT}/services"
fi

if [ ! -d "${PROJECT_ROOT}/services/backend" ]; then
  git clone https://github.com/freenit-framework/backend "${PROJECT_ROOT}/services/backend"
fi
if [ ! -d "${PROJECT_ROOT}/services/frontend" ]; then
  git clone https://github.com/freenit-framework/frontend "${PROJECT_ROOT}/services/frontend"
fi
if [ ! -d "${PROJECT_ROOT}/services/axios" ]; then
  git clone https://github.com/freenit-framework/axios "${PROJECT_ROOT}/services/axios"
fi
if [ ! -d "${PROJECT_ROOT}/services/doc" ]; then
  git clone https://github.com/freenit-framework/doc "${PROJECT_ROOT}/services/doc"
fi
