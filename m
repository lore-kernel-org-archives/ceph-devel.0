From: Christian Brunner <chb@muc.de>
Subject: [PATCH] fix FCGI detection and specfile
Date: Fri, 9 Jul 2010 22:43:42 +0200
Message-ID: <20100709204342.GA31275@sir.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36118 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661Ab0GIUoM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jul 2010 16:44:12 -0400
Received: by fxm14 with SMTP id 14so1360588fxm.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Jul 2010 13:44:11 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

configure is building radosgw as soon as libfcgi is installed, even
if --without-radosgw is given. Here is a fix for configure.in and the
specfile.

Regards,
Christian
---
 ceph.spec.in |    2 +-
 configure.ac |   18 ++++++++----------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/ceph.spec.in b/ceph.spec.in
index caf33d2..ca0c698 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -59,7 +59,7 @@ conjunction with any FastCGI capable web server.
 %if %{with_radosgw}
 %{configure} --without-hadoop --with-radosgw
 %else
-%{configure} --without-hadoop 
+%{configure} --without-hadoop --without-radosgw
 %endif
 make -j$(getconf _NPROCESSORS_ONLN) CFLAGS="$RPM_OPT_FLAGS" CXXFLAGS="$RPM_OPT_FLAGS"
 
diff --git a/configure.ac b/configure.ac
index 2b30fba..53a1d27 100644
--- a/configure.ac
+++ b/configure.ac
@@ -45,19 +45,17 @@ AC_ARG_WITH([radosgw],
             [AS_HELP_STRING([--with-radosgw], [build RADOS gateway])],
             [],
             [with_radosgw=check])
-RADOSGW=1
+RADOSGW=0
 AS_IF([test "x$with_radosgw" != xno],
 	    [AC_CHECK_LIB([fcgi], [FCGX_Init],
-             [true],
-	     [RADOSGW=0
-	     if test "x$with_radosgw" != "xcheck"; then
+             [AC_CHECK_LIB([expat], [XML_Parse],
+              [RADOSGW=1],
+	      [if test "x$with_radosgw" != "xcheck"; then
+		   AC_MSG_FAILURE([--with-radosgw was given but libexpat (libexpat1-dev on debian) not found])
+	      fi])
+             ],
+	     [if test "x$with_radosgw" != "xcheck"; then
 		AC_MSG_FAILURE([--with-radosgw was given but libfcgi (libfcgi-dev on debian) not found])
-	     fi])
-	     AC_CHECK_LIB([expat], [XML_Parse],
-             [true],
-	     [RADOSGW=0
-	     if test "x$with_radosgw" != "xcheck"; then
-		AC_MSG_FAILURE([--with-radosgw was given but libexpat (libexpat1-dev on debian) not found])
 	     fi])])
 AM_CONDITIONAL(WITH_RADOSGW, test "$RADOSGW" = "1")
 
-- 
1.5.5.6

