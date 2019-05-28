# $FreeBSD$

PORTNAME=		zig
DISTVERSION=		0.4.0
CATEGORIES=		lang
PKGNAMESUFFIX=		-devel

MAINTAINER=		dch@FreeBSD.org
COMMENT=		Robust, Optimal, Maintainable language, optional libc

LICENSE=		MIT
LICENSE_FILE=		${WRKSRC}/LICENSE

ONLY_FOR_ARCHS=		amd64 armv7 i386 armv6
ONLY_FOR_ARCHS_REASON=	Requires llvm8+ and fails on most Zig tier 3 platforms

BUILD_DEPENDS=		llvm80>=0:devel/llvm80

USES=			cmake

USE_GITHUB=		yes
GH_ACCOUNT=		ziglang

CMAKE_ARGS=		-DZIG_STATIC=ON \
			-DCMAKE_SKIP_INSTALL_RPATH=ON

.include <bsd.port.mk>
