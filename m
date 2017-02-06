From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v2 6/6] libceph: allow requests to return immediately on full conditions if caller wishes
Date: Mon,  6 Feb 2017 08:29:27 -0500
Message-ID: <20170206132927.9219-7-jlayton@redhat.com>
References: <20170206132927.9219-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751414AbdBFN3e (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 6 Feb 2017 08:29:34 -0500
In-Reply-To: <20170206132927.9219-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, jspray@redhat.com

Right now, cephfs will cancel any in-flight OSD write operations when a
new map comes in that shows the OSD or pool as full, but nothing
prevents new requests from stalling out after that point.

If the caller knows that it will want an immediate error return instead
of blocking on a full or at-quota error condition then allow it to set a
flag to request that behavior. Cephfs write requests will always set
that flag.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/addr.c             | 14 +++++++++-----
 fs/ceph/file.c             |  8 +++++---
 include/linux/ceph/rados.h |  1 +
 net/ceph/osd_client.c      |  6 ++++++
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 4547bbf80e4f..577fe6351de1 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1019,7 +1019,8 @@ static int ceph_writepages_start(struct address_space *mapping,
 					offset, &len, 0, num_ops,
 					CEPH_OSD_OP_WRITE,
 					CEPH_OSD_FLAG_WRITE |
-					CEPH_OSD_FLAG_ONDISK,
+					CEPH_OSD_FLAG_ONDISK |
+					CEPH_OSD_FLAG_FULL_CANCEL,
 					snapc, truncate_seq,
 					truncate_size, false);
 		if (IS_ERR(req)) {
@@ -1030,7 +1031,8 @@ static int ceph_writepages_start(struct address_space *mapping,
 						    CEPH_OSD_SLAB_OPS),
 						CEPH_OSD_OP_WRITE,
 						CEPH_OSD_FLAG_WRITE |
-						CEPH_OSD_FLAG_ONDISK,
+						CEPH_OSD_FLAG_ONDISK |
+						CEPH_OSD_FLAG_FULL_CANCEL,
 						snapc, truncate_seq,
 						truncate_size, true);
 			BUG_ON(IS_ERR(req));
@@ -1681,7 +1683,9 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
 				    ceph_vino(inode), 0, &len, 0, 1,
 				    CEPH_OSD_OP_CREATE,
-				    CEPH_OSD_FLAG_ONDISK | CEPH_OSD_FLAG_WRITE,
+				    CEPH_OSD_FLAG_ONDISK |
+				    CEPH_OSD_FLAG_WRITE |
+				    CEPH_OSD_FLAG_FULL_CANCEL,
 				    NULL, 0, 0, false);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
@@ -1699,7 +1703,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
 				    ceph_vino(inode), 0, &len, 1, 3,
 				    CEPH_OSD_OP_WRITE,
-				    CEPH_OSD_FLAG_ONDISK | CEPH_OSD_FLAG_WRITE,
+				    CEPH_OSD_FLAG_ONDISK | CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_FULL_CANCEL,
 				    NULL, ci->i_truncate_seq,
 				    ci->i_truncate_size, false);
 	if (IS_ERR(req)) {
@@ -1872,7 +1876,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
 		goto out_unlock;
 	}
 
-	wr_req->r_flags = CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ACK;
+	wr_req->r_flags = CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ACK | CEPH_OSD_FLAG_FULL_CANCEL;
 	osd_req_op_init(wr_req, 0, CEPH_OSD_OP_CREATE, CEPH_OSD_OP_FLAG_EXCL);
 	ceph_oloc_copy(&wr_req->r_base_oloc, &rd_req->r_base_oloc);
 	ceph_oid_copy(&wr_req->r_base_oid, &rd_req->r_base_oid);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index a91a4f1fc837..938dca02db7a 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -692,7 +692,7 @@ static void ceph_aio_retry_work(struct work_struct *work)
 
 	req->r_flags =	CEPH_OSD_FLAG_ORDERSNAP |
 			CEPH_OSD_FLAG_ONDISK |
-			CEPH_OSD_FLAG_WRITE;
+			CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_FULL_CANCEL;
 	ceph_oloc_copy(&req->r_base_oloc, &orig_req->r_base_oloc);
 	ceph_oid_copy(&req->r_base_oid, &orig_req->r_base_oid);
 
@@ -849,7 +849,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 
 		flags = CEPH_OSD_FLAG_ORDERSNAP |
 			CEPH_OSD_FLAG_ONDISK |
-			CEPH_OSD_FLAG_WRITE;
+			CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_FULL_CANCEL;
 	} else {
 		flags = CEPH_OSD_FLAG_READ;
 	}
@@ -1051,6 +1051,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 	flags = CEPH_OSD_FLAG_ORDERSNAP |
 		CEPH_OSD_FLAG_ONDISK |
 		CEPH_OSD_FLAG_WRITE |
+		CEPH_OSD_FLAG_FULL_CANCEL |
 		CEPH_OSD_FLAG_ACK;
 
 	while ((len = iov_iter_count(from)) > 0) {
@@ -1549,7 +1550,8 @@ static int ceph_zero_partial_object(struct inode *inode,
 					offset, length,
 					0, 1, op,
 					CEPH_OSD_FLAG_WRITE |
-					CEPH_OSD_FLAG_ONDISK,
+					CEPH_OSD_FLAG_ONDISK |
+					CEPH_OSD_FLAG_FULL_CANCEL,
 					NULL, 0, 0, false);
 	if (IS_ERR(req)) {
 		ret = PTR_ERR(req);
diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
index 5c0da61cb763..def43570a85a 100644
--- a/include/linux/ceph/rados.h
+++ b/include/linux/ceph/rados.h
@@ -401,6 +401,7 @@ enum {
 	CEPH_OSD_FLAG_KNOWN_REDIR = 0x400000,  /* redirect bit is authoritative */
 	CEPH_OSD_FLAG_FULL_TRY =    0x800000,  /* try op despite full flag */
 	CEPH_OSD_FLAG_FULL_FORCE = 0x1000000,  /* force op despite full flag */
+	CEPH_OSD_FLAG_FULL_CANCEL = 0x2000000, /* cancel operation on full flag */
 };
 
 enum {
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index d61d7a79fdb3..3b0e1220b552 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -50,6 +50,7 @@ static void link_linger(struct ceph_osd *osd,
 			struct ceph_osd_linger_request *lreq);
 static void unlink_linger(struct ceph_osd *osd,
 			  struct ceph_osd_linger_request *lreq);
+static void complete_request(struct ceph_osd_request *req, int err);
 
 #if 1
 static inline bool rwsem_is_wrlocked(struct rw_semaphore *sem)
@@ -1643,6 +1644,7 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
 	enum calc_target_result ct_res;
 	bool need_send = false;
 	bool promoted = false;
+	int ret = 0;
 
 	WARN_ON(req->r_tid || req->r_got_reply);
 	dout("%s req %p wrlocked %d\n", __func__, req, wrlocked);
@@ -1683,6 +1685,8 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
 		pr_warn_ratelimited("FULL or reached pool quota\n");
 		req->r_t.paused = true;
 		maybe_request_map(osdc);
+		if (req->r_flags & CEPH_OSD_FLAG_FULL_CANCEL)
+			ret = -ENOSPC;
 	} else if (!osd_homeless(osd)) {
 		need_send = true;
 	} else {
@@ -1699,6 +1703,8 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
 	link_request(osd, req);
 	if (need_send)
 		send_request(req);
+	else if (ret)
+		complete_request(req, ret);
 	mutex_unlock(&osd->lock);
 
 	if (ct_res == CALC_TARGET_POOL_DNE)
-- 
2.9.3

