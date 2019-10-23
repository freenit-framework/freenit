REGGAE_PATH = /usr/local/share/reggae
SERVICES = backend https://github.com/mekanix/backend-startkit \
	   frontend https://github.com/mekanix/frontend-startkit


collect: up
	@bin/collect.sh

shell:
	@make -C services/backend shell


.include <${REGGAE_PATH}/mk/project.mk>
