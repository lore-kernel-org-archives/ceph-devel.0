From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH] configure.ac: Fix up --with-profiler test
Date: Wed,  2 Mar 2011 12:52:01 -0700
Message-ID: <1299095521-20220-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:49168 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756281Ab1CBTwT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2011 14:52:19 -0500
Received: from sentry.sandia.gov (mm03snlnto.sandia.gov [132.175.109.20])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 1469E52DE62
	for <ceph-devel@vger.kernel.org>; Wed,  2 Mar 2011 12:52:14 -0700 (MST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>

According to http://www.gnu.org/software/autoconf/manual/autoconf.html,
the <action-if-given> test for AC_ARG_WITH is done if either of
--with-package or --without-package is on the configure line.
The <action-if-not-given> is done if neither is present on
the command line.

This commit causes both --without-profiler and --with-profiler=no
to work correctly.  It also allows a default configure/build
(i.e. --with-profiler not specified) to work correctly on a system
that does not have the appropriate profiling library.

Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 configure.ac |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index c76f605..9357a47 100644
--- a/configure.ac
+++ b/configure.ac
@@ -37,9 +37,9 @@ PKG_CHECK_MODULES([CRYPTOPP], [libcrypto++], [], [
 # profiler?
 AC_ARG_WITH([profiler],
             [AS_HELP_STRING([--with-profiler], [build extra profiler binaries])],
-	    [with_profiler=yes],
+	    [],
             [with_profiler=no])
-AS_IF([test "x$with_profiler" != xyes],
+AS_IF([test "x$with_profiler" != xno],
 	    [AC_CHECK_LIB([profiler], [ProfilerFlush], [],
 	        	  [AC_MSG_FAILURE([--with-profiler was given but libprofiler (libgoogle-perftools-dev on debian) not found])])],
 	    [])
-- 
1.6.6


