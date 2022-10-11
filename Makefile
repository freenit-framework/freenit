REGGAE_PATH = /usr/local/share/reggae
SERVICES += backend https://github.com/freenit-framework/backend
SERVICES += axios https://github.com/freenit-framework/doc
SERVICES += doc https://github.com/freenit-framework/doc
SERVICES += designer https://github.com/freenit-framework/designer
SERVICES += svelte-base https://github.com/freenit-framework/svelte-base

.include <${REGGAE_PATH}/mk/project.mk>
