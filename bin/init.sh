#!/bin/sh

# Config Section
# --------------
export VIRTUALENV="web-startkit"

BIN_DIR=`dirname $0`

if [ ! -d "${BIN_DIR}/../backend" ]; then
    git clone https://github.com/mekanix/backend-startkit "${BIN_DIR}/../backend"
fi
if [ ! -d "${BIN_DIR}/../frontend" ]; then
    git clone https://github.com/mekanix/frontend-startkit "${BIN_DIR}/../frontend"
fi

BACKEND_ROOT=`readlink -f "${BIN_DIR}/../backend"`
FRONTEND_ROOT=`readlink -f "${BIN_DIR}/../frontend"`

"${BACKEND_ROOT}/bin/init.sh"
"${FRONTEND_ROOT}/bin/init.sh"
