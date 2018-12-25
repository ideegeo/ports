# $FreeBSD$

PORTNAME=	riemann-dash
DISTVERSION=	0.2.14
CATEGORIES=	net-mgmt rubygems
MASTER_SITES=	RG

MAINTAINER=	dch@FreeBSD.org
COMMENT=	Configurable websocket/javascript based dashboard for net-mgmt/riemann

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE

RUN_DEPENDS=	rubygem-multi_json>=0:devel/rubygem-multi_json \
		rubygem-sass>=0:textproc/rubygem-sass \
		rubygem-erubis>=0:www/rubygem-erubis \
		rubygem-sinatra>=0:www/rubygem-sinatra

USES=		gem

NO_ARCH=	yes
USE_RUBY=	yes

post-install:
	${MKDIR} ${STAGEDIR}${DATADIR}
	# make a softlink so that webservers can reference the html files
	# even when DISTVERSION etc changes
	${RLN} ${STAGEDIR}${PREFIX}/${GEM_LIB_DIR}/lib/riemann/dash/public \
		${STAGEDIR}${DATADIR}/public
	# the eruby template is valid HTML so drop it into public dir
	# and it can all be served directly via your webserver
	${CP}	${WRKSRC}/lib/riemann/dash/views/index.erubis \
		${STAGEDIR}${DATADIR}/public/index.html

.include <bsd.port.mk>
