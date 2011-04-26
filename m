From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH] configure.ac: Add a macro to check for supported
 compiler flags.
Date: Tue, 26 Apr 2011 15:06:14 -0600
Message-ID: <1303851974-29838-2-git-send-email-jaschut@sandia.gov>
References: <1303851974-29838-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:57586 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758181Ab1DZVHa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Apr 2011 17:07:30 -0400
Received: from interceptor1.sandia.gov (interceptor1.sandia.gov [132.175.109.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-three.sandia.gov (Postfix) with ESMTP id 1025D4E8AA5
	for <ceph-devel@vger.kernel.org>; Tue, 26 Apr 2011 15:07:17 -0600 (MDT)
Received: from sentry.sandia.gov (mm04snlnto.sandia.gov [132.175.109.21]) by interceptor1.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Tue, 26 Apr 2011 15:02:40 -0600
In-Reply-To: <1303851974-29838-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>

Ancient versions of gcc, such as the gcc 4.1.2 in RHEL 5.5, don't
support some -W flags that newer versions do.  Fix up configure.ac
and Makefile.am to use them if you have them.

Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 configure.ac    |   21 +++++++++++++++++++++
 src/Makefile.am |    2 +-
 2 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5642717..dc4d710 100644
--- a/configure.ac
+++ b/configure.ac
@@ -33,6 +33,27 @@ AC_PROG_CXX
 AC_PROG_MAKE_SET
 AC_PROG_LIBTOOL
 
+# Checks for compiler warning types
+
+# AC_CHECK_CC_FLAG(FLAG_TO_TEST, VARIABLE_TO_SET_IF_SUPPORTED)
+# ---------
+AC_DEFUN([AC_CHECK_CC_FLAG],
+[{
+	AC_LANG_PUSH([C])
+	my_cflags_save="$CFLAGS"
+	CFLAGS="$my_cflags_save $1"
+	AC_MSG_CHECKING([whether $CC accepts $1])
+	AC_COMPILE_IFELSE(AC_LANG_PROGRAM(),
+			  [AC_MSG_RESULT([yes]); AC_SUBST([$2], ["$1"])],
+			  [AC_MSG_RESULT([no])]
+			 )
+	CFLAGS="$my_cflags_save"
+	AC_LANG_POP([C])
+}])
+
+AC_CHECK_CC_FLAG([-Wtype-limits], [WARN_TYPE_LIMITS])
+AC_CHECK_CC_FLAG([-Wignored-qualifiers], [WARN_IGNORED_QUALIFIERS])
+
 # Checks for libraries.
 AC_CHECK_LIB([m], [pow], [true], AC_MSG_FAILURE([libm not found]))
 AC_CHECK_LIB([pthread], [pthread_create], [true], AC_MSG_FAILURE([libpthread not found]))
diff --git a/src/Makefile.am b/src/Makefile.am
index 3113111..071360e 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -479,7 +479,7 @@ CLEANFILES += \
 ##
 
 AM_COMMON_FLAGS = -Wall -D__CEPH__ -D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_THREAD_SAFE -rdynamic \
--Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith \
+${WARN_TYPE_LIMITS} ${WARN_IGNORED_QUALIFIERS} -Winit-self -Wpointer-arith \
 -fno-strict-aliasing
 
 AM_CFLAGS = $(AM_COMMON_FLAGS)
-- 
1.6.6


