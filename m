From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH] fix syncfs handling in error case
Date: Tue, 27 Nov 2012 16:23:19 +0100
Message-ID: <1354029799-14465-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:55515 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755875Ab2K0PXY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 27 Nov 2012 10:23:24 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

If the call to syncfs() fails, don't try to call syncfs again via
syscall(). If HAVE_SYS_SYNCFS is defined, don't use syscall() with
SYS_syncfs.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/common/sync_filesystem.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/common/sync_filesystem.h b/src/common/sync_filesystem.h
index dc90b89..976400f 100644
--- a/src/common/sync_filesystem.h
+++ b/src/common/sync_filesystem.h
@@ -34,9 +34,7 @@ inline int sync_filesystem(int fd)
 #ifdef HAVE_SYS_SYNCFS
   if (syncfs(fd) == 0)
     return 0;
-#endif
-
-#ifdef SYS_syncfs
+#elif defined(SYS_syncfs)
   if (syscall(SYS_syncfs, fd) == 0)
     return 0;
 #endif
-- 
1.8.0

