# $FreeBSD$

PORTNAME=	buildkite-agent
DISTVERSIONPREFIX=	v
DISTVERSION=	3.2.0
CATEGORIES=	devel sysutils

MAINTAINER=	dch@FreeBSD.org
COMMENT=	Cross-platform build runner to run your own build tasks

LICENSE=	MIT BSD3CLAUSE APACHE20 LGPL3 BSD2CLAUSE
LICENSE_COMB=	multi
LICENSE_FILE=	${WRKSRC}/LICENSE.txt

BUILD_DEPENDS=	go>=1.9:lang/go
RUN_DEPENDS=	bash:shells/bash

USES=		go
GO_PKGNAME=	github.com/${GH_ACCOUNT}/${GH_PROJECT}

USE_GITHUB=	yes
GH_ACCOUNT=	buildkite
GH_PROJECT=	agent

USE_RC_SUBR=	buildkite

ETCDIR=		${PREFIX}/etc/buildkite

SUB_FILES=	pkg-message

post-patch:
	@${REINPLACE_CMD} -I '' -e 's|/bin/bash|${LOCALBASE}/bin/bash|g' \
			`${FIND} ${WRKSRC}/packaging/linux -type f`
	@${REINPLACE_CMD} -I '' -e 's|/bin/bash|${LOCALBASE}/bin/bash|g' \
			`${FIND} ${WRKSRC}/bootstrap -type f -name *.go`

do-install:
	${INSTALL_PROGRAM} \
		${WRKDIR}/bin/agent ${STAGEDIR}${PREFIX}/bin/${PORTNAME}
	${MKDIR} ${STAGEDIR}${ETCDIR}/hooks ${STAGEDIR}${ETCDIR}/plugins
	${INSTALL_DATA} \
		${WRKSRC}/packaging/github/linux/${PORTNAME}.cfg \
		${STAGEDIR}${ETCDIR}/${PORTNAME}.cfg.sample

post-install:
	${MKDIR} ${STAGEDIR}${EXAMPLESDIR}
	(cd ${WRKSRC}/packaging/linux/root/usr/share/buildkite-agent && ${COPYTREE_SHARE} hooks ${STAGEDIR}${EXAMPLESDIR})

.include <bsd.port.mk>
