From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 1/8] WorkQueue.h: fix cast
Date: Wed,  6 Feb 2013 12:02:44 +0100
Message-ID: <1360148571-6984-2-git-send-email-danny.al-gaaf@bisect.de>
References: <1360148571-6984-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:32951 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757259Ab3BFLC4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 06:02:56 -0500
In-Reply-To: <1360148571-6984-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>, Gary Lowell <gary.lowell@inktank.com>

Replace C-style pointer casting with correct static_cast<>().

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/common/WorkQueue.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/common/WorkQueue.h b/src/common/WorkQueue.h
index 9fb215b..b19a6a2 100644
--- a/src/common/WorkQueue.h
+++ b/src/common/WorkQueue.h
@@ -251,10 +251,10 @@ public:
       return (void *)_dequeue();
     }
     void _void_process(void *p, TPHandle &handle) {
-      _process((T *)p, handle);
+      _process(static_cast<T *>(p), handle);
     }
     void _void_process_finish(void *p) {
-      _process_finish((T *)p);
+      _process_finish(static_cast<T *>(p));
     }
 
   public:
-- 
1.8.1.2

