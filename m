From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v2 03/13] ceph: move r_got_unsafe flag into r_req_flags
Date: Wed,  1 Feb 2017 06:49:04 -0500
Message-ID: <20170201114914.20808-4-jlayton@redhat.com>
References: <20170130161942.16537-1-jlayton@redhat.com>
 <20170201114914.20808-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55153 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751374AbdBALta (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 1 Feb 2017 06:49:30 -0500
In-Reply-To: <20170201114914.20808-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/debugfs.c    |  2 +-
 fs/ceph/mds_client.c | 23 +++++++++++++----------
 fs/ceph/mds_client.h |  3 ++-
 3 files changed, 16 insertions(+), 12 deletions(-)

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
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index a5156b6a0aed..ab9b03be1b3f 100644
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
@@ -2245,7 +2247,7 @@ static void kick_requests(struct ceph_mds_client *mdsc, int mds)
 	while (p) {
 		req = rb_entry(p, struct ceph_mds_request, r_node);
 		p = rb_next(p);
-		if (req->r_got_unsafe)
+		if (test_bit(CEPH_MDS_R_GOT_UNSAFE, &req->r_req_flags))
 			continue;
 		if (req->r_attempts > 0)
 			continue; /* only new requests */
@@ -2409,7 +2411,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	}
 
 	/* dup? */
-	if ((req->r_got_unsafe && !head->safe) ||
+	if ((test_bit(CEPH_MDS_R_GOT_UNSAFE, &req->r_req_flags) && !head->safe) ||
 	    (req->r_got_safe && head->safe)) {
 		pr_warn("got a dup %s reply on %llu from mds%d\n",
 			   head->safe ? "safe" : "unsafe", tid, mds);
@@ -2458,7 +2460,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 		req->r_got_safe = true;
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
index 3da20955d5e6..e56fc25ef1bf 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -207,6 +207,7 @@ struct ceph_mds_request {
 
 #define CEPH_MDS_R_DIRECT_IS_HASH	(1) /* r_direct_hash is valid */
 #define CEPH_MDS_R_ABORTED		(2) /* call was aborted */
+#define CEPH_MDS_R_GOT_UNSAFE		(3) /* got an unsafe reply */
 	unsigned long	r_req_flags;
 
 	struct mutex r_fill_mutex;
@@ -264,7 +265,7 @@ struct ceph_mds_request {
 	ceph_mds_request_callback_t r_callback;
 	ceph_mds_request_wait_callback_t r_wait_for_completion;
 	struct list_head  r_unsafe_item;  /* per-session unsafe list item */
-	bool		  r_got_unsafe, r_got_safe, r_got_result;
+	bool		  r_got_safe, r_got_result;
 
 	bool              r_did_prepopulate;
 	long long	  r_dir_release_cnt;
-- 
2.9.3

