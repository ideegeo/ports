# $FreeBSD$

PORTNAME=	buildkite-agent
PORTVERSION=	3.0b23
CATEGORIES=	devel sysutils

MAINTAINER=	dch@skunkwerks.at
COMMENT=	Cross-platform build runner to run your own build tasks

LICENSE=	MIT

BUILD_DEPENDS=	go>=1.8:lang/go

USE_GITHUB=	yes
GH_ACCOUNT=	buildkite
GH_PROJECT=	agent
GH_TAGNAME=	v3.0-beta.23

USES=		go
GO_PKGNAME=	github.com/${GH_ACCOUNT}/${GH_PROJECT}

USE_RC_SUBR=	${PORTNAME}

USERS=		${PORTNAME}
GROUPS=		${PORTNAME}

do-install:
		${INSTALL_PROGRAM} \
			${WRKDIR}/bin/agent ${STAGEDIR}${PREFIX}/bin/${PORTNAME}
		${MKDIR} ${STAGEDIR}${ETCDIR}
#			${STAGEDIR}${BUILDKITE_LOGDIR}
		${INSTALL_DATA} \
			${WRKSRC}/packaging/github/linux/${PORTNAME}.cfg \
			${STAGEDIR}${ETCDIR}/${PORTNAME}.cfg.sample

.include <bsd.port.mk>
