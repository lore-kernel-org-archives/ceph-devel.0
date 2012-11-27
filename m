From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH] fix syncfs handling in error case
Date: Tue, 27 Nov 2012 16:54:40 +0100
Message-ID: <1354031680-17610-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:57184 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754030Ab2K0Pyn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 27 Nov 2012 10:54:43 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

If the call to syncfs() fails, don't try to call syncfs again via
syscall(). If HAVE_SYS_SYNCFS is defined, don't fall through to try
syscall() with SYS_syncfs or __NR_syncfs.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/common/sync_filesystem.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/src/common/sync_filesystem.h b/src/common/sync_filesystem.h
index 5b23576..eff18d2 100644
--- a/src/common/sync_filesystem.h
+++ b/src/common/sync_filesystem.h
@@ -34,14 +34,10 @@ inline int sync_filesystem(int fd)
 #ifdef HAVE_SYS_SYNCFS
   if (syncfs(fd) == 0)
     return 0;
-#endif
-
-#ifdef SYS_syncfs
+#elif defined(SYS_syncfs)
   if (syscall(SYS_syncfs, fd) == 0)
     return 0;
-#endif
-
-#ifdef __NR_syncfs
+#elif defined(__NR_syncfs)
   if (syscall(__NR_syncfs, fd) == 0)
     return 0;
 #endif
-- 
1.8.0

