# $FreeBSD$

PORTNAME=	openbgpd
DISTVERSION=	6.6p0
PORTEPOCH=	1
CATEGORIES=	net
MASTER_SITES=	OPENBSD/OpenBGPD
DIST_SUBDIR=	${PORTNAME}

MAINTAINER=	hrs@FreeBSD.org
COMMENT=	Free implementation of the Border Gateway Protocol, Version 4

LICENSE=	ISCL
LICENSE_FILE=	${FILESDIR}/COPYING

CONFLICTS=	zebra-[0-9]* quagga-[0-9]*

USES=		autoreconf libtool uidfix
GNU_CONFIGURE=	yes
USE_RC_SUBR=	${PORTNAME}

SUB_FILES=	pkg-message
USERS=		_bgpd
GROUPS=		_bgpd

OPTIONS_DEFINE=	IPV6LLPEER
OPTIONS_DEFAULT=IPV6LLPEER
IPV6LLPEER_DESC=Support nexthop using IPv6 link-local address
IPV6LLPEER_MAKE_ARGS=	-DIPV6_LINKLOCAL_PEER

post-patch:
	@${REINPLACE_CMD} -e "s|%%PREFIX%%|${PREFIX}|g"	\
		${WRKSRC}/src/bgpd/bgpd.8			\
		${WRKSRC}/src/bgpd/bgpd.conf.5		\
		${WRKSRC}/src/bgpctl/bgpctl.8

post-install:
	@${MV} ${STAGEDIR}/${PREFIX}/etc/bgpd.conf \
			${STAGEDIR}/${PREFIX}/etc/bgpd.conf.sample

.include <bsd.port.mk>
