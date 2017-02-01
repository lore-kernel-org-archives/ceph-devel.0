From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v2 06/13] ceph: move r_did_prepopulate into r_req_flags
Date: Wed,  1 Feb 2017 06:49:07 -0500
Message-ID: <20170201114914.20808-7-jlayton@redhat.com>
References: <20170130161942.16537-1-jlayton@redhat.com>
 <20170201114914.20808-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751192AbdBALtV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 1 Feb 2017 06:49:21 -0500
In-Reply-To: <20170201114914.20808-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/dir.c        | 2 +-
 fs/ceph/inode.c      | 2 +-
 fs/ceph/mds_client.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 04fa4ae3deca..fba974dac48b 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -417,7 +417,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		fi->frag = frag;
 		fi->last_readdir = req;
 
-		if (req->r_did_prepopulate) {
+		if (test_bit(CEPH_MDS_R_DID_PREPOPULATE, &req->r_req_flags)) {
 			fi->readdir_cache_idx = req->r_readdir_cache_idx;
 			if (fi->readdir_cache_idx < 0) {
 				/* preclude from marking dir ordered */
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index bd2e94a78057..31827f3dcef0 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1633,7 +1633,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 	}
 out:
 	if (err == 0 && skipped == 0) {
-		req->r_did_prepopulate = true;
+		set_bit(CEPH_MDS_R_DID_PREPOPULATE, &req->r_req_flags);
 		req->r_readdir_cache_idx = cache_ctl.index;
 	}
 	ceph_readdir_cache_release(&cache_ctl);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index bc36e2c4fe52..409b0e3c3b7a 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -210,6 +210,7 @@ struct ceph_mds_request {
 #define CEPH_MDS_R_GOT_UNSAFE		(3) /* got an unsafe reply */
 #define CEPH_MDS_R_GOT_SAFE		(4) /* got a safe reply */
 #define CEPH_MDS_R_GOT_RESULT		(5) /* got a result */
+#define CEPH_MDS_R_DID_PREPOPULATE	(6) /* prepopulated readdir */
 	unsigned long	r_req_flags;
 
 	struct mutex r_fill_mutex;
@@ -268,7 +269,6 @@ struct ceph_mds_request {
 	ceph_mds_request_wait_callback_t r_wait_for_completion;
 	struct list_head  r_unsafe_item;  /* per-session unsafe list item */
 
-	bool              r_did_prepopulate;
 	long long	  r_dir_release_cnt;
 	long long	  r_dir_ordered_cnt;
 	int		  r_readdir_cache_idx;
-- 
2.9.3

