From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 11/12] ceph: add imported caps when handling cap export message
Date: Fri,  6 Dec 2013 16:46:42 +0800
Message-ID: <1386319603-2610-12-git-send-email-zheng.z.yan@intel.com>
References: <1386319603-2610-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23373 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757143Ab3LFIq6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 Dec 2013 03:46:58 -0500
In-Reply-To: <1386319603-2610-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Version 3 cap export message includes information about the imported
caps. It allows us to add the imported caps if the corresponding cap
import message still hasn't been received.

This allow us to handle situation that the importer MDS crashes and
the cap import message is missing.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c  | 214 ++++++++++++++++++++++++++++++++++++--------------------
 fs/ceph/inode.c |   4 +-
 fs/ceph/super.h |   4 +-
 3 files changed, 140 insertions(+), 82 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index e3db102..9e4104c 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -555,21 +555,34 @@ retry:
 		cap->ci = ci;
 		__insert_cap_node(ci, cap);
 
-		/* clear out old exporting info?  (i.e. on cap import) */
-		if (ci->i_cap_exporting_mds == mds) {
-			ci->i_cap_exporting_issued = 0;
-			ci->i_cap_exporting_mseq = 0;
-			ci->i_cap_exporting_mds = -1;
-		}
-
 		/* add to session cap list */
 		cap->session = session;
 		spin_lock(&session->s_cap_lock);
 		list_add_tail(&cap->session_caps, &session->s_caps);
 		session->s_nr_caps++;
 		spin_unlock(&session->s_cap_lock);
-	} else if (new_cap)
-		ceph_put_cap(mdsc, new_cap);
+	} else {
+		if (new_cap)
+			ceph_put_cap(mdsc, new_cap);
+
+		/*
+		 * auth mds of the inode changed. we received the cap export
+		 * message, but still haven't received the cap import message.
+		 * handle_cap_export() updated the new auth MDS' cap.
+		 *
+		 * "ceph_seq_cmp(seq, cap->seq) <= 0" means we are processing
+		 * a message that was send before the cap import message. So
+		 * don't remove caps.
+		 */
+		if (ceph_seq_cmp(seq, cap->seq) <= 0) {
+			WARN_ON(cap != ci->i_auth_cap);
+			WARN_ON(cap->cap_id != cap_id);
+			seq = cap->seq;
+			mseq = cap->mseq;
+			issued |= cap->issued;
+			flags |= CEPH_CAP_FLAG_AUTH;
+		}
+	}
 
 	if (!ci->i_snap_realm) {
 		/*
@@ -612,15 +625,8 @@ retry:
 		    ceph_seq_cmp(ci->i_auth_cap->mseq, mseq) < 0)
 			ci->i_auth_cap = cap;
 		ci->i_cap_exporting_issued = 0;
-	} else if (ci->i_auth_cap == cap) {
-		ci->i_auth_cap = NULL;
-		spin_lock(&mdsc->cap_dirty_lock);
-		if (!list_empty(&ci->i_dirty_item)) {
-			dout(" moving %p to cap_dirty_migrating\n", inode);
-			list_move(&ci->i_dirty_item,
-				  &mdsc->cap_dirty_migrating);
-		}
-		spin_unlock(&mdsc->cap_dirty_lock);
+	} else {
+		WARN_ON(ci->i_auth_cap == cap);
 	}
 
 	dout("add_cap inode %p (%llx.%llx) cap %p %s now %s seq %d mds%d\n",
@@ -889,7 +895,7 @@ int __ceph_caps_mds_wanted(struct ceph_inode_info *ci)
  */
 static int __ceph_is_any_caps(struct ceph_inode_info *ci)
 {
-	return !RB_EMPTY_ROOT(&ci->i_caps) || ci->i_cap_exporting_mds >= 0;
+	return !RB_EMPTY_ROOT(&ci->i_caps) || ci->i_cap_exporting_issued;
 }
 
 int ceph_is_any_caps(struct inode *inode)
@@ -1396,13 +1402,10 @@ int __ceph_mark_dirty_caps(struct ceph_inode_info *ci, int mask)
 				ci->i_snap_realm->cached_context);
 		dout(" inode %p now dirty snapc %p auth cap %p\n",
 		     &ci->vfs_inode, ci->i_head_snapc, ci->i_auth_cap);
+		WARN_ON(!ci->i_auth_cap);
 		BUG_ON(!list_empty(&ci->i_dirty_item));
 		spin_lock(&mdsc->cap_dirty_lock);
-		if (ci->i_auth_cap)
-			list_add(&ci->i_dirty_item, &mdsc->cap_dirty);
-		else
-			list_add(&ci->i_dirty_item,
-				 &mdsc->cap_dirty_migrating);
+		list_add(&ci->i_dirty_item, &mdsc->cap_dirty);
 		spin_unlock(&mdsc->cap_dirty_lock);
 		if (ci->i_flushing_caps == 0) {
 			ihold(inode);
@@ -2421,6 +2424,22 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
 	dout(" size %llu max_size %llu, i_size %llu\n", size, max_size,
 		inode->i_size);
 
+
+	/*
+	 * auth mds of the inode changed. we received the cap export message,
+	 * but still haven't received the cap import message. handle_cap_export
+	 * updated the new auth MDS' cap.
+	 *
+	 * "ceph_seq_cmp(seq, cap->seq) <= 0" means we are processing a message
+	 * that was sent before the cap import message. So don't remove caps.
+	 */
+	if (ceph_seq_cmp(seq, cap->seq) <= 0) {
+		WARN_ON(cap != ci->i_auth_cap);
+		WARN_ON(cap->cap_id != le64_to_cpu(grant->cap_id));
+		seq = cap->seq;
+		newcaps |= cap->issued;
+	}
+
 	/*
 	 * If CACHE is being revoked, and we have no dirty buffers,
 	 * try to invalidate (once).  (If there are dirty buffers, we
@@ -2447,6 +2466,7 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
 	issued |= implemented | __ceph_caps_dirty(ci);
 
 	cap->cap_gen = session->s_cap_gen;
+	cap->seq = seq;
 
 	__check_cap_issue(ci, cap, newcaps);
 
@@ -2496,6 +2516,10 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
 			    le32_to_cpu(grant->time_warp_seq), &ctime, &mtime,
 			    &atime);
 
+
+	/* file layout may have changed */
+	ci->i_layout = grant->layout;
+
 	/* max size increase? */
 	if (ci->i_auth_cap == cap && max_size != ci->i_max_size) {
 		dout("max_size %lld -> %llu\n", ci->i_max_size, max_size);
@@ -2524,11 +2548,6 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
 			check_caps = 1;
 	}
 
-	cap->seq = seq;
-
-	/* file layout may have changed */
-	ci->i_layout = grant->layout;
-
 	/* revocation, grant, or no-op? */
 	if (cap->issued & ~newcaps) {
 		int revoking = cap->issued & ~newcaps;
@@ -2754,65 +2773,108 @@ static void handle_cap_trunc(struct inode *inode,
  * caller holds s_mutex
  */
 static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
-			      struct ceph_mds_session *session,
-			      int *open_target_sessions)
+			      struct ceph_mds_cap_peer *ph,
+			      struct ceph_mds_session *session)
 {
 	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
+	struct ceph_mds_session *tsession = NULL;
+	struct ceph_cap *cap, *tcap;
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	int mds = session->s_mds;
+	u64 t_cap_id;
 	unsigned mseq = le32_to_cpu(ex->migrate_seq);
-	struct ceph_cap *cap = NULL, *t;
-	struct rb_node *p;
-	int remember = 1;
+	unsigned t_seq, t_mseq;
+	int target, issued;
+	int mds = session->s_mds;
 
-	dout("handle_cap_export inode %p ci %p mds%d mseq %d\n",
-	     inode, ci, mds, mseq);
+	if (ph) {
+		t_cap_id = le64_to_cpu(ph->cap_id);
+		t_seq = le32_to_cpu(ph->seq);
+		t_mseq = le32_to_cpu(ph->mseq);
+		target = le32_to_cpu(ph->mds);
+	} else {
+		t_cap_id = t_seq = t_mseq = 0;
+		target = -1;
+	}
 
+	dout("handle_cap_export inode %p ci %p mds%d mseq %d target %d\n",
+	     inode, ci, mds, mseq, target);
+retry:
 	spin_lock(&ci->i_ceph_lock);
+	cap = __get_cap_for_mds(ci, mds);
+	if (!cap)
+		goto out_unlock;
 
-	/* make sure we haven't seen a higher mseq */
-	for (p = rb_first(&ci->i_caps); p; p = rb_next(p)) {
-		t = rb_entry(p, struct ceph_cap, ci_node);
-		if (ceph_seq_cmp(t->mseq, mseq) > 0) {
-			dout(" higher mseq on cap from mds%d\n",
-			     t->session->s_mds);
-			remember = 0;
+	if (target < 0) {
+		__ceph_remove_cap(cap, false);
+		goto out_unlock;
+	}
+
+	/*
+	 * now we know we haven't received the cap import message yet
+	 * because the exported cap still exist.
+	 */
+
+	issued = cap->issued;
+	WARN_ON(issued != cap->implemented);
+
+	tcap = __get_cap_for_mds(ci, target);
+	if (tcap) {
+		/* already have caps from the target */
+		if (tcap->cap_id != t_cap_id ||
+		    ceph_seq_cmp(tcap->seq, t_seq) < 0) {
+			dout(" updating import cap %p mds%d\n", tcap, target);
+			tcap->cap_id = t_cap_id;
+			tcap->seq = t_seq - 1;
+			tcap->issue_seq = t_seq - 1;
+			tcap->mseq = t_mseq;
+			tcap->issued |= issued;
+			tcap->implemented |= issued;
+			if (cap == ci->i_auth_cap)
+				ci->i_auth_cap = tcap;
 		}
-		if (t->session->s_mds == mds)
-			cap = t;
+		__ceph_remove_cap(cap, false);
+		goto out_unlock;
 	}
 
-	if (cap) {
-		if (remember) {
-			/* make note */
-			ci->i_cap_exporting_mds = mds;
-			ci->i_cap_exporting_mseq = mseq;
-			ci->i_cap_exporting_issued = cap->issued;
+	if (tsession) {
+		int flag = (cap == ci->i_auth_cap) ? CEPH_CAP_FLAG_AUTH : 0;
+		spin_unlock(&ci->i_ceph_lock);
+		/* add placeholder for the export tagert */
+		ceph_add_cap(inode, tsession, t_cap_id, -1, issued, 0,
+			     t_seq - 1, t_mseq, (u64)-1, flag, NULL);
+		goto retry;
+	}
 
-			/*
-			 * make sure we have open sessions with all possible
-			 * export targets, so that we get the matching IMPORT
-			 */
-			*open_target_sessions = 1;
+	spin_unlock(&ci->i_ceph_lock);
+	mutex_unlock(&session->s_mutex);
 
-			/*
-			 * we can't flush dirty caps that we've seen the
-			 * EXPORT but no IMPORT for
-			 */
-			spin_lock(&mdsc->cap_dirty_lock);
-			if (!list_empty(&ci->i_dirty_item)) {
-				dout(" moving %p to cap_dirty_migrating\n",
-				     inode);
-				list_move(&ci->i_dirty_item,
-					  &mdsc->cap_dirty_migrating);
-			}
-			spin_unlock(&mdsc->cap_dirty_lock);
+	/* open target session */
+	tsession = ceph_mdsc_open_export_target_session(mdsc, target);
+	if (!IS_ERR(tsession)) {
+		if (mds > target) {
+			mutex_lock(&session->s_mutex);
+			mutex_lock_nested(&tsession->s_mutex,
+					  SINGLE_DEPTH_NESTING);
+		} else {
+			mutex_lock(&tsession->s_mutex);
+			mutex_lock_nested(&session->s_mutex,
+					  SINGLE_DEPTH_NESTING);
 		}
-		__ceph_remove_cap(cap, false);
+		ceph_add_cap_releases(mdsc, tsession);
+	} else {
+		WARN_ON(1);
+		tsession = NULL;
+		target = -1;
 	}
-	/* else, we already released it */
+	goto retry;
 
+out_unlock:
 	spin_unlock(&ci->i_ceph_lock);
+	mutex_unlock(&session->s_mutex);
+	if (tsession) {
+		mutex_unlock(&tsession->s_mutex);
+		ceph_put_mds_session(tsession);
+	}
 }
 
 /*
@@ -2908,7 +2970,6 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	void *flock;
 	void *end;
 	u32 flock_len;
-	int open_target_sessions = 0;
 
 	dout("handle_caps from mds%d\n", mds);
 
@@ -2947,6 +3008,9 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 			if (p + sizeof(*peer) > end)
 				goto bad;
 			peer = p;
+		} else if (op == CEPH_CAP_OP_EXPORT) {
+			/* recorded in unused fields */
+			peer = (void *)&h->size;
 		}
 	}
 
@@ -2982,8 +3046,8 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 		goto done;
 
 	case CEPH_CAP_OP_EXPORT:
-		handle_cap_export(inode, h, session, &open_target_sessions);
-		goto done;
+		handle_cap_export(inode, h, peer, session);
+		goto done_unlocked;
 
 	case CEPH_CAP_OP_IMPORT:
 		handle_cap_import(mdsc, inode, h, peer, session,
@@ -3038,8 +3102,6 @@ done:
 done_unlocked:
 	if (inode)
 		iput(inode);
-	if (open_target_sessions)
-		ceph_mdsc_open_export_target_sessions(mdsc, session);
 	return;
 
 bad:
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index dac5cae..d7a5b9d 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -335,12 +335,10 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	ci->i_hold_caps_min = 0;
 	ci->i_hold_caps_max = 0;
 	INIT_LIST_HEAD(&ci->i_cap_delay_list);
-	ci->i_cap_exporting_mds = 0;
-	ci->i_cap_exporting_mseq = 0;
-	ci->i_cap_exporting_issued = 0;
 	INIT_LIST_HEAD(&ci->i_cap_snaps);
 	ci->i_head_snapc = NULL;
 	ci->i_snap_caps = 0;
+	ci->i_cap_exporting_issued = 0;
 
 	for (i = 0; i < CEPH_FILE_MODE_NUM; i++)
 		ci->i_nr_by_mode[i] = 0;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 3a4a0f2..cca0ee5 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -287,14 +287,12 @@ struct ceph_inode_info {
 	unsigned long i_hold_caps_min; /* jiffies */
 	unsigned long i_hold_caps_max; /* jiffies */
 	struct list_head i_cap_delay_list;  /* for delayed cap release to mds */
-	int i_cap_exporting_mds;         /* to handle cap migration between */
-	unsigned i_cap_exporting_mseq;   /*  mds's. */
-	unsigned i_cap_exporting_issued;
 	struct ceph_cap_reservation i_cap_migration_resv;
 	struct list_head i_cap_snaps;   /* snapped state pending flush to mds */
 	struct ceph_snap_context *i_head_snapc;  /* set if wr_buffer_head > 0 or
 						    dirty|flushing caps */
 	unsigned i_snap_caps;           /* cap bits for snapped files */
+	unsigned i_cap_exporting_issued;
 
 	int i_nr_by_mode[CEPH_FILE_MODE_NUM];  /* open file counts */
 
-- 
1.8.1.4

