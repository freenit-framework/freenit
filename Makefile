REGGAE_PATH = /usr/local/share/reggae
SERVICES = backend https://github.com/freenit-framework/backend \
	   frontend https://github.com/freenit-framework/frontend-startkit


build: up
	@bin/build.sh

shell:
	@make -C services/backend shell

do_devel: up
.if defined(service)
	@${MAKE} ${MAKEFLAGS} -C services/${service} devel
.else
	@env OFFLINE=${offline} SYSPKG=${SYSPKG} bin/devel.sh reggae
.endif

.include <${REGGAE_PATH}/mk/project.mk>
