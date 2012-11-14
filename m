From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/4] rbd: use a common layout for each device
Date: Wed, 14 Nov 2012 12:34:25 -0600
Message-ID: <50A3E431.7040602@inktank.com>
References: <50A3E373.4090006@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:53762 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423146Ab2KNSe1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Nov 2012 13:34:27 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so1024826iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Nov 2012 10:34:27 -0800 (PST)
In-Reply-To: <50A3E373.4090006@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Each osd message includes a layout structure, and for rbd it is
always the same (at least for osd's in a given pool).

Initialize a layout structure when an rbd_dev gets created and just
copy that into osd requests for the rbd image.

Replace an assertion that was done when initializing the layout
structures with code that catches and handles anything that would
trigger the assertion as soon as it is identified.  This precludes
that (bad) condition from ever occurring.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 30a73ae..fba0822 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -235,6 +235,8 @@ struct rbd_device {

 	char			*header_name;

+	struct ceph_file_layout	layout;
+
 	struct ceph_osd_event   *watch_event;
 	struct ceph_osd_request *watch_request;

@@ -1093,16 +1095,6 @@ static void rbd_coll_end_req(struct rbd_request
*rbd_req,
 				ret, len);
 }

-static void rbd_layout_init(struct ceph_file_layout *layout, u64 pool_id)
-{
-	memset(layout, 0, sizeof (*layout));
-	layout->fl_stripe_unit = cpu_to_le32(1 << RBD_MAX_OBJ_ORDER);
-	layout->fl_stripe_count = cpu_to_le32(1);
-	layout->fl_object_size = cpu_to_le32(1 << RBD_MAX_OBJ_ORDER);
-	rbd_assert(pool_id <= (u64) U32_MAX);
-	layout->fl_pg_pool = cpu_to_le32((u32) pool_id);
-}
-
 /*
  * Send ceph osd request
  */
@@ -1167,7 +1159,7 @@ static int rbd_do_request(struct request *rq,
 	strncpy(osd_req->r_oid, object_name, sizeof(osd_req->r_oid));
 	osd_req->r_oid_len = strlen(osd_req->r_oid);

-	rbd_layout_init(&osd_req->r_file_layout, rbd_dev->spec->pool_id);
+	osd_req->r_file_layout = rbd_dev->layout;	/* struct */

 	if (op->op == CEPH_OSD_OP_READ || op->op == CEPH_OSD_OP_WRITE) {
 		op->extent.offset = ofs;
@@ -2266,6 +2258,13 @@ struct rbd_device *rbd_dev_create(struct
rbd_client *rbdc,
 	rbd_dev->spec = spec;
 	rbd_dev->rbd_client = rbdc;

+	/* Initialize the layout used for all rbd requests */
+
+	rbd_dev->layout.fl_stripe_unit = cpu_to_le32(1 << RBD_MAX_OBJ_ORDER);
+	rbd_dev->layout.fl_stripe_count = cpu_to_le32(1);
+	rbd_dev->layout.fl_object_size = cpu_to_le32(1 << RBD_MAX_OBJ_ORDER);
+	rbd_dev->layout.fl_pg_pool = cpu_to_le32((u32) spec->pool_id);
+
 	return rbd_dev;
 }

@@ -2520,6 +2519,12 @@ static int rbd_dev_v2_parent_info(struct
rbd_device *rbd_dev)
 	if (parent_spec->pool_id == CEPH_NOPOOL)
 		goto out;	/* No parent?  No problem. */

+	/* The ceph file layout needs to fit pool id in 32 bits */
+
+	ret = -EIO;
+	if (WARN_ON(parent_spec->pool_id > (u64) U32_MAX))
+		goto out;
+
 	image_id = ceph_extract_encoded_string(&p, end, NULL, GFP_KERNEL);
 	if (IS_ERR(image_id)) {
 		ret = PTR_ERR(image_id);
@@ -3648,6 +3653,13 @@ static ssize_t rbd_add(struct bus_type *bus,
 	if (spec->pool_id == CEPH_NOPOOL)
 		goto err_out_client;

+	/* The ceph file layout needs to fit pool id in 32 bits */
+
+	if (WARN_ON(spec->pool_id > (u64) U32_MAX)) {
+		rc = -EIO;
+		goto err_out_client;
+	}
+
 	rbd_dev = rbd_dev_create(rbdc, spec);
 	if (!rbd_dev)
 		goto err_out_client;
-- 
1.7.9.5

