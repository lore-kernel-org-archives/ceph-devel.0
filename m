From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4/4] libceph: enable large, variable-sized OSD requests
Date: Wed, 10 Feb 2016 12:24:07 +0100
Message-ID: <1455103447-23559-5-git-send-email-idryomov@gmail.com>
References: <1455103447-23559-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35289 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754618AbcBJLYo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Feb 2016 06:24:44 -0500
Received: by mail-wm0-f68.google.com with SMTP id g62so3532462wme.2
        for <ceph-devel@vger.kernel.org>; Wed, 10 Feb 2016 03:24:43 -0800 (PST)
In-Reply-To: <1455103447-23559-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Zheng Yan <zyan@redhat.com>

Turn r_ops into a flexible array member to enable large, consisting of
up to 16 ops, OSD requests.  The use case is scattered writeback in
cephfs and, as far as the kernel client is concerned, 16 is just a made
up number.

r_ops had size 3 for copyup+hint+write, but copyup is really a special
case - it can only happen once.  ceph_osd_request_cache is therefore
stuffed with num_ops=2 requests, anything bigger than that is allocated
with kmalloc().  req_mempool is backed by ceph_osd_request_cache, which
means either num_ops=1 or num_ops=2 for use_mempool=true - all existing
users (ceph_writepages_start(), ceph_osdc_writepages()) are fine with
that.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c             |  2 --
 include/linux/ceph/osd_client.h |  6 ++++--
 net/ceph/osd_client.c           | 32 +++++++++++++++++++-------------
 3 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 94f31bde73e8..08018710f363 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1847,8 +1847,6 @@ static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
 	if (osd_req->r_result < 0)
 		obj_request->result = osd_req->r_result;
 
-	rbd_assert(osd_req->r_num_ops <= CEPH_OSD_MAX_OP);
-
 	/*
 	 * We support a 64-bit length, but ultimately it has to be
 	 * passed to the block layer, which just supports a 32-bit
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index c6d1d603bacf..aada6a1383a4 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -43,7 +43,8 @@ struct ceph_osd {
 };
 
 
-#define CEPH_OSD_MAX_OP	3
+#define CEPH_OSD_SLAB_OPS	2
+#define CEPH_OSD_MAX_OPS	16
 
 enum ceph_osd_data_type {
 	CEPH_OSD_DATA_TYPE_NONE = 0,
@@ -139,7 +140,6 @@ struct ceph_osd_request {
 
 	/* request osd ops array  */
 	unsigned int		r_num_ops;
-	struct ceph_osd_req_op	r_ops[CEPH_OSD_MAX_OP];
 
 	/* these are updated on each send */
 	__le32           *r_request_osdmap_epoch;
@@ -175,6 +175,8 @@ struct ceph_osd_request {
 	unsigned long     r_stamp;            /* send OR check time */
 
 	struct ceph_snap_context *r_snapc;    /* snap context for writes */
+
+	struct ceph_osd_req_op r_ops[];
 };
 
 struct ceph_request_redirect {
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 8bf4f74064e5..37a0fc5273d1 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -338,9 +338,10 @@ static void ceph_osdc_release_request(struct kref *kref)
 	ceph_put_snap_context(req->r_snapc);
 	if (req->r_mempool)
 		mempool_free(req, req->r_osdc->req_mempool);
-	else
+	else if (req->r_num_ops <= CEPH_OSD_SLAB_OPS)
 		kmem_cache_free(ceph_osd_request_cache, req);
-
+	else
+		kfree(req);
 }
 
 void ceph_osdc_get_request(struct ceph_osd_request *req)
@@ -369,9 +370,6 @@ struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 	struct ceph_msg *msg;
 	size_t msg_size;
 
-	BUILD_BUG_ON(CEPH_OSD_MAX_OP > U16_MAX);
-	BUG_ON(num_ops > CEPH_OSD_MAX_OP);
-
 	msg_size = 4 + 4 + 8 + 8 + 4+8;
 	msg_size += 2 + 4 + 8 + 4 + 4; /* oloc */
 	msg_size += 1 + 8 + 4 + 4;     /* pg_t */
@@ -383,14 +381,21 @@ struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 	msg_size += 4;
 
 	if (use_mempool) {
+		BUG_ON(num_ops > CEPH_OSD_SLAB_OPS);
 		req = mempool_alloc(osdc->req_mempool, gfp_flags);
-		memset(req, 0, sizeof(*req));
+	} else if (num_ops <= CEPH_OSD_SLAB_OPS) {
+		req = kmem_cache_alloc(ceph_osd_request_cache, gfp_flags);
 	} else {
-		req = kmem_cache_zalloc(ceph_osd_request_cache, gfp_flags);
+		BUG_ON(num_ops > CEPH_OSD_MAX_OPS);
+		req = kmalloc(sizeof(*req) + num_ops * sizeof(req->r_ops[0]),
+			      gfp_flags);
 	}
-	if (req == NULL)
+	if (unlikely(!req))
 		return NULL;
 
+	/* req only, each op is zeroed in _osd_req_op_init() */
+	memset(req, 0, sizeof(*req));
+
 	req->r_osdc = osdc;
 	req->r_mempool = use_mempool;
 	req->r_num_ops = num_ops;
@@ -1809,7 +1814,7 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 
 	ceph_decode_need(&p, end, 4, bad_put);
 	numops = ceph_decode_32(&p);
-	if (numops > CEPH_OSD_MAX_OP)
+	if (numops > CEPH_OSD_MAX_OPS)
 		goto bad_put;
 	if (numops != req->r_num_ops)
 		goto bad_put;
@@ -2773,11 +2778,12 @@ EXPORT_SYMBOL(ceph_osdc_writepages);
 
 int ceph_osdc_setup(void)
 {
+	size_t size = sizeof(struct ceph_osd_request) +
+	    CEPH_OSD_SLAB_OPS * sizeof(struct ceph_osd_req_op);
+
 	BUG_ON(ceph_osd_request_cache);
-	ceph_osd_request_cache = kmem_cache_create("ceph_osd_request",
-					sizeof (struct ceph_osd_request),
-					__alignof__(struct ceph_osd_request),
-					0, NULL);
+	ceph_osd_request_cache = kmem_cache_create("ceph_osd_request", size,
+						   0, 0, NULL);
 
 	return ceph_osd_request_cache ? 0 : -ENOMEM;
 }
-- 
2.4.3

