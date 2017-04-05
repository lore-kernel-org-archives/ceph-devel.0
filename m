From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 5/5] ceph: make seeky readdir more efficiency
Date: Wed,  5 Apr 2017 09:30:19 +0800
Message-ID: <20170405013019.5032-5-zyan@redhat.com>
References: <20170405013019.5032-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755153AbdDEBau (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 4 Apr 2017 21:30:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DAA4F80482
        for <ceph-devel@vger.kernel.org>; Wed,  5 Apr 2017 01:30:49 +0000 (UTC)
In-Reply-To: <20170405013019.5032-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@redhat.com, "Yan, Zheng" <zyan@redhat.com>

Current cephfs client uses string to indicate start position of
readdir. The string is last entry of previous readdir reply.
This approach does not work for seeky readdir because we can
not easily convert the new postion to a string. For seeky readdir,
mds needs to return dentries from the beginning. Client keeps
retrying if the reply does not contain the dentry it wants.

In current version of ceph, mds sorts CDentry in its cache in
hash order. Client also uses dentry hash to compose dir postion.
For seeky readdir, if client passes the hash part of dir postion
to mds. mds can avoid replying useless dentries.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/dir.c                |  4 ++++
 fs/ceph/inode.c              | 17 ++++++++++++-----
 fs/ceph/mds_client.c         |  1 +
 fs/ceph/mds_client.h         |  3 ++-
 include/linux/ceph/ceph_fs.h |  2 ++
 5 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 3e9ad50..ae61cdf 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -378,7 +378,11 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 				ceph_mdsc_put_request(req);
 				return -ENOMEM;
 			}
+		} else if (is_hash_order(ctx->pos)) {
+			req->r_args.readdir.offset_hash =
+				cpu_to_le32(fpos_hash(ctx->pos));
 		}
+
 		req->r_dir_release_cnt = fi->dir_release_count;
 		req->r_dir_ordered_cnt = fi->dir_ordered_count;
 		req->r_readdir_cache_idx = fi->readdir_cache_idx;
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index d449e1c..efee88c 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1482,10 +1482,17 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 	if (test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags))
 		return readdir_prepopulate_inodes_only(req, session);
 
-	if (rinfo->hash_order && req->r_path2) {
-		last_hash = ceph_str_hash(ci->i_dir_layout.dl_dir_hash,
-					  req->r_path2, strlen(req->r_path2));
-		last_hash = ceph_frag_value(last_hash);
+	if (rinfo->hash_order) {
+		if (req->r_path2) {
+			last_hash = ceph_str_hash(ci->i_dir_layout.dl_dir_hash,
+						  req->r_path2,
+						  strlen(req->r_path2));
+			last_hash = ceph_frag_value(last_hash);
+		} else if (rinfo->offset_hash) {
+			/* mds understands offset_hash */
+			WARN_ON_ONCE(req->r_readdir_offset != 2);
+			last_hash = le32_to_cpu(rhead->args.readdir.offset_hash);
+		}
 	}
 
 	if (rinfo->dir_dir &&
@@ -1510,7 +1517,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 	}
 
 	if (ceph_frag_is_leftmost(frag) && req->r_readdir_offset == 2 &&
-	    !(rinfo->hash_order && req->r_path2)) {
+	    !(rinfo->hash_order && last_hash)) {
 		/* note dir version at start of readdir so we can tell
 		 * if any dentries get dropped */
 		req->r_dir_release_cnt = atomic64_read(&ci->i_release_count);
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 5584c98..f7bfc22 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -189,6 +189,7 @@ static int parse_reply_info_dir(void **p, void *end,
 		info->dir_end = !!(flags & CEPH_READDIR_FRAG_END);
 		info->dir_complete = !!(flags & CEPH_READDIR_FRAG_COMPLETE);
 		info->hash_order = !!(flags & CEPH_READDIR_HASH_ORDER);
+		info->offset_hash = !!(flags & CEPH_READDIR_OFFSET_HASH);
 	}
 	if (num == 0)
 		goto done;
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 5416675..db57ae9 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -83,9 +83,10 @@ struct ceph_mds_reply_info_parsed {
 			struct ceph_mds_reply_dirfrag *dir_dir;
 			size_t			      dir_buf_size;
 			int                           dir_nr;
-			bool			      dir_complete;
 			bool			      dir_end;
+			bool			      dir_complete;
 			bool			      hash_order;
+			bool			      offset_hash;
 			struct ceph_mds_reply_dir_entry  *dir_entries;
 		};
 
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index f4b2ee1..1787e4a 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -365,6 +365,7 @@ extern const char *ceph_mds_op_name(int op);
 #define CEPH_READDIR_FRAG_END		(1<<0)
 #define CEPH_READDIR_FRAG_COMPLETE	(1<<8)
 #define CEPH_READDIR_HASH_ORDER		(1<<9)
+#define CEPH_READDIR_OFFSET_HASH	(1<<10)
 
 union ceph_mds_request_args {
 	struct {
@@ -384,6 +385,7 @@ union ceph_mds_request_args {
 		__le32 max_entries;          /* how many dentries to grab */
 		__le32 max_bytes;
 		__le16 flags;
+		__le32 offset_hash;
 	} __attribute__ ((packed)) readdir;
 	struct {
 		__le32 mode;
-- 
2.9.3

