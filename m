From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v3 3/8] ceph: convert bools in ceph_mds_request to a new r_req_flags field
Date: Fri,  3 Feb 2017 13:03:59 -0500
Message-ID: <20170203180404.31930-4-jlayton@redhat.com>
References: <20170201114914.20808-1-jlayton@redhat.com>
 <20170203180404.31930-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751187AbdBCSEI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 3 Feb 2017 13:04:08 -0500
In-Reply-To: <20170203180404.31930-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com

Currently, we have a bunch of bool flags in struct ceph_mds_request. We
need more flags though, but each bool takes (at least) a byte. Those
add up over time.

Merge all of the existing bools in this struct into a single unsigned
long, and use the set/test/clear_bit macros to manipulate them. These
are atomic operations, but that is required here to prevent
load/modify/store races. The existing flags are protected by different
locks, so we can't rely on them for that purpose.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/debugfs.c    |  2 +-
 fs/ceph/dir.c        |  4 ++--
 fs/ceph/inode.c      | 19 ++++++++++---------
 fs/ceph/mds_client.c | 47 +++++++++++++++++++++++++----------------------
 fs/ceph/mds_client.h | 12 ++++++++----
 5 files changed, 46 insertions(+), 38 deletions(-)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 39ff678e567f..f2ae393e2c31 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -70,7 +70,7 @@ static int mdsc_show(struct seq_file *s, void *p)
 
 		seq_printf(s, "%s", ceph_mds_op_name(req->r_op));
 
-		if (req->r_got_unsafe)
+		if (test_bit(CEPH_MDS_R_GOT_UNSAFE, &req->r_req_flags))
 			seq_puts(s, "\t(unsafe)");
 		else
 			seq_puts(s, "\t");
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index d4385563b70a..5fb86d71220e 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -371,7 +371,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		/* hints to request -> mds selection code */
 		req->r_direct_mode = USE_AUTH_MDS;
 		req->r_direct_hash = ceph_frag_value(frag);
-		req->r_direct_is_hash = true;
+		__set_bit(CEPH_MDS_R_DIRECT_IS_HASH, &req->r_req_flags);
 		if (fi->last_name) {
 			req->r_path2 = kstrdup(fi->last_name, GFP_KERNEL);
 			if (!req->r_path2) {
@@ -417,7 +417,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		fi->frag = frag;
 		fi->last_readdir = req;
 
-		if (req->r_did_prepopulate) {
+		if (test_bit(CEPH_MDS_R_DID_PREPOPULATE, &req->r_req_flags)) {
 			fi->readdir_cache_idx = req->r_readdir_cache_idx;
 			if (fi->readdir_cache_idx < 0) {
 				/* preclude from marking dir ordered */
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index b18462c64cdd..e54ba03d3df7 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1199,8 +1199,8 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 
 		err = fill_inode(in, req->r_locked_page, &rinfo->targeti, NULL,
 				session, req->r_request_started,
-				(!req->r_aborted && rinfo->head->result == 0) ?
-				req->r_fmode : -1,
+				(!test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags) &&
+				rinfo->head->result == 0) ?  req->r_fmode : -1,
 				&req->r_caps_reservation);
 		if (err < 0) {
 			pr_err("fill_inode badness %p %llx.%llx\n",
@@ -1209,12 +1209,14 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 		}
 	}
 
+	if (test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags))
+		goto done;
+
 	/*
 	 * ignore null lease/binding on snapdir ENOENT, or else we
 	 * will have trouble splicing in the virtual snapdir later
 	 */
-	if (rinfo->head->is_dentry && !req->r_aborted &&
-	    req->r_locked_dir &&
+	if (rinfo->head->is_dentry && req->r_locked_dir &&
 	    (rinfo->head->is_target || strncmp(req->r_dentry->d_name.name,
 					       fsc->mount_options->snapdir_name,
 					       req->r_dentry->d_name.len))) {
@@ -1317,9 +1319,8 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 			update_dentry_lease(dn, rinfo->dlease, session,
 					    req->r_request_started);
 		dout(" final dn %p\n", dn);
-	} else if (!req->r_aborted &&
-		   (req->r_op == CEPH_MDS_OP_LOOKUPSNAP ||
-		    req->r_op == CEPH_MDS_OP_MKSNAP)) {
+	} else if (req->r_op == CEPH_MDS_OP_LOOKUPSNAP ||
+		   req->r_op == CEPH_MDS_OP_MKSNAP) {
 		struct dentry *dn = req->r_dentry;
 		struct inode *dir = req->r_locked_dir;
 
@@ -1444,7 +1445,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 	u32 fpos_offset;
 	struct ceph_readdir_cache_control cache_ctl = {};
 
-	if (req->r_aborted)
+	if (test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags))
 		return readdir_prepopulate_inodes_only(req, session);
 
 	if (rinfo->hash_order && req->r_path2) {
@@ -1598,7 +1599,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 	}
 out:
 	if (err == 0 && skipped == 0) {
-		req->r_did_prepopulate = true;
+		set_bit(CEPH_MDS_R_DID_PREPOPULATE, &req->r_req_flags);
 		req->r_readdir_cache_idx = cache_ctl.index;
 	}
 	ceph_readdir_cache_release(&cache_ctl);
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 4a68067a76b5..ccf75a3260e8 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -644,13 +644,15 @@ static void __unregister_request(struct ceph_mds_client *mdsc,
 
 	erase_request(&mdsc->request_tree, req);
 
-	if (req->r_unsafe_dir && req->r_got_unsafe) {
+	if (req->r_unsafe_dir  &&
+	    test_bit(CEPH_MDS_R_GOT_UNSAFE, &req->r_req_flags)) {
 		struct ceph_inode_info *ci = ceph_inode(req->r_unsafe_dir);
 		spin_lock(&ci->i_unsafe_lock);
 		list_del_init(&req->r_unsafe_dir_item);
 		spin_unlock(&ci->i_unsafe_lock);
 	}
-	if (req->r_target_inode && req->r_got_unsafe) {
+	if (req->r_target_inode &&
+	    test_bit(CEPH_MDS_R_GOT_UNSAFE, &req->r_req_flags)) {
 		struct ceph_inode_info *ci = ceph_inode(req->r_target_inode);
 		spin_lock(&ci->i_unsafe_lock);
 		list_del_init(&req->r_unsafe_target_item);
@@ -705,7 +707,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 	int mode = req->r_direct_mode;
 	int mds = -1;
 	u32 hash = req->r_direct_hash;
-	bool is_hash = req->r_direct_is_hash;
+	bool is_hash = test_bit(CEPH_MDS_R_DIRECT_IS_HASH, &req->r_req_flags);
 
 	/*
 	 * is there a specific mds we should try?  ignore hint if we have
@@ -2042,7 +2044,7 @@ static int __prepare_send_request(struct ceph_mds_client *mdsc,
 	dout("prepare_send_request %p tid %lld %s (attempt %d)\n", req,
 	     req->r_tid, ceph_mds_op_name(req->r_op), req->r_attempts);
 
-	if (req->r_got_unsafe) {
+	if (test_bit(CEPH_MDS_R_GOT_UNSAFE, &req->r_req_flags)) {
 		void *p;
 		/*
 		 * Replay.  Do not regenerate message (and rebuild
@@ -2091,7 +2093,7 @@ static int __prepare_send_request(struct ceph_mds_client *mdsc,
 
 	rhead = msg->front.iov_base;
 	rhead->oldest_client_tid = cpu_to_le64(__get_oldest_tid(mdsc));
-	if (req->r_got_unsafe)
+	if (test_bit(CEPH_MDS_R_GOT_UNSAFE, &req->r_req_flags))
 		flags |= CEPH_MDS_FLAG_REPLAY;
 	if (req->r_locked_dir)
 		flags |= CEPH_MDS_FLAG_WANT_DENTRY;
@@ -2114,8 +2116,8 @@ static int __do_request(struct ceph_mds_client *mdsc,
 	int mds = -1;
 	int err = 0;
 
-	if (req->r_err || req->r_got_result) {
-		if (req->r_aborted)
+	if (req->r_err || test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags)) {
+		if (test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags))
 			__unregister_request(mdsc, req);
 		goto out;
 	}
@@ -2245,7 +2247,7 @@ static void kick_requests(struct ceph_mds_client *mdsc, int mds)
 	while (p) {
 		req = rb_entry(p, struct ceph_mds_request, r_node);
 		p = rb_next(p);
-		if (req->r_got_unsafe)
+		if (test_bit(CEPH_MDS_R_GOT_UNSAFE, &req->r_req_flags))
 			continue;
 		if (req->r_attempts > 0)
 			continue; /* only new requests */
@@ -2319,7 +2321,7 @@ int ceph_mdsc_do_request(struct ceph_mds_client *mdsc,
 	mutex_lock(&mdsc->mutex);
 
 	/* only abort if we didn't race with a real reply */
-	if (req->r_got_result) {
+	if (test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags)) {
 		err = le32_to_cpu(req->r_reply_info.head->result);
 	} else if (err < 0) {
 		dout("aborted request %lld with %d\n", req->r_tid, err);
@@ -2331,7 +2333,7 @@ int ceph_mdsc_do_request(struct ceph_mds_client *mdsc,
 		 */
 		mutex_lock(&req->r_fill_mutex);
 		req->r_err = err;
-		req->r_aborted = true;
+		set_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags);
 		mutex_unlock(&req->r_fill_mutex);
 
 		if (req->r_locked_dir &&
@@ -2409,14 +2411,14 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	}
 
 	/* dup? */
-	if ((req->r_got_unsafe && !head->safe) ||
-	    (req->r_got_safe && head->safe)) {
+	if ((test_bit(CEPH_MDS_R_GOT_UNSAFE, &req->r_req_flags) && !head->safe) ||
+	    (test_bit(CEPH_MDS_R_GOT_SAFE, &req->r_req_flags) && head->safe)) {
 		pr_warn("got a dup %s reply on %llu from mds%d\n",
 			   head->safe ? "safe" : "unsafe", tid, mds);
 		mutex_unlock(&mdsc->mutex);
 		goto out;
 	}
-	if (req->r_got_safe) {
+	if (test_bit(CEPH_MDS_R_GOT_SAFE, &req->r_req_flags)) {
 		pr_warn("got unsafe after safe on %llu from mds%d\n",
 			   tid, mds);
 		mutex_unlock(&mdsc->mutex);
@@ -2455,10 +2457,10 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 
 
 	if (head->safe) {
-		req->r_got_safe = true;
+		set_bit(CEPH_MDS_R_GOT_SAFE, &req->r_req_flags);
 		__unregister_request(mdsc, req);
 
-		if (req->r_got_unsafe) {
+		if (test_bit(CEPH_MDS_R_GOT_UNSAFE, &req->r_req_flags)) {
 			/*
 			 * We already handled the unsafe response, now do the
 			 * cleanup.  No need to examine the response; the MDS
@@ -2476,7 +2478,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 			goto out;
 		}
 	} else {
-		req->r_got_unsafe = true;
+		set_bit(CEPH_MDS_R_GOT_UNSAFE, &req->r_req_flags);
 		list_add_tail(&req->r_unsafe_item, &req->r_session->s_unsafe);
 		if (req->r_unsafe_dir) {
 			struct ceph_inode_info *ci =
@@ -2530,7 +2532,8 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	if (realm)
 		ceph_put_snap_realm(mdsc, realm);
 
-	if (err == 0 && req->r_got_unsafe && req->r_target_inode) {
+	if (err == 0 && req->r_target_inode &&
+	    test_bit(CEPH_MDS_R_GOT_UNSAFE, &req->r_req_flags)) {
 		struct ceph_inode_info *ci = ceph_inode(req->r_target_inode);
 		spin_lock(&ci->i_unsafe_lock);
 		list_add_tail(&req->r_unsafe_target_item, &ci->i_unsafe_iops);
@@ -2538,12 +2541,12 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	}
 out_err:
 	mutex_lock(&mdsc->mutex);
-	if (!req->r_aborted) {
+	if (!test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags)) {
 		if (err) {
 			req->r_err = err;
 		} else {
 			req->r_reply =  ceph_msg_get(msg);
-			req->r_got_result = true;
+			set_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags);
 		}
 	} else {
 		dout("reply arrived after request %lld was aborted\n", tid);
@@ -2587,7 +2590,7 @@ static void handle_forward(struct ceph_mds_client *mdsc,
 		goto out;  /* dup reply? */
 	}
 
-	if (req->r_aborted) {
+	if (test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags)) {
 		dout("forward tid %llu aborted, unregistering\n", tid);
 		__unregister_request(mdsc, req);
 	} else if (fwd_seq <= req->r_num_fwd) {
@@ -2597,7 +2600,7 @@ static void handle_forward(struct ceph_mds_client *mdsc,
 		/* resend. forward race not possible; mds would drop */
 		dout("forward tid %llu to mds%d (we resend)\n", tid, next_mds);
 		BUG_ON(req->r_err);
-		BUG_ON(req->r_got_result);
+		BUG_ON(test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags));
 		req->r_attempts = 0;
 		req->r_num_fwd = fwd_seq;
 		req->r_resend_mds = next_mds;
@@ -2762,7 +2765,7 @@ static void replay_unsafe_requests(struct ceph_mds_client *mdsc,
 	while (p) {
 		req = rb_entry(p, struct ceph_mds_request, r_node);
 		p = rb_next(p);
-		if (req->r_got_unsafe)
+		if (test_bit(CEPH_MDS_R_GOT_UNSAFE, &req->r_req_flags))
 			continue;
 		if (req->r_attempts == 0)
 			continue; /* only old requests */
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 3c6f77b7bb02..409b0e3c3b7a 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -205,6 +205,14 @@ struct ceph_mds_request {
 	struct inode *r_locked_dir; /* dir (if any) i_mutex locked by vfs */
 	struct inode *r_target_inode;       /* resulting inode */
 
+#define CEPH_MDS_R_DIRECT_IS_HASH	(1) /* r_direct_hash is valid */
+#define CEPH_MDS_R_ABORTED		(2) /* call was aborted */
+#define CEPH_MDS_R_GOT_UNSAFE		(3) /* got an unsafe reply */
+#define CEPH_MDS_R_GOT_SAFE		(4) /* got a safe reply */
+#define CEPH_MDS_R_GOT_RESULT		(5) /* got a result */
+#define CEPH_MDS_R_DID_PREPOPULATE	(6) /* prepopulated readdir */
+	unsigned long	r_req_flags;
+
 	struct mutex r_fill_mutex;
 
 	union ceph_mds_request_args r_args;
@@ -216,7 +224,6 @@ struct ceph_mds_request {
 	/* for choosing which mds to send this request to */
 	int r_direct_mode;
 	u32 r_direct_hash;      /* choose dir frag based on this dentry hash */
-	bool r_direct_is_hash;  /* true if r_direct_hash is valid */
 
 	/* data payload is used for xattr ops */
 	struct ceph_pagelist *r_pagelist;
@@ -234,7 +241,6 @@ struct ceph_mds_request {
 	struct ceph_mds_reply_info_parsed r_reply_info;
 	struct page *r_locked_page;
 	int r_err;
-	bool r_aborted;
 
 	unsigned long r_timeout;  /* optional.  jiffies, 0 is "wait forever" */
 	unsigned long r_started;  /* start time to measure timeout against */
@@ -262,9 +268,7 @@ struct ceph_mds_request {
 	ceph_mds_request_callback_t r_callback;
 	ceph_mds_request_wait_callback_t r_wait_for_completion;
 	struct list_head  r_unsafe_item;  /* per-session unsafe list item */
-	bool		  r_got_unsafe, r_got_safe, r_got_result;
 
-	bool              r_did_prepopulate;
 	long long	  r_dir_release_cnt;
 	long long	  r_dir_ordered_cnt;
 	int		  r_readdir_cache_idx;
-- 
2.9.3

