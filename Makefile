REGGAE_PATH = /usr/local/share/reggae
SERVICES += backend https://github.com/freenit-framework/backend
SERVICES += axios https://github.com/freenit-framework/doc
SERVICES += doc https://github.com/freenit-framework/doc
SERVICES += designer https://github.com/freenit-framework/designer
SERVICES += designer-svelte https://github.com/freenit-framework/designer-svelte

.include <${REGGAE_PATH}/mk/project.mk>
