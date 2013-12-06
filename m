From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 09/12] ceph: remove exported caps when handling cap import message
Date: Fri,  6 Dec 2013 16:46:40 +0800
Message-ID: <1386319603-2610-10-git-send-email-zheng.z.yan@intel.com>
References: <1386319603-2610-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23373 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757207Ab3LFIqz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 Dec 2013 03:46:55 -0500
In-Reply-To: <1386319603-2610-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Version 3 cap import message includes the ID of the exported
caps. It allow us to remove the exported caps if we still haven't
received the corresponding cap export message.

We remove the exported caps because they are stale, keeping them
can compromise consistence.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c               | 73 ++++++++++++++++++++++++++++----------------
 include/linux/ceph/ceph_fs.h | 11 ++++++-
 2 files changed, 56 insertions(+), 28 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 53296c6..e3db102 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -611,6 +611,7 @@ retry:
 		if (ci->i_auth_cap == NULL ||
 		    ceph_seq_cmp(ci->i_auth_cap->mseq, mseq) < 0)
 			ci->i_auth_cap = cap;
+		ci->i_cap_exporting_issued = 0;
 	} else if (ci->i_auth_cap == cap) {
 		ci->i_auth_cap = NULL;
 		spin_lock(&mdsc->cap_dirty_lock);
@@ -2822,10 +2823,12 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
  */
 static void handle_cap_import(struct ceph_mds_client *mdsc,
 			      struct inode *inode, struct ceph_mds_caps *im,
+			      struct ceph_mds_cap_peer *ph,
 			      struct ceph_mds_session *session,
 			      void *snaptrace, int snaptrace_len)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_cap *cap;
 	int mds = session->s_mds;
 	unsigned issued = le32_to_cpu(im->caps);
 	unsigned wanted = le32_to_cpu(im->wanted);
@@ -2833,28 +2836,38 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 	unsigned mseq = le32_to_cpu(im->migrate_seq);
 	u64 realmino = le64_to_cpu(im->realm);
 	u64 cap_id = le64_to_cpu(im->cap_id);
+	u64 p_cap_id;
+	int peer;
 
-	if (ci->i_cap_exporting_mds >= 0 &&
-	    ceph_seq_cmp(ci->i_cap_exporting_mseq, mseq) < 0) {
-		dout("handle_cap_import inode %p ci %p mds%d mseq %d"
-		     " - cleared exporting from mds%d\n",
-		     inode, ci, mds, mseq,
-		     ci->i_cap_exporting_mds);
-		ci->i_cap_exporting_issued = 0;
-		ci->i_cap_exporting_mseq = 0;
-		ci->i_cap_exporting_mds = -1;
+	if (ph) {
+		p_cap_id = le64_to_cpu(ph->cap_id);
+		peer = le32_to_cpu(ph->mds);
+	} else {
+		p_cap_id = 0;
+		peer = -1;
+	}
 
-		spin_lock(&mdsc->cap_dirty_lock);
-		if (!list_empty(&ci->i_dirty_item)) {
-			dout(" moving %p back to cap_dirty\n", inode);
-			list_move(&ci->i_dirty_item, &mdsc->cap_dirty);
+	dout("handle_cap_import inode %p ci %p mds%d mseq %d peer %d\n",
+	     inode, ci, mds, mseq, peer);
+
+	spin_lock(&ci->i_ceph_lock);
+	cap = peer >= 0 ? __get_cap_for_mds(ci, peer) : NULL;
+	if (cap && cap->cap_id == p_cap_id) {
+		dout(" remove export cap %p mds%d flags %d\n",
+		     cap, peer, ph->flags);
+		if (ph->flags & CEPH_CAP_FLAG_AUTH) {
+			WARN_ON(cap->seq != le32_to_cpu(ph->seq));
+			WARN_ON(cap->mseq != le32_to_cpu(ph->mseq));
 		}
-		spin_unlock(&mdsc->cap_dirty_lock);
-	} else {
-		dout("handle_cap_import inode %p ci %p mds%d mseq %d\n",
-		     inode, ci, mds, mseq);
+		ci->i_cap_exporting_issued = cap->issued;
+		__ceph_remove_cap(cap, (ph->flags & CEPH_CAP_FLAG_RELEASE));
 	}
 
+	/* make sure we re-request max_size, if necessary */
+	ci->i_wanted_max_size = 0;
+	ci->i_requested_max_size = 0;
+	spin_unlock(&ci->i_ceph_lock);
+
 	down_write(&mdsc->snap_rwsem);
 	ceph_update_snap_trace(mdsc, snaptrace, snaptrace+snaptrace_len,
 			       false);
@@ -2865,11 +2878,6 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 	kick_flushing_inode_caps(mdsc, session, inode);
 	up_read(&mdsc->snap_rwsem);
 
-	/* make sure we re-request max_size, if necessary */
-	spin_lock(&ci->i_ceph_lock);
-	ci->i_wanted_max_size = 0;  /* reset */
-	ci->i_requested_max_size = 0;
-	spin_unlock(&ci->i_ceph_lock);
 }
 
 /*
@@ -2887,6 +2895,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	struct ceph_inode_info *ci;
 	struct ceph_cap *cap;
 	struct ceph_mds_caps *h;
+	struct ceph_mds_cap_peer *peer = NULL;
 	int mds = session->s_mds;
 	int op;
 	u32 seq, mseq;
@@ -2897,12 +2906,14 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	void *snaptrace;
 	size_t snaptrace_len;
 	void *flock;
+	void *end;
 	u32 flock_len;
 	int open_target_sessions = 0;
 
 	dout("handle_caps from mds%d\n", mds);
 
 	/* decode */
+	end = msg->front.iov_base + msg->front.iov_len;
 	tid = le64_to_cpu(msg->hdr.tid);
 	if (msg->front.iov_len < sizeof(*h))
 		goto bad;
@@ -2920,17 +2931,25 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	snaptrace_len = le32_to_cpu(h->snap_trace_len);
 
 	if (le16_to_cpu(msg->hdr.version) >= 2) {
-		void *p, *end;
-
-		p = snaptrace + snaptrace_len;
-		end = msg->front.iov_base + msg->front.iov_len;
+		void *p = snaptrace + snaptrace_len;
 		ceph_decode_32_safe(&p, end, flock_len, bad);
+		if (p + flock_len > end)
+			goto bad;
 		flock = p;
 	} else {
 		flock = NULL;
 		flock_len = 0;
 	}
 
+	if (le16_to_cpu(msg->hdr.version) >= 3) {
+		if (op == CEPH_CAP_OP_IMPORT) {
+			void *p = flock + flock_len;
+			if (p + sizeof(*peer) > end)
+				goto bad;
+			peer = p;
+		}
+	}
+
 	mutex_lock(&session->s_mutex);
 	session->s_seq++;
 	dout(" mds%d seq %lld cap seq %u\n", session->s_mds, session->s_seq,
@@ -2967,7 +2986,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 		goto done;
 
 	case CEPH_CAP_OP_IMPORT:
-		handle_cap_import(mdsc, inode, h, session,
+		handle_cap_import(mdsc, inode, h, peer, session,
 				  snaptrace, snaptrace_len);
 	}
 
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index 26bb587..0a37b98 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -459,7 +459,8 @@ struct ceph_mds_reply_cap {
 	__u8 flags;                    /* CEPH_CAP_FLAG_* */
 } __attribute__ ((packed));
 
-#define CEPH_CAP_FLAG_AUTH  1          /* cap is issued by auth mds */
+#define CEPH_CAP_FLAG_AUTH	(1 << 0)  /* cap is issued by auth mds */
+#define CEPH_CAP_FLAG_RELEASE	(1 << 1)  /* release the cap */
 
 /* inode record, for bundling with mds reply */
 struct ceph_mds_reply_inode {
@@ -660,6 +661,14 @@ struct ceph_mds_caps {
 	__le32 time_warp_seq;
 } __attribute__ ((packed));
 
+struct ceph_mds_cap_peer {
+	__le64 cap_id;
+	__le32 seq;
+	__le32 mseq;
+	__le32 mds;
+	__u8   flags;
+} __attribute__ ((packed));
+
 /* cap release msg head */
 struct ceph_mds_cap_release {
 	__le32 num;                /* number of cap_items that follow */
-- 
1.8.1.4

