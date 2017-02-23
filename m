From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 2/3] libceph: get rid of ack vs commit
Date: Thu, 23 Feb 2017 21:59:20 +0100
Message-ID: <1487883561-32001-3-git-send-email-idryomov@gmail.com>
References: <1487883561-32001-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35021 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbdBWVJH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Feb 2017 16:09:07 -0500
Received: by mail-wr0-f196.google.com with SMTP id q39so308711wrb.2
        for <ceph-devel@vger.kernel.org>; Thu, 23 Feb 2017 13:09:06 -0800 (PST)
In-Reply-To: <1487883561-32001-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sweil@redhat.com>, Zheng Yan <zyan@redhat.com>

- CEPH_OSD_FLAG_ACK shouldn't be set anymore, so assert on it
- remove support for handling ack replies (OSDs will send ack replies
  only if clients request them)
- drop the "do lingering callbacks under osd->lock" logic from
  handle_reply() -- lreq->lock is sufficient in all three cases

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 include/linux/ceph/osd_client.h |   6 +--
 net/ceph/osd_client.c           | 113 +++++++++-------------------------------
 2 files changed, 27 insertions(+), 92 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 03a6653d329a..f2ce9cd5ede6 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -22,7 +22,6 @@ struct ceph_osd_client;
  * completion callback for async writepages
  */
 typedef void (*ceph_osdc_callback_t)(struct ceph_osd_request *);
-typedef void (*ceph_osdc_unsafe_callback_t)(struct ceph_osd_request *, bool);
 
 #define CEPH_HOMELESS_OSD	-1
 
@@ -170,15 +169,12 @@ struct ceph_osd_request {
 	unsigned int		r_num_ops;
 
 	int               r_result;
-	bool              r_got_reply;
 
 	struct ceph_osd_client *r_osdc;
 	struct kref       r_kref;
 	bool              r_mempool;
-	struct completion r_completion;
-	struct completion r_done_completion;  /* fsync waiter */
+	struct completion r_completion;       /* fsync waiter */
 	ceph_osdc_callback_t r_callback;
-	ceph_osdc_unsafe_callback_t r_unsafe_callback;
 	struct list_head  r_unsafe_item;
 
 	struct inode *r_inode;         	      /* for use by callbacks */
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index ac4753421d0c..e1c6c2b4a295 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -460,7 +460,6 @@ static void request_init(struct ceph_osd_request *req)
 
 	kref_init(&req->r_kref);
 	init_completion(&req->r_completion);
-	init_completion(&req->r_done_completion);
 	RB_CLEAR_NODE(&req->r_node);
 	RB_CLEAR_NODE(&req->r_mc_node);
 	INIT_LIST_HEAD(&req->r_unsafe_item);
@@ -1637,7 +1636,7 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
 	bool need_send = false;
 	bool promoted = false;
 
-	WARN_ON(req->r_tid || req->r_got_reply);
+	WARN_ON(req->r_tid);
 	dout("%s req %p wrlocked %d\n", __func__, req, wrlocked);
 
 again:
@@ -1705,17 +1704,10 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
 
 static void account_request(struct ceph_osd_request *req)
 {
-	unsigned int mask = CEPH_OSD_FLAG_ACK | CEPH_OSD_FLAG_ONDISK;
+	WARN_ON(req->r_flags & CEPH_OSD_FLAG_ACK);
+	WARN_ON(!(req->r_flags & (CEPH_OSD_FLAG_READ | CEPH_OSD_FLAG_WRITE)));
 
-	if (req->r_flags & CEPH_OSD_FLAG_READ) {
-		WARN_ON(req->r_flags & mask);
-		req->r_flags |= CEPH_OSD_FLAG_ACK;
-	} else if (req->r_flags & CEPH_OSD_FLAG_WRITE)
-		WARN_ON(!(req->r_flags & mask));
-	else
-		WARN_ON(1);
-
-	WARN_ON(req->r_unsafe_callback && (req->r_flags & mask) != mask);
+	req->r_flags |= CEPH_OSD_FLAG_ONDISK;
 	atomic_inc(&req->r_osdc->num_requests);
 }
 
@@ -1750,15 +1742,15 @@ static void finish_request(struct ceph_osd_request *req)
 
 static void __complete_request(struct ceph_osd_request *req)
 {
-	if (req->r_callback)
+	if (req->r_callback) {
+		dout("%s req %p tid %llu cb %pf result %d\n", __func__, req,
+		     req->r_tid, req->r_callback, req->r_result);
 		req->r_callback(req);
-	else
-		complete_all(&req->r_completion);
+	}
 }
 
 /*
- * Note that this is open-coded in handle_reply(), which has to deal
- * with ack vs commit, dup acks, etc.
+ * This is open-coded in handle_reply().
  */
 static void complete_request(struct ceph_osd_request *req, int err)
 {
@@ -1767,7 +1759,7 @@ static void complete_request(struct ceph_osd_request *req, int err)
 	req->r_result = err;
 	finish_request(req);
 	__complete_request(req);
-	complete_all(&req->r_done_completion);
+	complete_all(&req->r_completion);
 	ceph_osdc_put_request(req);
 }
 
@@ -1793,7 +1785,7 @@ static void cancel_request(struct ceph_osd_request *req)
 
 	cancel_map_check(req);
 	finish_request(req);
-	complete_all(&req->r_done_completion);
+	complete_all(&req->r_completion);
 	ceph_osdc_put_request(req);
 }
 
@@ -2170,7 +2162,6 @@ static void linger_commit_cb(struct ceph_osd_request *req)
 	mutex_lock(&lreq->lock);
 	dout("%s lreq %p linger_id %llu result %d\n", __func__, lreq,
 	     lreq->linger_id, req->r_result);
-	WARN_ON(!__linger_registered(lreq));
 	linger_reg_commit_complete(lreq, req->r_result);
 	lreq->committed = true;
 
@@ -2786,31 +2777,8 @@ static int decode_MOSDOpReply(const struct ceph_msg *msg, struct MOSDOpReply *m)
 }
 
 /*
- * We are done with @req if
- *   - @m is a safe reply, or
- *   - @m is an unsafe reply and we didn't want a safe one
- */
-static bool done_request(const struct ceph_osd_request *req,
-			 const struct MOSDOpReply *m)
-{
-	return (m->result < 0 ||
-		(m->flags & CEPH_OSD_FLAG_ONDISK) ||
-		!(req->r_flags & CEPH_OSD_FLAG_ONDISK));
-}
-
-/*
- * handle osd op reply.  either call the callback if it is specified,
- * or do the completion to wake up the waiting thread.
- *
- * ->r_unsafe_callback is set?	yes			no
- *
- * first reply is OK (needed	r_cb/r_completion,	r_cb/r_completion,
- * any or needed/got safe)	r_done_completion	r_done_completion
- *
- * first reply is unsafe	r_unsafe_cb(true)	(nothing)
- *
- * when we get the safe reply	r_unsafe_cb(false),	r_cb/r_completion,
- *				r_done_completion	r_done_completion
+ * Handle MOSDOpReply.  Set ->r_result and call the callback if it is
+ * specified.
  */
 static void handle_reply(struct ceph_osd *osd, struct ceph_msg *msg)
 {
@@ -2819,7 +2787,6 @@ static void handle_reply(struct ceph_osd *osd, struct ceph_msg *msg)
 	struct MOSDOpReply m;
 	u64 tid = le64_to_cpu(msg->hdr.tid);
 	u32 data_len = 0;
-	bool already_acked;
 	int ret;
 	int i;
 
@@ -2898,50 +2865,22 @@ static void handle_reply(struct ceph_osd *osd, struct ceph_msg *msg)
 		       le32_to_cpu(msg->hdr.data_len), req->r_tid);
 		goto fail_request;
 	}
-	dout("%s req %p tid %llu acked %d result %d data_len %u\n", __func__,
-	     req, req->r_tid, req->r_got_reply, m.result, data_len);
-
-	already_acked = req->r_got_reply;
-	if (!already_acked) {
-		req->r_result = m.result ?: data_len;
-		req->r_replay_version = m.replay_version; /* struct */
-		req->r_got_reply = true;
-	} else if (!(m.flags & CEPH_OSD_FLAG_ONDISK)) {
-		dout("req %p tid %llu dup ack\n", req, req->r_tid);
-		goto out_unlock_session;
-	}
-
-	if (done_request(req, &m)) {
-		finish_request(req);
-		if (req->r_linger) {
-			WARN_ON(req->r_unsafe_callback);
-			dout("req %p tid %llu cb (locked)\n", req, req->r_tid);
-			__complete_request(req);
-		}
-	}
+	dout("%s req %p tid %llu result %d data_len %u\n", __func__,
+	     req, req->r_tid, m.result, data_len);
 
+	/*
+	 * Since we only ever request ONDISK, we should only ever get
+	 * one (type of) reply back.
+	 */
+	WARN_ON(!(m.flags & CEPH_OSD_FLAG_ONDISK));
+	req->r_result = m.result ?: data_len;
+	finish_request(req);
 	mutex_unlock(&osd->lock);
 	up_read(&osdc->lock);
 
-	if (done_request(req, &m)) {
-		if (already_acked && req->r_unsafe_callback) {
-			dout("req %p tid %llu safe-cb\n", req, req->r_tid);
-			req->r_unsafe_callback(req, false);
-		} else if (!req->r_linger) {
-			dout("req %p tid %llu cb\n", req, req->r_tid);
-			__complete_request(req);
-		}
-		complete_all(&req->r_done_completion);
-		ceph_osdc_put_request(req);
-	} else {
-		if (req->r_unsafe_callback) {
-			dout("req %p tid %llu unsafe-cb\n", req, req->r_tid);
-			req->r_unsafe_callback(req, true);
-		} else {
-			WARN_ON(1);
-		}
-	}
-
+	__complete_request(req);
+	complete_all(&req->r_completion);
+	ceph_osdc_put_request(req);
 	return;
 
 fail_request:
@@ -3541,7 +3480,7 @@ void ceph_osdc_sync(struct ceph_osd_client *osdc)
 			up_read(&osdc->lock);
 			dout("%s waiting on req %p tid %llu last_tid %llu\n",
 			     __func__, req, req->r_tid, last_tid);
-			wait_for_completion(&req->r_done_completion);
+			wait_for_completion(&req->r_completion);
 			ceph_osdc_put_request(req);
 			goto again;
 		}
-- 
2.4.3

