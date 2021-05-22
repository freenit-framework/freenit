REGGAE_PATH = /usr/local/share/reggae
SERVICES += backend https://github.com/freenit-framework/backend
SERVICES += frontend https://github.com/freenit-framework/frontend
SERVICES += doc https://github.com/freenit-framework/doc
SERVICES += designer https://github.com/freenit-framework/designer
SERVICES += cli https://github.com/freenit-framework/cli
SERVICES += startkit https://github.com/freenit-framework/frontend-startkit

do_devel:
.if defined(service)
	@${MAKE} ${MAKEFLAGS} -C services/${service} devel offline=${offline}
.else
	@env OFFLINE=${offline} REGGAE=yes bin/devel.sh `make service_names`
.endif

.include <${REGGAE_PATH}/mk/project.mk>
