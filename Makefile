REGGAE_PATH = /usr/local/share/reggae
SERVICES += backend https://github.com/freenit-framework/backend
SERVICES += frontend https://github.com/freenit-framework/frontend

do_devel:
.if defined(service)
	@${MAKE} ${MAKEFLAGS} -C services/${service} devel offline=${offline}
.else
	@env OFFLINE=${offline} DESIGNER=${DESIGNER} LIB=${LIB} bin/devel.sh reggae
.endif

.include <${REGGAE_PATH}/mk/project.mk>
