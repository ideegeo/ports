# Created by: Jonathan Anderson <jonathan@FreeBSD.org>
# $FreeBSD$

PORTNAME=		git-cola
DISTVERSIONPREFIX=	v
DISTVERSION=		3.3
CATEGORIES=		devel

MAINTAINER=		dch@FreeBSD.org
COMMENT=		Sleek and powerful Git GUI

LICENSE=		GPLv2+
LICENSE_FILE=		${WRKSRC}/COPYING

USES=			desktop-file-utils gmake python pyqt:5 qt:5 shebangfix

USE_GITHUB=		yes
USE_PYQT=		core gui network
USE_QT=			core gui network
SHEBANG_FILES=		share/git-cola/bin/git-xbase

NO_ARCH=		yes

MAKE_ARGS=		prefix=${PREFIX} PYTHON=${PYTHON_CMD} NO_VENDOR_LIBS=1

OPTIONS_DEFINE=		DOCS NLS
OPTIONS_DEFAULT=	DOCS NLS
OPTIONS_SUB=		yes

NLS_USES=		gettext

.include <bsd.port.mk>
