From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 12/16] mds: fix open_remote_inode race
Date: Mon, 19 Nov 2012 10:43:44 +0800
Message-ID: <1353293028-15238-13-git-send-email-zheng.z.yan@intel.com>
References: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57821 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752965Ab2KSCoE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 18 Nov 2012 21:44:04 -0500
In-Reply-To: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

discover_ino() may return -ENOENT if it races with other FS activities.
so use C_MDC_RetryOpenRemoteIno instead of C_MDC_OpenRemoteIno as
onfinish callback.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 690c2ed..48ccc7e 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -7122,7 +7122,8 @@ void MDCache::open_remote_ino_2(inodeno_t ino,
   if (!dir && in->is_auth()) {
     if (in->is_frozen_dir()) {
       dout(7) << "traverse: " << *in << " is frozen_dir, waiting" << dendl;
-      in->parent->dir->add_waiter(CDir::WAIT_UNFREEZE, onfinish);
+      in->parent->dir->add_waiter(CDir::WAIT_UNFREEZE,
+				  new C_MDC_RetryOpenRemoteIno(this, ino, onfinish));
       return;
     }
     dir = in->get_or_open_dirfrag(this, frag);
@@ -7157,7 +7158,7 @@ void MDCache::open_remote_ino_2(inodeno_t ino,
     dout(10) << "have remote dirfrag " << *dir << ", discovering " 
 	     << anchortrace[i].ino << dendl;
     discover_ino(dir, anchortrace[i].ino, 
-		 new C_MDC_OpenRemoteIno(this, ino, anchortrace, onfinish));
+		 new C_MDC_RetryOpenRemoteIno(this, ino, onfinish));
   }
 }
 
-- 
1.7.11.7

