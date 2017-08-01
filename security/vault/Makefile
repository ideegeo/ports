# $FreeBSD$

PORTNAME=	vault
PORTVERSION=	0.8.0
DISTVERSIONPREFIX=	v
DISTVERSIONSUFFIX=	-beta1
CATEGORIES=	security

MAINTAINER=	swills@FreeBSD.org
COMMENT=	Tool for securely accessing secrets

LICENSE=	MPL

BUILD_DEPENDS=	go>=1.7.1:lang/go

USE_GITHUB=	yes
GH_ACCOUNT=	hashicorp
GH_SUBDIR=	src/github.com/${GH_ACCOUNT}/${PORTNAME}

USE_RC_SUBR=	vault

USERS=		vault
GROUPS=		vault

PLIST_FILES=	bin/${PORTNAME}

post-patch:
	@${REINPLACE_CMD} -e 's|%%PORTVERSION%%|${PORTVERSION}|g' ${WRKSRC}/version/version.go
	@${REINPLACE_CMD} -e 's|%%COMMIT_ID%%|${COMMIT_ID}|g' ${WRKSRC}/version/version.go

do-build:
	@cd ${WRKSRC}; \
		${SETENV} ${BUILD_ENV} CGO_ENABLED=0 GOPATH=${WRKSRC} \
		go build \
		-ldflags "\
		-X github.com/hashicorp/vault/version.Version=${PORTVERSION} \
		-X github.com/hashicorp/vault/version.VersionPrerelease= \
		-X github.com/hashicorp/vault/version.VersionMetadata= \
		-X github.com/hashicorp/vault/version.GitCommit='${COMMIT_ID}'" \
		-o bin/${PORTNAME}

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/bin/${PORTNAME} ${STAGEDIR}${PREFIX}/bin/${PORTNAME}

.include <bsd.port.mk>
