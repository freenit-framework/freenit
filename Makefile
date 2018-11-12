REGGAE_PATH = /usr/local/share/reggae
SERVICES = backend https://github.com/mekanix/backend-startkit \
	   frontend https://github.com/mekanix/frontend-startkit

.include <${REGGAE_PATH}/mk/project.mk>


collect: up
	@bin/collect.sh

shell: up
	@sudo cbsd jexec user=devel jname=backend /usr/src/bin/shell.sh
