From: Chen Baozi <baozich@gmail.com>
Subject: [PATCH] rgw: add -lresolv flags to Makefile.am
Date: Sun, 18 Nov 2012 14:34:21 +0800
Message-ID: <1353220461-6436-1-git-send-email-baozich@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42806 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419Ab2KRGgC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Nov 2012 01:36:02 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so2788078pbc.19
        for <ceph-devel@vger.kernel.org>; Sat, 17 Nov 2012 22:36:02 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Chen Baozi <baozich@gmail.com>

radosgw depends on libresolv since since the commit 951c6be. So we need to
add -lresolve flags, or it cannot link right library.

Signed-off-by: Chen Baozi <baozich@gmail.com>
---
 configure.ac    | 1 +
 src/Makefile.am | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index aa10143..d978565 100644
--- a/configure.ac
+++ b/configure.ac
@@ -80,6 +80,7 @@ AC_CHECK_CC_FLAG([-Wignored-qualifiers], [WARN_IGNORED_QUALIFIERS])
 ACX_PTHREAD
 AC_CHECK_LIB([uuid], [uuid_parse], [true], AC_MSG_FAILURE([libuuid not found]))
 AC_CHECK_LIB([m], [pow], [true], AC_MSG_FAILURE([libm not found]))
+AC_CHECK_LIB([resolv], [__res_nquery], [true], AC_MSG_FAILURE([libresolv not found]))
 if test x"$linux" = x"yes"; then
 	AC_CHECK_LIB([keyutils], [add_key], [true], AC_MSG_FAILURE([libkeyutils not found]))
 fi
diff --git a/src/Makefile.am b/src/Makefile.am
index 8b5e63d..16a7ed3 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -366,7 +366,7 @@ radosgw_SOURCES = \
         rgw/rgw_swift.cc \
 	rgw/rgw_swift_auth.cc \
 	rgw/rgw_main.cc
-radosgw_LDADD = $(my_radosgw_ldadd) -lfcgi
+radosgw_LDADD = $(my_radosgw_ldadd) -lfcgi -lresolv
 radosgw_CXXFLAGS = ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS}
 bin_PROGRAMS += radosgw
 
-- 
1.7.11.7

