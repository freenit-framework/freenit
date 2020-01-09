SERVICES += lib https://github.com/freenit-framework/frontend
CBSD_WORKDIR != sysrc -n cbsd_workdir

lib:
	@${MAKE} ${MAKEFLAGS} -C services/lib lib

lib_mount:
	@sudo mount -t nullfs "${PWD}/services/lib/dist" "${CBSD_WORKDIR}/jails/freenitfront/usr/src/node_modules/freenit/dist"
	@sudo mount -t nullfs "${PWD}/services/lib/node_modules" "${CBSD_WORKDIR}/jails/freenitfront/usr/src/node_modules/freenit/node_modules"
