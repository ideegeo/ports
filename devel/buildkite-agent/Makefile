# $FreeBSD$

PORTNAME=	buildkite-agent
PORTVERSION=	3.0b33
CATEGORIES=	devel sysutils

MAINTAINER=	dch@skunkwerks.at
COMMENT=	Cross-platform build runner to run your own build tasks

LICENSE=	MIT BSD3CLAUSE APACHE20 LGPL3 BSD2CLAUSE
LICENSE_FILE=	${WRKSRC}/LICENSE.txt
LICENSE_COMB=	multi

BUILD_DEPENDS=	go>=1.8:lang/go
RUN_DEPENDS=	${LOCALBASE}/bin/bash:shells/bash

USE_GITHUB=	yes
GH_ACCOUNT=	buildkite
GH_PROJECT=	agent
GH_TAGNAME=	v3.0-beta.33

USES=		go
GO_PKGNAME=	github.com/${GH_ACCOUNT}/${GH_PROJECT}

USE_RC_SUBR=	buildkite

ETCDIR=		${PREFIX}/etc/buildkite

SUB_FILES=	pkg-message

post-patch:
	@${REINPLACE_CMD} -I '' -e 's|/bin/bash|/usr/local/bin/bash|g' \
			`${FIND} ${WRKSRC}/packaging/linux -type f`
	@${REINPLACE_CMD} -I '' -e 's|/bin/bash|/usr/local/bin/bash|g' \
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
