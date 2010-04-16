From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH] autoconf: Fix detection of sync_file_range.
Date: Fri, 16 Apr 2010 16:25:49 -0600
Message-ID: <1271456749-12510-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:43447 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932624Ab0DPWZ6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Apr 2010 18:25:58 -0400
Received: from sentry.sandia.gov (mm04snlnto.sandia.gov [132.175.109.21])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 137344FB7F7
	for <ceph-devel@vger.kernel.org>; Fri, 16 Apr 2010 16:25:51 -0600 (MDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>

Without this patch, on CentOS 5.4 ./configure reports that
sync_file_range is missing, but HAVE_SYNC_FILE_RANGE ends
up being defined in src/acconfig.h anyway.

Compile tested on CentOS 5.4 (which does not have sync_file_range(2)
in distro glibc) and Fedora 11 (which does).

Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 configure.ac |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 665fcdd..4abcbe1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -148,9 +148,8 @@ AC_CHECK_HEADER([openssl/md5.h],
 AC_CHECK_HEADERS([sys/xattr.h arpa/inet.h netdb.h netinet/in.h sys/file.h sys/ioctl.h sys/mount.h sys/param.h sys/socket.h sys/statvfs.h sys/time.h sys/vfs.h syslog.h utime.h])
 
 # sync_file_range
-AC_DEFINE([HAVE_SYNC_FILE_RANGE], [], [sync_file_range(2) is supported])
 AC_CHECK_FUNC([sync_file_range],
-	[AC_DEFINE([HAVE_SYNC_FILE_RANGE])],
+	[AC_DEFINE([HAVE_SYNC_FILE_RANGE], [], [sync_file_range(2) is supported])],
 	[])
 
 # Checks for typedefs, structures, and compiler characteristics.
-- 
1.6.6.1


