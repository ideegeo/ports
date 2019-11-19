--- make-bsd.mk.orig	2019-11-19 21:05:20 UTC
+++ make-bsd.mk
@@ -13,7 +13,7 @@ ifeq ($(ZT_SANITIZE),1)
 endif
 # "make debug" is a shortcut for this
 ifeq ($(ZT_DEBUG),1)
-	CFLAGS+=-Wall -Werror -g -pthread $(INCLUDES) $(DEFS)
+	CFLAGS+=-Wall -g -pthread $(INCLUDES) $(DEFS)
 	LDFLAGS+=
 	STRIP=echo
 	ZT_TRACE=1
