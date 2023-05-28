REGGAE_PATH = /usr/local/share/reggae
FQDN ?= example.com
USE = letsencrypt ldap
SERVICES += backend https://github.com/freenit-framework/backend
SERVICES += axios https://github.com/freenit-framework/doc
SERVICES += doc https://github.com/freenit-framework/doc
SERVICES += designer https://github.com/freenit-framework/designer
SERVICES += svelte-base https://github.com/freenit-framework/svelte-base
BACKEND != reggae get-config BACKEND
CBSD_WORKDIR != sysrc -s cbsd -n cbsd_workdir 2>/dev/null || true

.include <${REGGAE_PATH}/mk/use.mk>

post_setup:
.for service url in ${ALL_SERVICES}
	@echo "FQDN = ${FQDN}" >>services/${service}/project.mk
	@echo "DHCP ?= ${DHCP}" >>services/${service}/project.mk
.if defined(VERSION)
	@echo "VERSION = ${FQDN}" >>services/${service}/project.mk
.endif
.endfor
.if ${BACKEND} == base
	@echo "\$${base}/letsencrypt/usr/local/etc/dehydrated/certs \$${path}/etc/certs nullfs rw 0 0" >services/ldap/templates/fstab
.elif ${BACKEND} == cbsd
	@echo "${CBSD_WORKDIR}/jails-data/letsencrypt-data/usr/local/etc/dehydrated/certs /etc/certs nullfs rw 0 0" >services/ldap/templates/fstab
.endif

.include <${REGGAE_PATH}/mk/project.mk>
