From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 01/11] libceph: start using oloc abstraction
Date: Mon, 27 Jan 2014 17:58:43 +0200
Message-ID: <1390838333-32266-2-git-send-email-ilya.dryomov@inktank.com>
References: <1390838333-32266-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:58845 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937AbaA0P74 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jan 2014 10:59:56 -0500
Received: by mail-la0-f45.google.com with SMTP id b8so4695064lan.32
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jan 2014 07:59:55 -0800 (PST)
In-Reply-To: <1390838333-32266-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

Instead of relying on pool fields in ceph_file_layout (for mapping) and
ceph_pg (for enconding), start using ceph_object_locator (oloc)
abstraction.  Note that userspace oloc currently consists of pool, key,
nspace and hash fields, while this one contains only a pool.  This is
OK, because at this point we only send (i.e. encode) olocs and never
have to receive (i.e. decode) them.

This makes keeping a copy of ceph_file_layout in every osd request
unnecessary, so ceph_osd_request::r_file_layout field is nuked.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c             |    8 ++++----
 include/linux/ceph/osd_client.h |    3 ++-
 include/linux/ceph/osdmap.h     |    3 +--
 net/ceph/osd_client.c           |    8 +++++---
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 72a7eec456a9..6614e8d95525 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1808,12 +1808,12 @@ static struct ceph_osd_request *rbd_osd_req_create(
 	osd_req->r_callback = rbd_osd_req_callback;
 	osd_req->r_priv = obj_request;
 
+	osd_req->r_oloc.pool = ceph_file_layout_pg_pool(rbd_dev->layout);
+
 	osd_req->r_oid_len = strlen(obj_request->object_name);
 	rbd_assert(osd_req->r_oid_len < sizeof (osd_req->r_oid));
 	memcpy(osd_req->r_oid, obj_request->object_name, osd_req->r_oid_len);
 
-	osd_req->r_file_layout = rbd_dev->layout;	/* struct */
-
 	return osd_req;
 }
 
@@ -1849,12 +1849,12 @@ rbd_osd_req_create_copyup(struct rbd_obj_request *obj_request)
 	osd_req->r_callback = rbd_osd_req_callback;
 	osd_req->r_priv = obj_request;
 
+	osd_req->r_oloc.pool = ceph_file_layout_pg_pool(rbd_dev->layout);
+
 	osd_req->r_oid_len = strlen(obj_request->object_name);
 	rbd_assert(osd_req->r_oid_len < sizeof (osd_req->r_oid));
 	memcpy(osd_req->r_oid, obj_request->object_name, osd_req->r_oid_len);
 
-	osd_req->r_file_layout = rbd_dev->layout;	/* struct */
-
 	return osd_req;
 }
 
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 4fb6a8938957..5b8555109789 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -159,12 +159,13 @@ struct ceph_osd_request {
 	struct inode *r_inode;         	      /* for use by callbacks */
 	void *r_priv;			      /* ditto */
 
+	struct ceph_object_locator r_oloc;
+
 	char              r_oid[MAX_OBJ_NAME_SIZE];          /* object name */
 	int               r_oid_len;
 	u64               r_snapid;
 	unsigned long     r_stamp;            /* send OR check time */
 
-	struct ceph_file_layout r_file_layout;
 	struct ceph_snap_context *r_snapc;    /* snap context for writes */
 };
 
diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index d05cc4451af6..256134af4ad4 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -40,8 +40,7 @@ struct ceph_pg_pool_info {
 };
 
 struct ceph_object_locator {
-	uint64_t pool;
-	char *key;
+	s64 pool;
 };
 
 struct ceph_pg_mapping {
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 959d332ed534..7130c5c83d79 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -368,6 +368,8 @@ struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 	INIT_LIST_HEAD(&req->r_req_lru_item);
 	INIT_LIST_HEAD(&req->r_osd_item);
 
+	req->r_oloc.pool = -1;
+
 	/* create reply message */
 	if (use_mempool)
 		msg = ceph_msgpool_get(&osdc->msgpool_op_reply, 0);
@@ -761,7 +763,7 @@ struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *osdc,
 	if (num_ops > 1)
 		osd_req_op_init(req, 1, CEPH_OSD_OP_STARTSYNC);
 
-	req->r_file_layout = *layout;  /* keep a copy */
+	req->r_oloc.pool = ceph_file_layout_pg_pool(*layout);
 
 	snprintf(req->r_oid, sizeof(req->r_oid), "%llx.%08llx",
 		vino.ino, objnum);
@@ -1268,7 +1270,7 @@ static int __map_request(struct ceph_osd_client *osdc,
 
 	dout("map_request %p tid %lld\n", req, req->r_tid);
 	err = ceph_calc_ceph_pg(&pgid, req->r_oid, osdc->osdmap,
-				ceph_file_layout_pg_pool(req->r_file_layout));
+				req->r_oloc.pool);
 	if (err) {
 		list_move(&req->r_req_lru_item, &osdc->req_notarget);
 		return err;
@@ -1354,7 +1356,7 @@ static void __send_request(struct ceph_osd_client *osdc,
 	/* fill in message content that changes each time we send it */
 	put_unaligned_le32(osdc->osdmap->epoch, req->r_request_osdmap_epoch);
 	put_unaligned_le32(req->r_flags, req->r_request_flags);
-	put_unaligned_le64(req->r_pgid.pool, req->r_request_pool);
+	put_unaligned_le64(req->r_oloc.pool, req->r_request_pool);
 	p = req->r_request_pgid;
 	ceph_encode_64(&p, req->r_pgid.pool);
 	ceph_encode_32(&p, req->r_pgid.seed);
-- 
1.7.10.4

