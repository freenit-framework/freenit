REGGAE_PATH = /usr/local/share/reggae
SERVICES += backend https://github.com/freenit-framework/backend
SERVICES += frontend https://github.com/freenit-framework/frontend
SERVICES += doc https://github.com/freenit-framework/doc
SERVICES += designer https://github.com/freenit-framework/designer
SERVICES += cli https://github.com/freenit-framework/cli
SERVICES += startkit https://github.com/freenit-framework/frontend-startkit

.include <${REGGAE_PATH}/mk/project.mk>
