From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 04/12] ceph: fix cache revoke race
Date: Fri,  6 Dec 2013 16:46:35 +0800
Message-ID: <1386319603-2610-5-git-send-email-zheng.z.yan@intel.com>
References: <1386319603-2610-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23353 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757177Ab3LFIqv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 Dec 2013 03:46:51 -0500
In-Reply-To: <1386319603-2610-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

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
index a3033fa..a32103f 100644
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
index 2ae1381..dac5cae 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1484,7 +1484,8 @@ static void ceph_invalidate_work(struct work_struct *work)
 	dout("invalidate_pages %p gen %d revoking %d\n", inode,
 	     ci->i_rdcache_gen, ci->i_rdcache_revoking);
 	if (ci->i_rdcache_revoking != ci->i_rdcache_gen) {
-		/* nevermind! */
+		if (__ceph_caps_revoking_other(ci, NULL, CEPH_CAP_FILE_CACHE))
+			check = 1;
 		spin_unlock(&ci->i_ceph_lock);
 		mutex_unlock(&ci->i_truncate_mutex);
 		goto out;
@@ -1505,13 +1506,14 @@ static void ceph_invalidate_work(struct work_struct *work)
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
index 8de94b5..ae074df 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -529,6 +529,8 @@ static inline int __ceph_caps_dirty(struct ceph_inode_info *ci)
 }
 extern int __ceph_mark_dirty_caps(struct ceph_inode_info *ci, int mask);
 
+extern int __ceph_caps_revoking_other(struct ceph_inode_info *ci,
+				      struct ceph_cap *ocap, int mask);
 extern int ceph_caps_revoking(struct ceph_inode_info *ci, int mask);
 extern int __ceph_caps_used(struct ceph_inode_info *ci);
 
-- 
1.8.1.4

