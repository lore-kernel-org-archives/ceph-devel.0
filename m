From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 3/3] libceph, rbd, ceph: WRITE | ONDISK -> WRITE
Date: Thu, 23 Feb 2017 21:59:21 +0100
Message-ID: <1487883561-32001-4-git-send-email-idryomov@gmail.com>
References: <1487883561-32001-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33168 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbdBWVGF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Feb 2017 16:06:05 -0500
Received: by mail-wr0-f193.google.com with SMTP id g10so1179wrg.0
        for <ceph-devel@vger.kernel.org>; Thu, 23 Feb 2017 13:06:04 -0800 (PST)
In-Reply-To: <1487883561-32001-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sweil@redhat.com>, Zheng Yan <zyan@redhat.com>

CEPH_OSD_FLAG_ONDISK is set in account_request().

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c        |  6 ++----
 fs/ceph/addr.c             | 14 +++++---------
 fs/ceph/file.c             | 15 ++++-----------
 net/ceph/cls_lock_client.c | 12 ++++++------
 net/ceph/osd_client.c      |  9 ++++-----
 5 files changed, 21 insertions(+), 35 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 24e05b02d033..2acdb99cbabd 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1981,8 +1981,7 @@ static struct ceph_osd_request *rbd_osd_req_create(
 
 	return __rbd_osd_req_create(rbd_dev, snapc, num_ops,
 	    (op_type == OBJ_OP_WRITE || op_type == OBJ_OP_DISCARD) ?
-	    CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK : CEPH_OSD_FLAG_READ,
-	    obj_request);
+	    CEPH_OSD_FLAG_WRITE : CEPH_OSD_FLAG_READ, obj_request);
 }
 
 /*
@@ -2008,8 +2007,7 @@ rbd_osd_req_create_copyup(struct rbd_obj_request *obj_request)
 
 	return __rbd_osd_req_create(img_request->rbd_dev,
 				    img_request->snapc, num_osd_ops,
-				    CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
-				    obj_request);
+				    CEPH_OSD_FLAG_WRITE, obj_request);
 }
 
 static void rbd_osd_req_destroy(struct ceph_osd_request *osd_req)
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 3f0474c55f05..6ecb920602ed 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1018,8 +1018,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 					&ci->i_layout, vino,
 					offset, &len, 0, num_ops,
 					CEPH_OSD_OP_WRITE,
-					CEPH_OSD_FLAG_WRITE |
-					CEPH_OSD_FLAG_ONDISK,
+					CEPH_OSD_FLAG_WRITE,
 					snapc, truncate_seq,
 					truncate_size, false);
 		if (IS_ERR(req)) {
@@ -1029,8 +1028,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 						min(num_ops,
 						    CEPH_OSD_SLAB_OPS),
 						CEPH_OSD_OP_WRITE,
-						CEPH_OSD_FLAG_WRITE |
-						CEPH_OSD_FLAG_ONDISK,
+						CEPH_OSD_FLAG_WRITE,
 						snapc, truncate_seq,
 						truncate_size, true);
 			BUG_ON(IS_ERR(req));
@@ -1680,8 +1678,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 
 	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
 				    ceph_vino(inode), 0, &len, 0, 1,
-				    CEPH_OSD_OP_CREATE,
-				    CEPH_OSD_FLAG_ONDISK | CEPH_OSD_FLAG_WRITE,
+				    CEPH_OSD_OP_CREATE, CEPH_OSD_FLAG_WRITE,
 				    NULL, 0, 0, false);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
@@ -1698,8 +1695,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 
 	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
 				    ceph_vino(inode), 0, &len, 1, 3,
-				    CEPH_OSD_OP_WRITE,
-				    CEPH_OSD_FLAG_ONDISK | CEPH_OSD_FLAG_WRITE,
+				    CEPH_OSD_OP_WRITE, CEPH_OSD_FLAG_WRITE,
 				    NULL, ci->i_truncate_seq,
 				    ci->i_truncate_size, false);
 	if (IS_ERR(req)) {
@@ -1872,7 +1868,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
 		goto out_unlock;
 	}
 
-	wr_req->r_flags = CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK;
+	wr_req->r_flags = CEPH_OSD_FLAG_WRITE;
 	osd_req_op_init(wr_req, 0, CEPH_OSD_OP_CREATE, CEPH_OSD_OP_FLAG_EXCL);
 	ceph_oloc_copy(&wr_req->r_base_oloc, &rd_req->r_base_oloc);
 	ceph_oid_copy(&wr_req->r_base_oid, &rd_req->r_base_oid);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index ae9f8999fc07..5a7134ef13d3 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -690,9 +690,7 @@ static void ceph_aio_retry_work(struct work_struct *work)
 		goto out;
 	}
 
-	req->r_flags =	CEPH_OSD_FLAG_ORDERSNAP |
-			CEPH_OSD_FLAG_ONDISK |
-			CEPH_OSD_FLAG_WRITE;
+	req->r_flags = CEPH_OSD_FLAG_ORDERSNAP | CEPH_OSD_FLAG_WRITE;
 	ceph_oloc_copy(&req->r_base_oloc, &orig_req->r_base_oloc);
 	ceph_oid_copy(&req->r_base_oid, &orig_req->r_base_oid);
 
@@ -764,9 +762,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 		if (ret2 < 0)
 			dout("invalidate_inode_pages2_range returned %d\n", ret2);
 
-		flags = CEPH_OSD_FLAG_ORDERSNAP |
-			CEPH_OSD_FLAG_ONDISK |
-			CEPH_OSD_FLAG_WRITE;
+		flags = CEPH_OSD_FLAG_ORDERSNAP | CEPH_OSD_FLAG_WRITE;
 	} else {
 		flags = CEPH_OSD_FLAG_READ;
 	}
@@ -965,9 +961,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 	if (ret < 0)
 		dout("invalidate_inode_pages2_range returned %d\n", ret);
 
-	flags = CEPH_OSD_FLAG_ORDERSNAP |
-		CEPH_OSD_FLAG_ONDISK |
-		CEPH_OSD_FLAG_WRITE;
+	flags = CEPH_OSD_FLAG_ORDERSNAP | CEPH_OSD_FLAG_WRITE;
 
 	while ((len = iov_iter_count(from)) > 0) {
 		size_t left;
@@ -1462,8 +1456,7 @@ static int ceph_zero_partial_object(struct inode *inode,
 					ceph_vino(inode),
 					offset, length,
 					0, 1, op,
-					CEPH_OSD_FLAG_WRITE |
-					CEPH_OSD_FLAG_ONDISK,
+					CEPH_OSD_FLAG_WRITE,
 					NULL, 0, 0, false);
 	if (IS_ERR(req)) {
 		ret = PTR_ERR(req);
diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
index f13a1ea87459..b9233b990399 100644
--- a/net/ceph/cls_lock_client.c
+++ b/net/ceph/cls_lock_client.c
@@ -69,8 +69,8 @@ int ceph_cls_lock(struct ceph_osd_client *osdc,
 	dout("%s lock_name %s type %d cookie %s tag %s desc %s flags 0x%x\n",
 	     __func__, lock_name, type, cookie, tag, desc, flags);
 	ret = ceph_osdc_call(osdc, oid, oloc, "lock", "lock",
-			     CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
-			     lock_op_page, lock_op_buf_size, NULL, NULL);
+			     CEPH_OSD_FLAG_WRITE, lock_op_page,
+			     lock_op_buf_size, NULL, NULL);
 
 	dout("%s: status %d\n", __func__, ret);
 	__free_page(lock_op_page);
@@ -117,8 +117,8 @@ int ceph_cls_unlock(struct ceph_osd_client *osdc,
 
 	dout("%s lock_name %s cookie %s\n", __func__, lock_name, cookie);
 	ret = ceph_osdc_call(osdc, oid, oloc, "lock", "unlock",
-			     CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
-			     unlock_op_page, unlock_op_buf_size, NULL, NULL);
+			     CEPH_OSD_FLAG_WRITE, unlock_op_page,
+			     unlock_op_buf_size, NULL, NULL);
 
 	dout("%s: status %d\n", __func__, ret);
 	__free_page(unlock_op_page);
@@ -170,8 +170,8 @@ int ceph_cls_break_lock(struct ceph_osd_client *osdc,
 	dout("%s lock_name %s cookie %s locker %s%llu\n", __func__, lock_name,
 	     cookie, ENTITY_NAME(*locker));
 	ret = ceph_osdc_call(osdc, oid, oloc, "lock", "break_lock",
-			     CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
-			     break_op_page, break_op_buf_size, NULL, NULL);
+			     CEPH_OSD_FLAG_WRITE, break_op_page,
+			     break_op_buf_size, NULL, NULL);
 
 	dout("%s: status %d\n", __func__, ret);
 	__free_page(break_op_page);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index e1c6c2b4a295..5c0938ddddf6 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1704,7 +1704,7 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
 
 static void account_request(struct ceph_osd_request *req)
 {
-	WARN_ON(req->r_flags & CEPH_OSD_FLAG_ACK);
+	WARN_ON(req->r_flags & (CEPH_OSD_FLAG_ACK | CEPH_OSD_FLAG_ONDISK));
 	WARN_ON(!(req->r_flags & (CEPH_OSD_FLAG_READ | CEPH_OSD_FLAG_WRITE)));
 
 	req->r_flags |= CEPH_OSD_FLAG_ONDISK;
@@ -3539,7 +3539,7 @@ ceph_osdc_watch(struct ceph_osd_client *osdc,
 
 	ceph_oid_copy(&lreq->t.base_oid, oid);
 	ceph_oloc_copy(&lreq->t.base_oloc, oloc);
-	lreq->t.flags = CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK;
+	lreq->t.flags = CEPH_OSD_FLAG_WRITE;
 	lreq->mtime = CURRENT_TIME;
 
 	lreq->reg_req = alloc_linger_request(lreq);
@@ -3597,7 +3597,7 @@ int ceph_osdc_unwatch(struct ceph_osd_client *osdc,
 
 	ceph_oid_copy(&req->r_base_oid, &lreq->t.base_oid);
 	ceph_oloc_copy(&req->r_base_oloc, &lreq->t.base_oloc);
-	req->r_flags = CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK;
+	req->r_flags = CEPH_OSD_FLAG_WRITE;
 	req->r_mtime = CURRENT_TIME;
 	osd_req_op_watch_init(req, 0, lreq->linger_id,
 			      CEPH_OSD_WATCH_OP_UNWATCH);
@@ -4163,8 +4163,7 @@ int ceph_osdc_writepages(struct ceph_osd_client *osdc, struct ceph_vino vino,
 	int page_align = off & ~PAGE_MASK;
 
 	req = ceph_osdc_new_request(osdc, layout, vino, off, &len, 0, 1,
-				    CEPH_OSD_OP_WRITE,
-				    CEPH_OSD_FLAG_ONDISK | CEPH_OSD_FLAG_WRITE,
+				    CEPH_OSD_OP_WRITE, CEPH_OSD_FLAG_WRITE,
 				    snapc, truncate_seq, truncate_size,
 				    true);
 	if (IS_ERR(req))
-- 
2.4.3

