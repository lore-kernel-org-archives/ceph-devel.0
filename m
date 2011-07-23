From: Sage Weil <sage@newdream.net>
Subject: [PATCH 04/23] ceph: fix snap writeback when racing with writes
Date: Fri, 22 Jul 2011 17:02:43 -0700
Message-ID: <1311379382-9218-5-git-send-email-sage@newdream.net>
References: <1311379382-9218-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44309 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753993Ab1GWAFx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jul 2011 20:05:53 -0400
In-Reply-To: <1311379382-9218-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

There are two problems that come up when we try to queue a capsnap while a
write is in progress:

 - The FILE_WR cap is held, but not yet dirty, so we may queue a capsnap
   with dirty == 0.  That will crash later in __ceph_flush_snaps().  Or
   on the FILE_WR cap if a write is in progress.
 - We may not have i_head_snapc set, which causes problems pretty quickly.
   Look to the snaprealm in this case.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/ceph/snap.c |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 54b14de..ac030c9 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -449,6 +449,15 @@ void ceph_queue_cap_snap(struct ceph_inode_info *ci)
 	spin_lock(&inode->i_lock);
 	used = __ceph_caps_used(ci);
 	dirty = __ceph_caps_dirty(ci);
+
+	/*
+	 * If there is a write in progress, treat that as a dirty Fw,
+	 * even though it hasn't completed yet; by the time we finish
+	 * up this capsnap it will be.
+	 */
+	if (used & CEPH_CAP_FILE_WR)
+		dirty |= CEPH_CAP_FILE_WR;
+
 	if (__ceph_have_pending_cap_snap(ci)) {
 		/* there is no point in queuing multiple "pending" cap_snaps,
 		   as no new writes are allowed to start when pending, so any
@@ -456,14 +465,22 @@ void ceph_queue_cap_snap(struct ceph_inode_info *ci)
 		   cap_snap.  lucky us. */
 		dout("queue_cap_snap %p already pending\n", inode);
 		kfree(capsnap);
-	} else if (ci->i_wrbuffer_ref_head || (used & CEPH_CAP_FILE_WR) ||
+	} else if (ci->i_wrbuffer_ref_head ||
 		   (dirty & (CEPH_CAP_AUTH_EXCL|CEPH_CAP_XATTR_EXCL|
 			     CEPH_CAP_FILE_EXCL|CEPH_CAP_FILE_WR))) {
 		struct ceph_snap_context *snapc = ci->i_head_snapc;
 
-		dout("queue_cap_snap %p cap_snap %p queuing under %p\n", inode,
-		     capsnap, snapc);
+		/*
+		 * if we are a sync write, we may need to go to the snaprealm
+		 * to get the current snapc.
+		 */
+		if (!snapc)
+			snapc = ci->i_snap_realm->cached_context;
+
+		dout("queue_cap_snap %p cap_snap %p queuing under %p %s\n",
+		     inode, capsnap, snapc, ceph_cap_string(dirty));
 		ihold(inode);
+		BUG_ON(dirty == 0);
 
 		atomic_set(&capsnap->nref, 1);
 		capsnap->ci = ci;
-- 
1.7.0

