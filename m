From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 5/6] libceph: calculate request message size according to namespace
Date: Fri,  5 Feb 2016 22:31:36 +0800
Message-ID: <1454682697-84638-6-git-send-email-zyan@redhat.com>
References: <1454682697-84638-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45659 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853AbcBEOcS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 5 Feb 2016 09:32:18 -0500
In-Reply-To: <1454682697-84638-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sweil@redhat.com, idryomov@gmail.com, "Yan, Zheng" <zyan@redhat.com>

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 drivers/block/rbd.c             |  4 ++--
 fs/ceph/addr.c                  |  4 ++--
 fs/ceph/file.c                  |  5 +++--
 include/linux/ceph/osd_client.h |  2 ++
 include/linux/ceph/osdmap.h     |  1 -
 net/ceph/osd_client.c           | 20 +++++++++++++-------
 6 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 13be37a..8a3cd133 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1954,7 +1954,7 @@ static struct ceph_osd_request *rbd_osd_req_create(
 	/* Allocate and initialize the request, for the num_ops ops */
 
 	osdc = &rbd_dev->rbd_client->client->osdc;
-	osd_req = ceph_osdc_alloc_request(osdc, snapc, num_ops, false,
+	osd_req = ceph_osdc_alloc_request(osdc, snapc, NULL, num_ops, false,
 					  GFP_ATOMIC);
 	if (!osd_req)
 		return NULL;	/* ENOMEM */
@@ -2003,7 +2003,7 @@ rbd_osd_req_create_copyup(struct rbd_obj_request *obj_request)
 	snapc = img_request->snapc;
 	rbd_dev = img_request->rbd_dev;
 	osdc = &rbd_dev->rbd_client->client->osdc;
-	osd_req = ceph_osdc_alloc_request(osdc, snapc, num_osd_ops,
+	osd_req = ceph_osdc_alloc_request(osdc, snapc, NULL, num_osd_ops,
 						false, GFP_ATOMIC);
 	if (!osd_req)
 		return NULL;	/* ENOMEM */
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 6047395..d5ea244 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1750,7 +1750,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci, s64 pool)
 	}
 
 	rd_req = ceph_osdc_alloc_request(&fsc->client->osdc,
-					 ceph_empty_snapc,
+					 ceph_empty_snapc, NULL,
 					 1, false, GFP_NOFS);
 	if (!rd_req) {
 		err = -ENOMEM;
@@ -1765,7 +1765,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci, s64 pool)
 	rd_req->r_base_oid.name_len = strlen(rd_req->r_base_oid.name);
 
 	wr_req = ceph_osdc_alloc_request(&fsc->client->osdc,
-					 ceph_empty_snapc,
+					 ceph_empty_snapc, NULL,
 					 1, false, GFP_NOFS);
 	if (!wr_req) {
 		err = -ENOMEM;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index dc6dc5b..a5565f7 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -696,8 +696,9 @@ static void ceph_aio_retry_work(struct work_struct *work)
 	}
 	spin_unlock(&ci->i_ceph_lock);
 
-	req = ceph_osdc_alloc_request(orig_req->r_osdc, snapc, 2,
-			false, GFP_NOFS);
+	req = ceph_osdc_alloc_request(orig_req->r_osdc, snapc,
+				      orig_req->r_base_oloc.pool_ns,
+				      2, false, GFP_NOFS);
 	if (!req) {
 		ret = -ENOMEM;
 		req = orig_req;
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 4df2fc5..be14161 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -14,6 +14,7 @@
 
 struct ceph_msg;
 struct ceph_snap_context;
+struct ceph_pool_ns;
 struct ceph_osd_request;
 struct ceph_osd_client;
 struct ceph_authorizer;
@@ -321,6 +322,7 @@ extern void osd_req_op_alloc_hint_init(struct ceph_osd_request *osd_req,
 
 extern struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 					       struct ceph_snap_context *snapc,
+					       struct ceph_pool_ns *pool_ns,
 					       unsigned int num_ops,
 					       bool use_mempool,
 					       gfp_t gfp_flags);
diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index b2e3649..9f92c35 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -64,7 +64,6 @@ struct ceph_object_locator {
  * (probably outdated: must be >= RBD_MAX_MD_NAME_LEN -- currently 100)
  */
 #define CEPH_MAX_OID_NAME_LEN 100
-#define CEPH_MAX_NAMESPACE_LEN 100
 
 struct ceph_object_id {
 	char name[CEPH_MAX_OID_NAME_LEN];
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 1d13605..fb5403a 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -366,6 +366,7 @@ EXPORT_SYMBOL(ceph_osdc_put_request);
 
 struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 					       struct ceph_snap_context *snapc,
+					       struct ceph_pool_ns *pool_ns,
 					       unsigned int num_ops,
 					       bool use_mempool,
 					       gfp_t gfp_flags)
@@ -436,7 +437,8 @@ struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 
 	/* create request message; allow space for oid */
 	msg_size = 4 + 4 + 8 + 8 + 4 + 8;
-	msg_size += 2 + 4 + 8 + 4 + 4 + 4 + CEPH_MAX_NAMESPACE_LEN; /* oloc */
+	msg_size += 2 + 4 + 8 + 4 + 4 + 4 +
+		    (pool_ns ? pool_ns->name_len : 0); /* oloc */
 	msg_size += 1 + 8 + 4 + 4;     /* pg_t */
 	msg_size += 4 + CEPH_MAX_OID_NAME_LEN; /* oid */
 	msg_size += 2 + num_ops * sizeof(struct ceph_osd_op);
@@ -825,6 +827,7 @@ struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *osdc,
 					       bool use_mempool)
 {
 	struct ceph_osd_request *req;
+	struct ceph_pool_ns *pool_ns;
 	u64 objnum = 0;
 	u64 objoff = 0;
 	u64 objlen = 0;
@@ -834,12 +837,18 @@ struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *osdc,
 	       opcode != CEPH_OSD_OP_ZERO && opcode != CEPH_OSD_OP_TRUNCATE &&
 	       opcode != CEPH_OSD_OP_CREATE && opcode != CEPH_OSD_OP_DELETE);
 
-	req = ceph_osdc_alloc_request(osdc, snapc, num_ops, use_mempool,
-					GFP_NOFS);
-	if (!req)
+	pool_ns = ceph_try_get_pool_ns(&layout->pool_ns);
+
+	req = ceph_osdc_alloc_request(osdc, snapc, pool_ns, num_ops,
+				      use_mempool, GFP_NOFS);
+	if (!req) {
+		ceph_put_pool_ns(pool_ns);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	req->r_flags = flags;
+	req->r_base_oloc.pool = layout->pool_id;
+	req->r_base_oloc.pool_ns = pool_ns;
 
 	/* calculate max write size */
 	r = calc_layout(layout, off, plen, &objnum, &objoff, &objlen);
@@ -866,9 +875,6 @@ struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *osdc,
 				       truncate_size, truncate_seq);
 	}
 
-	req->r_base_oloc.pool = layout->pool_id;
-	req->r_base_oloc.pool_ns = ceph_try_get_pool_ns(&layout->pool_ns);
-
 	snprintf(req->r_base_oid.name, sizeof(req->r_base_oid.name),
 		 "%llx.%08llx", vino.ino, objnum);
 	req->r_base_oid.name_len = strlen(req->r_base_oid.name);
-- 
2.5.0

