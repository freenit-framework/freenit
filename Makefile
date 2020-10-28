REGGAE_PATH = /usr/local/share/reggae
SERVICES = backend https://github.com/freenit-framework/backend \
	   frontend https://github.com/freenit-framework/frontend-startkit

do_devel:
.if defined(service)
	@${MAKE} ${MAKEFLAGS} -C services/${service} devel offline=${offline}
.else
	@env OFFLINE=${offline} LIB=${LIB} bin/devel.sh reggae
.endif

.include <${REGGAE_PATH}/mk/project.mk>
