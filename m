From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v2 04/13] ceph: move r_got_safe flag into r_req_flags
Date: Wed,  1 Feb 2017 06:49:05 -0500
Message-ID: <20170201114914.20808-5-jlayton@redhat.com>
References: <20170130161942.16537-1-jlayton@redhat.com>
 <20170201114914.20808-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:2601 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751388AbdBALtU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 1 Feb 2017 06:49:20 -0500
In-Reply-To: <20170201114914.20808-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/mds_client.c | 6 +++---
 fs/ceph/mds_client.h | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index ab9b03be1b3f..68d9f172fd02 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2412,13 +2412,13 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 
 	/* dup? */
 	if ((test_bit(CEPH_MDS_R_GOT_UNSAFE, &req->r_req_flags) && !head->safe) ||
-	    (req->r_got_safe && head->safe)) {
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
@@ -2457,7 +2457,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 
 
 	if (head->safe) {
-		req->r_got_safe = true;
+		set_bit(CEPH_MDS_R_GOT_SAFE, &req->r_req_flags);
 		__unregister_request(mdsc, req);
 
 		if (test_bit(CEPH_MDS_R_GOT_UNSAFE, &req->r_req_flags)) {
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index e56fc25ef1bf..f5d2b4d3a336 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -208,6 +208,7 @@ struct ceph_mds_request {
 #define CEPH_MDS_R_DIRECT_IS_HASH	(1) /* r_direct_hash is valid */
 #define CEPH_MDS_R_ABORTED		(2) /* call was aborted */
 #define CEPH_MDS_R_GOT_UNSAFE		(3) /* got an unsafe reply */
+#define CEPH_MDS_R_GOT_SAFE		(4) /* got a safe reply */
 	unsigned long	r_req_flags;
 
 	struct mutex r_fill_mutex;
@@ -265,7 +266,7 @@ struct ceph_mds_request {
 	ceph_mds_request_callback_t r_callback;
 	ceph_mds_request_wait_callback_t r_wait_for_completion;
 	struct list_head  r_unsafe_item;  /* per-session unsafe list item */
-	bool		  r_got_safe, r_got_result;
+	bool		  r_got_result;
 
 	bool              r_did_prepopulate;
 	long long	  r_dir_release_cnt;
-- 
2.9.3

