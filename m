From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/3] ceph: queue cap release in __ceph_remove_cap()
Date: Sun, 22 Sep 2013 12:46:50 +0800
Message-ID: <1379825212-10438-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53405 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752615Ab3IVErS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 22 Sep 2013 00:47:18 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

call __queue_cap_release() in __ceph_remove_cap(), this avoids
acquiring s_cap_lock twice.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c       | 21 +++++++++++----------
 fs/ceph/mds_client.c |  6 ++----
 fs/ceph/super.h      |  8 +-------
 3 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 13976c3..d2d6e40 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -897,7 +897,7 @@ static int __ceph_is_any_caps(struct ceph_inode_info *ci)
  * caller should hold i_ceph_lock.
  * caller will not hold session s_mutex if called from destroy_inode.
  */
-void __ceph_remove_cap(struct ceph_cap *cap)
+void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 {
 	struct ceph_mds_session *session = cap->session;
 	struct ceph_inode_info *ci = cap->ci;
@@ -909,6 +909,10 @@ void __ceph_remove_cap(struct ceph_cap *cap)
 
 	/* remove from session list */
 	spin_lock(&session->s_cap_lock);
+	if (queue_release)
+		__queue_cap_release(session, ci->i_vino.ino, cap->cap_id,
+				    cap->mseq, cap->issue_seq);
+
 	if (session->s_cap_iterator == cap) {
 		/* not yet, we are iterating over this very cap */
 		dout("__ceph_remove_cap  delaying %p removal from session %p\n",
@@ -1023,7 +1027,6 @@ void __queue_cap_release(struct ceph_mds_session *session,
 	struct ceph_mds_cap_release *head;
 	struct ceph_mds_cap_item *item;
 
-	spin_lock(&session->s_cap_lock);
 	BUG_ON(!session->s_num_cap_releases);
 	msg = list_first_entry(&session->s_cap_releases,
 			       struct ceph_msg, list_head);
@@ -1052,7 +1055,6 @@ void __queue_cap_release(struct ceph_mds_session *session,
 		     (int)CEPH_CAPS_PER_RELEASE,
 		     (int)msg->front.iov_len);
 	}
-	spin_unlock(&session->s_cap_lock);
 }
 
 /*
@@ -1067,12 +1069,8 @@ void ceph_queue_caps_release(struct inode *inode)
 	p = rb_first(&ci->i_caps);
 	while (p) {
 		struct ceph_cap *cap = rb_entry(p, struct ceph_cap, ci_node);
-		struct ceph_mds_session *session = cap->session;
-
-		__queue_cap_release(session, ceph_ino(inode), cap->cap_id,
-				    cap->mseq, cap->issue_seq);
 		p = rb_next(p);
-		__ceph_remove_cap(cap);
+		__ceph_remove_cap(cap, true);
 	}
 }
 
@@ -2791,7 +2789,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 			}
 			spin_unlock(&mdsc->cap_dirty_lock);
 		}
-		__ceph_remove_cap(cap);
+		__ceph_remove_cap(cap, false);
 	}
 	/* else, we already released it */
 
@@ -2931,9 +2929,12 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	if (!inode) {
 		dout(" i don't have ino %llx\n", vino.ino);
 
-		if (op == CEPH_CAP_OP_IMPORT)
+		if (op == CEPH_CAP_OP_IMPORT) {
+			spin_lock(&session->s_cap_lock);
 			__queue_cap_release(session, vino.ino, cap_id,
 					    mseq, seq);
+			spin_unlock(&session->s_cap_lock);
+		}
 		goto flush_cap_releases;
 	}
 
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index f51ab26..8f8f5c0 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -986,7 +986,7 @@ static int remove_session_caps_cb(struct inode *inode, struct ceph_cap *cap,
 	dout("removing cap %p, ci is %p, inode is %p\n",
 	     cap, ci, &ci->vfs_inode);
 	spin_lock(&ci->i_ceph_lock);
-	__ceph_remove_cap(cap);
+	__ceph_remove_cap(cap, false);
 	if (!__ceph_is_any_real_caps(ci)) {
 		struct ceph_mds_client *mdsc =
 			ceph_sb_to_client(inode->i_sb)->mdsc;
@@ -1231,9 +1231,7 @@ static int trim_caps_cb(struct inode *inode, struct ceph_cap *cap, void *arg)
 	session->s_trim_caps--;
 	if (oissued) {
 		/* we aren't the only cap.. just remove us */
-		__queue_cap_release(session, ceph_ino(inode), cap->cap_id,
-				    cap->mseq, cap->issue_seq);
-		__ceph_remove_cap(cap);
+		__ceph_remove_cap(cap, true);
 	} else {
 		/* try to drop referring dentries */
 		spin_unlock(&ci->i_ceph_lock);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index a538b51..8de94b5 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -742,13 +742,7 @@ extern int ceph_add_cap(struct inode *inode,
 			int fmode, unsigned issued, unsigned wanted,
 			unsigned cap, unsigned seq, u64 realmino, int flags,
 			struct ceph_cap_reservation *caps_reservation);
-extern void __ceph_remove_cap(struct ceph_cap *cap);
-static inline void ceph_remove_cap(struct ceph_cap *cap)
-{
-	spin_lock(&cap->ci->i_ceph_lock);
-	__ceph_remove_cap(cap);
-	spin_unlock(&cap->ci->i_ceph_lock);
-}
+extern void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release);
 extern void ceph_put_cap(struct ceph_mds_client *mdsc,
 			 struct ceph_cap *cap);
 
-- 
1.8.1.4

