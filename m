From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v2 05/13] ceph: move r_got_result into r_req_flags
Date: Wed,  1 Feb 2017 06:49:06 -0500
Message-ID: <20170201114914.20808-6-jlayton@redhat.com>
References: <20170130161942.16537-1-jlayton@redhat.com>
 <20170201114914.20808-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751565AbdBALta (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 1 Feb 2017 06:49:30 -0500
In-Reply-To: <20170201114914.20808-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/mds_client.c | 8 ++++----
 fs/ceph/mds_client.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 68d9f172fd02..fc7ae1e0f691 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2116,7 +2116,7 @@ static int __do_request(struct ceph_mds_client *mdsc,
 	int mds = -1;
 	int err = 0;
 
-	if (req->r_err || req->r_got_result) {
+	if (req->r_err || test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags)) {
 		if (test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags))
 			__unregister_request(mdsc, req);
 		goto out;
@@ -2321,7 +2321,7 @@ int ceph_mdsc_do_request(struct ceph_mds_client *mdsc,
 	mutex_lock(&mdsc->mutex);
 
 	/* only abort if we didn't race with a real reply */
-	if (req->r_got_result) {
+	if (test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags)) {
 		err = le32_to_cpu(req->r_reply_info.head->result);
 	} else if (err < 0) {
 		dout("aborted request %lld with %d\n", req->r_tid, err);
@@ -2546,7 +2546,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 			req->r_err = err;
 		} else {
 			req->r_reply =  ceph_msg_get(msg);
-			req->r_got_result = true;
+			set_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags);
 		}
 	} else {
 		dout("reply arrived after request %lld was aborted\n", tid);
@@ -2600,7 +2600,7 @@ static void handle_forward(struct ceph_mds_client *mdsc,
 		/* resend. forward race not possible; mds would drop */
 		dout("forward tid %llu to mds%d (we resend)\n", tid, next_mds);
 		BUG_ON(req->r_err);
-		BUG_ON(req->r_got_result);
+		BUG_ON(test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags));
 		req->r_attempts = 0;
 		req->r_num_fwd = fwd_seq;
 		req->r_resend_mds = next_mds;
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index f5d2b4d3a336..bc36e2c4fe52 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -209,6 +209,7 @@ struct ceph_mds_request {
 #define CEPH_MDS_R_ABORTED		(2) /* call was aborted */
 #define CEPH_MDS_R_GOT_UNSAFE		(3) /* got an unsafe reply */
 #define CEPH_MDS_R_GOT_SAFE		(4) /* got a safe reply */
+#define CEPH_MDS_R_GOT_RESULT		(5) /* got a result */
 	unsigned long	r_req_flags;
 
 	struct mutex r_fill_mutex;
@@ -266,7 +267,6 @@ struct ceph_mds_request {
 	ceph_mds_request_callback_t r_callback;
 	ceph_mds_request_wait_callback_t r_wait_for_completion;
 	struct list_head  r_unsafe_item;  /* per-session unsafe list item */
-	bool		  r_got_result;
 
 	bool              r_did_prepopulate;
 	long long	  r_dir_release_cnt;
-- 
2.9.3

