From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 29/29] mds: optimize C_MDC_RetryOpenRemoteIno
Date: Fri,  4 Jan 2013 17:02:20 +0800
Message-ID: <1357290140-17044-30-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53494 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754098Ab3ADJC5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:57 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

When opening remote inode, C_MDC_RetryOpenRemoteIno is used as onfinish
context for discovering remote inode. When it is called, the MDS may
already have the inode.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 236a0b9..9557436 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -7049,7 +7049,11 @@ public:
   C_MDC_RetryOpenRemoteIno(MDCache *mdc, inodeno_t i, Context *c, bool wx) :
     mdcache(mdc), ino(i), want_xlocked(wx), onfinish(c) {}
   void finish(int r) {
-    mdcache->open_remote_ino(ino, onfinish, want_xlocked);
+    if (mdcache->get_inode(ino)) {
+      onfinish->finish(0);
+      delete onfinish;
+    } else
+      mdcache->open_remote_ino(ino, onfinish, want_xlocked);
   }
 };
 
-- 
1.7.11.7

