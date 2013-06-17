From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 3/3] mds: fix race between cap issue and revoke
Date: Mon, 17 Jun 2013 10:48:16 +0800
Message-ID: <1371437296-10561-2-git-send-email-zheng.z.yan@intel.com>
References: <1371437296-10561-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:12173 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755103Ab3FQCsU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 16 Jun 2013 22:48:20 -0400
In-Reply-To: <1371437296-10561-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

If we receive new caps from the auth MDS and the non-auth MDS is
revoking the newly issued caps, we should release the caps from
the non-auth MDS. The scenario is filelock's state changes from
SYNC to LOCK. Non-auth MDS needs to revoke Fc cap, we may receive
Fc cap from the auth MDS.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index a8c616b..9b8b1aa 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -813,22 +813,28 @@ int __ceph_caps_issued_mask(struct ceph_inode_info *ci, int mask, int touch)
 /*
  * Return true if mask caps are currently being revoked by an MDS.
  */
-int ceph_caps_revoking(struct ceph_inode_info *ci, int mask)
+int __ceph_caps_revoking_other(struct ceph_inode_info *ci,
+			       struct ceph_cap *ocap, int mask)
 {
-	struct inode *inode = &ci->vfs_inode;
 	struct ceph_cap *cap;
 	struct rb_node *p;
-	int ret = 0;
 
-	spin_lock(&ci->i_ceph_lock);
 	for (p = rb_first(&ci->i_caps); p; p = rb_next(p)) {
 		cap = rb_entry(p, struct ceph_cap, ci_node);
-		if (__cap_is_valid(cap) &&
-		    (cap->implemented & ~cap->issued & mask)) {
-			ret = 1;
-			break;
-		}
+		if (cap != ocap && __cap_is_valid(cap) &&
+		    (cap->implemented & ~cap->issued & mask))
+			return 1;
 	}
+	return 0;
+}
+
+int ceph_caps_revoking(struct ceph_inode_info *ci, int mask)
+{
+	struct inode *inode = &ci->vfs_inode;
+	int ret;
+
+	spin_lock(&ci->i_ceph_lock);
+	ret = __ceph_caps_revoking_other(ci, NULL, mask);
 	spin_unlock(&ci->i_ceph_lock);
 	dout("ceph_caps_revoking %p %s = %d\n", inode,
 	     ceph_cap_string(mask), ret);
@@ -2491,6 +2497,11 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
 	} else {
 		dout("grant: %s -> %s\n", ceph_cap_string(cap->issued),
 		     ceph_cap_string(newcaps));
+		/* non-auth MDS is revoking the newly grant caps ? */
+		if (cap == ci->i_auth_cap &&
+		    __ceph_caps_revoking_other(ci, cap, newcaps))
+		    check_caps = 2;
+
 		cap->issued = newcaps;
 		cap->implemented |= newcaps; /* add bits only, to
 					      * avoid stepping on a
-- 
1.8.1.4

