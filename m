From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 4/6] ceph: handle cap import atomically
Date: Fri, 18 Apr 2014 22:48:40 +0800
Message-ID: <1397832522-9557-4-git-send-email-zheng.z.yan@intel.com>
References: <1397832522-9557-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:42749 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753878AbaDROtP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 18 Apr 2014 10:49:15 -0400
In-Reply-To: <1397832522-9557-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

cap import messages are processed by both handle_cap_import() and
handle_cap_grant(). These two functions are not executed in the same
atomic context, so they can races with cap release.

The fix is make handle_cap_import() not release the i_ceph_lock when
it returns. Let handle_cap_grant() release the lock after it finishes
its job.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 98 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 53 insertions(+), 45 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 73a42f5..318b50f 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2379,23 +2379,20 @@ static void invalidate_aliases(struct inode *inode)
  * actually be a revocation if it specifies a smaller cap set.)
  *
  * caller holds s_mutex and i_ceph_lock, we drop both.
- *
- * return value:
- *  0 - ok
- *  1 - check_caps on auth cap only (writeback)
- *  2 - check_caps (ack revoke)
  */
-static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
+static void handle_cap_grant(struct ceph_mds_client *mdsc,
+			     struct inode *inode, struct ceph_mds_caps *grant,
+			     void *snaptrace, int snaptrace_len,
+			     struct ceph_buffer *xattr_buf,
 			     struct ceph_mds_session *session,
-			     struct ceph_cap *cap,
-			     struct ceph_buffer *xattr_buf)
-		__releases(ci->i_ceph_lock)
+			     struct ceph_cap *cap, int issued)
+	__releases(ci->i_ceph_lock)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int mds = session->s_mds;
 	int seq = le32_to_cpu(grant->seq);
 	int newcaps = le32_to_cpu(grant->caps);
-	int issued, implemented, used, wanted, dirty;
+	int used, wanted, dirty;
 	u64 size = le64_to_cpu(grant->size);
 	u64 max_size = le64_to_cpu(grant->max_size);
 	struct timespec mtime, atime, ctime;
@@ -2449,10 +2446,6 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
 	}
 
 	/* side effects now are allowed */
-
-	issued = __ceph_caps_issued(ci, &implemented);
-	issued |= implemented | __ceph_caps_dirty(ci);
-
 	cap->cap_gen = session->s_cap_gen;
 	cap->seq = seq;
 
@@ -2585,6 +2578,16 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
 
 	spin_unlock(&ci->i_ceph_lock);
 
+	if (le32_to_cpu(grant->op) == CEPH_CAP_OP_IMPORT) {
+		down_write(&mdsc->snap_rwsem);
+		ceph_update_snap_trace(mdsc, snaptrace,
+				       snaptrace + snaptrace_len,
+				       false);
+		downgrade_write(&mdsc->snap_rwsem);
+		kick_flushing_inode_caps(mdsc, session, inode);
+		up_read(&mdsc->snap_rwsem);
+	}
+
 	if (queue_trunc) {
 		ceph_queue_vmtruncate(inode);
 		ceph_queue_revalidate(inode);
@@ -2886,21 +2889,22 @@ out_unlock:
 }
 
 /*
- * Handle cap IMPORT.  If there are temp bits from an older EXPORT,
- * clean them up.
+ * Handle cap IMPORT.
  *
- * caller holds s_mutex.
+ * caller holds s_mutex. acquires i_ceph_lock
  */
 static void handle_cap_import(struct ceph_mds_client *mdsc,
 			      struct inode *inode, struct ceph_mds_caps *im,
 			      struct ceph_mds_cap_peer *ph,
 			      struct ceph_mds_session *session,
-			      void *snaptrace, int snaptrace_len)
+			      struct ceph_cap **target_cap, int *old_issued)
+	__acquires(ci->i_ceph_lock)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_cap *cap, *new_cap = NULL;
+	struct ceph_cap *cap, *ocap, *new_cap = NULL;
 	int mds = session->s_mds;
-	unsigned issued = le32_to_cpu(im->caps);
+	int issued;
+	unsigned caps = le32_to_cpu(im->caps);
 	unsigned wanted = le32_to_cpu(im->wanted);
 	unsigned seq = le32_to_cpu(im->seq);
 	unsigned mseq = le32_to_cpu(im->migrate_seq);
@@ -2929,44 +2933,43 @@ retry:
 			new_cap = ceph_get_cap(mdsc, NULL);
 			goto retry;
 		}
+		cap = new_cap;
+	} else {
+		if (new_cap) {
+			ceph_put_cap(mdsc, new_cap);
+			new_cap = NULL;
+		}
 	}
 
-	ceph_add_cap(inode, session, cap_id, -1, issued, wanted, seq, mseq,
+	__ceph_caps_issued(ci, &issued);
+	issued |= __ceph_caps_dirty(ci);
+
+	ceph_add_cap(inode, session, cap_id, -1, caps, wanted, seq, mseq,
 		     realmino, CEPH_CAP_FLAG_AUTH, &new_cap);
 
-	cap = peer >= 0 ? __get_cap_for_mds(ci, peer) : NULL;
-	if (cap && cap->cap_id == p_cap_id) {
+	ocap = peer >= 0 ? __get_cap_for_mds(ci, peer) : NULL;
+	if (ocap && ocap->cap_id == p_cap_id) {
 		dout(" remove export cap %p mds%d flags %d\n",
-		     cap, peer, ph->flags);
+		     ocap, peer, ph->flags);
 		if ((ph->flags & CEPH_CAP_FLAG_AUTH) &&
-		    (cap->seq != le32_to_cpu(ph->seq) ||
-		     cap->mseq != le32_to_cpu(ph->mseq))) {
+		    (ocap->seq != le32_to_cpu(ph->seq) ||
+		     ocap->mseq != le32_to_cpu(ph->mseq))) {
 			pr_err("handle_cap_import: mismatched seq/mseq: "
 			       "ino (%llx.%llx) mds%d seq %d mseq %d "
 			       "importer mds%d has peer seq %d mseq %d\n",
-			       ceph_vinop(inode), peer, cap->seq,
-			       cap->mseq, mds, le32_to_cpu(ph->seq),
+			       ceph_vinop(inode), peer, ocap->seq,
+			       ocap->mseq, mds, le32_to_cpu(ph->seq),
 			       le32_to_cpu(ph->mseq));
 		}
-		__ceph_remove_cap(cap, (ph->flags & CEPH_CAP_FLAG_RELEASE));
+		__ceph_remove_cap(ocap, (ph->flags & CEPH_CAP_FLAG_RELEASE));
 	}
 
 	/* make sure we re-request max_size, if necessary */
 	ci->i_wanted_max_size = 0;
 	ci->i_requested_max_size = 0;
-	spin_unlock(&ci->i_ceph_lock);
-
-	wake_up_all(&ci->i_cap_wq);
 
-	down_write(&mdsc->snap_rwsem);
-	ceph_update_snap_trace(mdsc, snaptrace, snaptrace+snaptrace_len,
-			       false);
-	downgrade_write(&mdsc->snap_rwsem);
-	kick_flushing_inode_caps(mdsc, session, inode);
-	up_read(&mdsc->snap_rwsem);
-
-	if (new_cap)
-		ceph_put_cap(mdsc, new_cap);
+	*old_issued = issued;
+	*target_cap = cap;
 }
 
 /*
@@ -2986,7 +2989,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	struct ceph_mds_caps *h;
 	struct ceph_mds_cap_peer *peer = NULL;
 	int mds = session->s_mds;
-	int op;
+	int op, issued;
 	u32 seq, mseq;
 	struct ceph_vino vino;
 	u64 cap_id;
@@ -3078,7 +3081,10 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 
 	case CEPH_CAP_OP_IMPORT:
 		handle_cap_import(mdsc, inode, h, peer, session,
-				  snaptrace, snaptrace_len);
+				  &cap, &issued);
+		handle_cap_grant(mdsc, inode, h,  snaptrace, snaptrace_len,
+				 msg->middle, session, cap, issued);
+		goto done_unlocked;
 	}
 
 	/* the rest require a cap */
@@ -3095,8 +3101,10 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	switch (op) {
 	case CEPH_CAP_OP_REVOKE:
 	case CEPH_CAP_OP_GRANT:
-	case CEPH_CAP_OP_IMPORT:
-		handle_cap_grant(inode, h, session, cap, msg->middle);
+		__ceph_caps_issued(ci, &issued);
+		issued |= __ceph_caps_dirty(ci);
+		handle_cap_grant(mdsc, inode, h, NULL, 0, msg->middle,
+				 session, cap, issued);
 		goto done_unlocked;
 
 	case CEPH_CAP_OP_FLUSH_ACK:
-- 
1.9.0

