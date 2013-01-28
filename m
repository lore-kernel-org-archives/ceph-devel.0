From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 1/3] configure: fix check for fuse_getgroups()
Date: Mon, 28 Jan 2013 16:33:42 +0100
Message-ID: <1359387224-6769-2-git-send-email-danny.al-gaaf@bisect.de>
References: <1359387224-6769-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:38902 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753166Ab3A1Pdt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Mon, 28 Jan 2013 10:33:49 -0500
In-Reply-To: <1359387224-6769-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>, Dan Mick <dan.mick@inktank.com>

Check for fuse_getgroups() only in case we have found libfuse already.
Moved the check to the check for --with-fuse.

Small fix: fix string for NO_ATOMIC_OPS, don't use "'".

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 configure.ac | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index ffbd150..d6cff80 100644
--- a/configure.ac
+++ b/configure.ac
@@ -241,6 +241,8 @@ AS_IF([test "x$with_fuse" != xno],
                AC_DEFINE([HAVE_LIBFUSE], [1],
                          [Define if you have fuse])
                HAVE_LIBFUSE=1
+	       # look for fuse_getgroups and define FUSE_GETGROUPS if found
+	       AC_CHECK_FUNCS([fuse_getgroups])	       
               ],
              [AC_MSG_FAILURE(
                    [no FUSE found (use --without-fuse to disable)])])])
@@ -391,7 +393,8 @@ AS_IF([test "x$with_libatomic_ops" != xno],
               ])])
 AS_IF([test "$HAVE_ATOMIC_OPS" = "1"],
 	[],
-	AC_DEFINE([NO_ATOMIC_OPS], [1], [Defined if you don't have atomic_ops]))
+	[AC_DEFINE([NO_ATOMIC_OPS], [1], [Defined if you do not have atomic_ops])])
+
 AM_CONDITIONAL(WITH_LIBATOMIC, [test "$HAVE_ATOMIC_OPS" = "1"])
 
 # newsyn?  requires mpi.
@@ -417,9 +420,6 @@ AS_IF([test "x$with_system_leveldb" = xcheck],
 	    [AC_CHECK_LIB([leveldb], [leveldb_open], [with_system_leveldb=yes], [], [-lsnappy -lpthread])])
 AM_CONDITIONAL(WITH_SYSTEM_LEVELDB, [ test "$with_system_leveldb" = "yes" ])
 
-# look for fuse_getgroups and define FUSE_GETGROUPS if found
-AC_CHECK_FUNCS([fuse_getgroups])
-
 # use system libs3?
 AC_ARG_WITH([system-libs3],
 	[AS_HELP_STRING([--with-system-libs3], [use system libs3])],
-- 
1.8.1.1

