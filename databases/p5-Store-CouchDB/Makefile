# $FreeBSD$

PORTNAME=	Store-CouchDB
PORTVERSION=	4.2
CATEGORIES=	databases perl5
MASTER_SITES=	CPAN
MASTER_SITE_SUBDIR=	CPAN:NORBU
PKGNAMEPREFIX=	p5-

MAINTAINER=	dch@skunkwerks.at
COMMENT=	Perl interface to Apache CouchDB

LICENSE=	ART10

BUILD_DEPENDS=	p5-Moo>=0:devel/p5-Moo \
		p5-MooX-Types-MooseLike>=0:devel/p5-MooX-Types-MooseLike \
		p5-Data-Dump>=0:devel/p5-Data-Dump \
		p5-JSON-XS>=0:converters/p5-JSON-XS \
		curl>=0:ftp/curl \
		p5-libwww>=0:www/p5-libwww \
		p5-URI>=0:www/p5-URI \
		p5-URI-Escape-XS>=0:www/p5-URI-Escape-XS
RUN_DEPENDS:=	${BUILD_DEPENDS}

NO_ARCH=	yes
USES=		perl5
USE_PERL5=	configure

.include <bsd.port.mk>
