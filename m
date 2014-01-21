From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 03/11] ceph: fix cache revoke race
Date: Tue, 21 Jan 2014 12:15:37 +0800
Message-ID: <1390277745-20142-3-git-send-email-zheng.z.yan@intel.com>
References: <1390277745-20142-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21685 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752548AbaAUEPx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 20 Jan 2014 23:15:53 -0500
In-Reply-To: <1390277745-20142-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

handle following sequence of events:

- non-auth MDS revokes Fc cap. queue invalidate work
- auth MDS issues Fc cap through request reply. i_rdcache_gen gets
  increased.
- invalidate work runs. it finds i_rdcache_revoking != i_rdcache_gen,
  so it does nothing.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c  | 2 +-
 fs/ceph/inode.c | 8 +++++---
 fs/ceph/super.h | 2 ++
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 2c39d9f..d2154d6 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -816,7 +816,7 @@ int __ceph_caps_revoking_other(struct ceph_inode_info *ci,
 
 	for (p = rb_first(&ci->i_caps); p; p = rb_next(p)) {
 		cap = rb_entry(p, struct ceph_cap, ci_node);
-		if (cap != ocap && __cap_is_valid(cap) &&
+		if (cap != ocap &&
 		    (cap->implemented & ~cap->issued & mask))
 			return 1;
 	}
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index a808bfb..3db97ba 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1466,7 +1466,8 @@ static void ceph_invalidate_work(struct work_struct *work)
 	dout("invalidate_pages %p gen %d revoking %d\n", inode,
 	     ci->i_rdcache_gen, ci->i_rdcache_revoking);
 	if (ci->i_rdcache_revoking != ci->i_rdcache_gen) {
-		/* nevermind! */
+		if (__ceph_caps_revoking_other(ci, NULL, CEPH_CAP_FILE_CACHE))
+			check = 1;
 		spin_unlock(&ci->i_ceph_lock);
 		mutex_unlock(&ci->i_truncate_mutex);
 		goto out;
@@ -1487,13 +1488,14 @@ static void ceph_invalidate_work(struct work_struct *work)
 		dout("invalidate_pages %p gen %d raced, now %d revoking %d\n",
 		     inode, orig_gen, ci->i_rdcache_gen,
 		     ci->i_rdcache_revoking);
+		if (__ceph_caps_revoking_other(ci, NULL, CEPH_CAP_FILE_CACHE))
+			check = 1;
 	}
 	spin_unlock(&ci->i_ceph_lock);
 	mutex_unlock(&ci->i_truncate_mutex);
-
+out:
 	if (check)
 		ceph_check_caps(ci, 0, NULL);
-out:
 	iput(inode);
 }
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 7fa78a7..891cda8 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -528,6 +528,8 @@ static inline int __ceph_caps_dirty(struct ceph_inode_info *ci)
 }
 extern int __ceph_mark_dirty_caps(struct ceph_inode_info *ci, int mask);
 
+extern int __ceph_caps_revoking_other(struct ceph_inode_info *ci,
+				      struct ceph_cap *ocap, int mask);
 extern int ceph_caps_revoking(struct ceph_inode_info *ci, int mask);
 extern int __ceph_caps_used(struct ceph_inode_info *ci);
 
-- 
1.8.4.2

