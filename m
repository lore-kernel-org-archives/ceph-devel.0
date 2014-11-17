From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 03/12] libceph: specify position of extent operation
Date: Mon, 17 Nov 2014 15:56:57 +0800
Message-ID: <1416211026-11524-4-git-send-email-zyan@redhat.com>
References: <1416211026-11524-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52617 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085AbaKQH5o (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Nov 2014 02:57:44 -0500
In-Reply-To: <1416211026-11524-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: liwang@ubuntukylin.com, "Yan, Zheng" <zyan@redhat.com>

allow specifying position of extent operation in multi-operations
osd request. This is required for cephfs to convert inline data to
normal data (compare xattr, then write object).

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 fs/ceph/addr.c                  |  9 ++++++---
 fs/ceph/file.c                  |  8 +++++---
 include/linux/ceph/osd_client.h |  3 ++-
 net/ceph/osd_client.c           | 19 ++++++-------------
 4 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 18c06bb..f2c7aa8 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -319,7 +319,7 @@ static int start_read(struct inode *inode, struct list_head *page_list, int max)
 	     off, len);
 	vino = ceph_vino(inode);
 	req = ceph_osdc_new_request(osdc, &ci->i_layout, vino, off, &len,
-				    1, CEPH_OSD_OP_READ,
+				    0, 1, CEPH_OSD_OP_READ,
 				    CEPH_OSD_FLAG_READ, NULL,
 				    ci->i_truncate_seq, ci->i_truncate_size,
 				    false);
@@ -750,7 +750,6 @@ retry:
 	last_snapc = snapc;
 
 	while (!done && index <= end) {
-		int num_ops = do_sync ? 2 : 1;
 		unsigned i;
 		int first;
 		pgoff_t next;
@@ -850,7 +849,8 @@ get_more_pages:
 				len = wsize;
 				req = ceph_osdc_new_request(&fsc->client->osdc,
 							&ci->i_layout, vino,
-							offset, &len, num_ops,
+							offset, &len, 0,
+							do_sync ? 2 : 1,
 							CEPH_OSD_OP_WRITE,
 							CEPH_OSD_FLAG_WRITE |
 							CEPH_OSD_FLAG_ONDISK,
@@ -862,6 +862,9 @@ get_more_pages:
 					break;
 				}
 
+				if (do_sync)
+					osd_req_op_init(req, 1, CEPH_OSD_OP_STARTSYNC);
+
 				req->r_callback = writepages_finish;
 				req->r_inode = inode;
 
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index d7e0da8..c03ac4c 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -598,7 +598,7 @@ ceph_sync_direct_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos)
 		snapc = ci->i_snap_realm->cached_context;
 		vino = ceph_vino(inode);
 		req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
-					    vino, pos, &len,
+					    vino, pos, &len, 0,
 					    2,/*include a 'startsync' command*/
 					    CEPH_OSD_OP_WRITE, flags, snapc,
 					    ci->i_truncate_seq,
@@ -609,6 +609,8 @@ ceph_sync_direct_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos)
 			break;
 		}
 
+		osd_req_op_init(req, 1, CEPH_OSD_OP_STARTSYNC);
+
 		n = iov_iter_get_pages_alloc(from, &pages, len, &start);
 		if (unlikely(n < 0)) {
 			ret = n;
@@ -713,7 +715,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos)
 		snapc = ci->i_snap_realm->cached_context;
 		vino = ceph_vino(inode);
 		req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
-					    vino, pos, &len, 1,
+					    vino, pos, &len, 0, 1,
 					    CEPH_OSD_OP_WRITE, flags, snapc,
 					    ci->i_truncate_seq,
 					    ci->i_truncate_size,
@@ -1111,7 +1113,7 @@ static int ceph_zero_partial_object(struct inode *inode,
 	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
 					ceph_vino(inode),
 					offset, length,
-					1, op,
+					0, 1, op,
 					CEPH_OSD_FLAG_WRITE |
 					CEPH_OSD_FLAG_ONDISK,
 					NULL, 0, 0, false);
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 1ad217b..d3b8edd 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -328,7 +328,8 @@ extern struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *,
 				      struct ceph_file_layout *layout,
 				      struct ceph_vino vino,
 				      u64 offset, u64 *len,
-				      int num_ops, int opcode, int flags,
+				      unsigned int which, int num_ops,
+				      int opcode, int flags,
 				      struct ceph_snap_context *snapc,
 				      u32 truncate_seq, u64 truncate_size,
 				      bool use_mempool);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index b991fb6..cb86857 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -744,7 +744,8 @@ static u64 osd_req_encode_op(struct ceph_osd_request *req,
 struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *osdc,
 					       struct ceph_file_layout *layout,
 					       struct ceph_vino vino,
-					       u64 off, u64 *plen, int num_ops,
+					       u64 off, u64 *plen,
+					       unsigned int which, int num_ops,
 					       int opcode, int flags,
 					       struct ceph_snap_context *snapc,
 					       u32 truncate_seq,
@@ -776,7 +777,7 @@ struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *osdc,
 	}
 
 	if (opcode == CEPH_OSD_OP_CREATE || opcode == CEPH_OSD_OP_DELETE) {
-		osd_req_op_init(req, 0, opcode);
+		osd_req_op_init(req, which, opcode);
 	} else {
 		u32 object_size = le32_to_cpu(layout->fl_object_size);
 		u32 object_base = off - objoff;
@@ -789,17 +790,9 @@ struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *osdc,
 					truncate_size = object_size;
 			}
 		}
-
-		osd_req_op_extent_init(req, 0, opcode, objoff, objlen,
+		osd_req_op_extent_init(req, which, opcode, objoff, objlen,
 				       truncate_size, truncate_seq);
 	}
-	/*
-	 * A second op in the ops array means the caller wants to
-	 * also issue a include a 'startsync' command so that the
-	 * osd will flush data quickly.
-	 */
-	if (num_ops > 1)
-		osd_req_op_init(req, 1, CEPH_OSD_OP_STARTSYNC);
 
 	req->r_base_oloc.pool = ceph_file_layout_pg_pool(*layout);
 
@@ -2666,7 +2659,7 @@ int ceph_osdc_readpages(struct ceph_osd_client *osdc,
 
 	dout("readpages on ino %llx.%llx on %llu~%llu\n", vino.ino,
 	     vino.snap, off, *plen);
-	req = ceph_osdc_new_request(osdc, layout, vino, off, plen, 1,
+	req = ceph_osdc_new_request(osdc, layout, vino, off, plen, 0, 1,
 				    CEPH_OSD_OP_READ, CEPH_OSD_FLAG_READ,
 				    NULL, truncate_seq, truncate_size,
 				    false);
@@ -2709,7 +2702,7 @@ int ceph_osdc_writepages(struct ceph_osd_client *osdc, struct ceph_vino vino,
 	int page_align = off & ~PAGE_MASK;
 
 	BUG_ON(vino.snap != CEPH_NOSNAP);	/* snapshots aren't writeable */
-	req = ceph_osdc_new_request(osdc, layout, vino, off, &len, 1,
+	req = ceph_osdc_new_request(osdc, layout, vino, off, &len, 0, 1,
 				    CEPH_OSD_OP_WRITE,
 				    CEPH_OSD_FLAG_ONDISK | CEPH_OSD_FLAG_WRITE,
 				    snapc, truncate_seq, truncate_size,
-- 
1.9.3

