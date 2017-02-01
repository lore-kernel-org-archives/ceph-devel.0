From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v2 01/13] ceph: add new r_req_flags field to ceph_mds_request
Date: Wed,  1 Feb 2017 06:49:02 -0500
Message-ID: <20170201114914.20808-2-jlayton@redhat.com>
References: <20170130161942.16537-1-jlayton@redhat.com>
 <20170201114914.20808-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751388AbdBALtX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 1 Feb 2017 06:49:23 -0500
In-Reply-To: <20170201114914.20808-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com

...and start moving bool flags into it.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/dir.c        | 2 +-
 fs/ceph/mds_client.c | 2 +-
 fs/ceph/mds_client.h | 4 +++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index d4385563b70a..04fa4ae3deca 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -371,7 +371,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		/* hints to request -> mds selection code */
 		req->r_direct_mode = USE_AUTH_MDS;
 		req->r_direct_hash = ceph_frag_value(frag);
-		req->r_direct_is_hash = true;
+		set_bit(CEPH_MDS_R_DIRECT_IS_HASH, &req->r_req_flags);
 		if (fi->last_name) {
 			req->r_path2 = kstrdup(fi->last_name, GFP_KERNEL);
 			if (!req->r_path2) {
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 176512960b14..1f2ef02832d9 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -705,7 +705,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 	int mode = req->r_direct_mode;
 	int mds = -1;
 	u32 hash = req->r_direct_hash;
-	bool is_hash = req->r_direct_is_hash;
+	bool is_hash = test_bit(CEPH_MDS_R_DIRECT_IS_HASH, &req->r_req_flags);
 
 	/*
 	 * is there a specific mds we should try?  ignore hint if we have
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 3c6f77b7bb02..a58cacccc986 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -205,6 +205,9 @@ struct ceph_mds_request {
 	struct inode *r_locked_dir; /* dir (if any) i_mutex locked by vfs */
 	struct inode *r_target_inode;       /* resulting inode */
 
+#define CEPH_MDS_R_DIRECT_IS_HASH	(1) /* r_direct_hash is valid */
+	unsigned long	r_req_flags;
+
 	struct mutex r_fill_mutex;
 
 	union ceph_mds_request_args r_args;
@@ -216,7 +219,6 @@ struct ceph_mds_request {
 	/* for choosing which mds to send this request to */
 	int r_direct_mode;
 	u32 r_direct_hash;      /* choose dir frag based on this dentry hash */
-	bool r_direct_is_hash;  /* true if r_direct_hash is valid */
 
 	/* data payload is used for xattr ops */
 	struct ceph_pagelist *r_pagelist;
-- 
2.9.3

