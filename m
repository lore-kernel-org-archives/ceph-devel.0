From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: make pool_id a 64 bit value
Date: Fri, 26 Oct 2012 17:45:26 -0500
Message-ID: <508B1286.4010906@inktank.com>
References: <508B11E3.3040108@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54205 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932188Ab2JZWph (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 18:45:37 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so4471797iea.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 15:45:36 -0700 (PDT)
In-Reply-To: <508B11E3.3040108@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

If a format 2 image has a parent, its pool id will be specified
using a 64-bit value.  Change the pool id we save for an image to
match that.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 147c8df..2a523a1 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -197,7 +197,7 @@ struct rbd_device {
 	size_t			image_name_len;
 	char			*header_name;
 	char			*pool_name;
-	int			pool_id;
+	u64			pool_id;

 	struct ceph_osd_event   *watch_event;
 	struct ceph_osd_request *watch_request;
@@ -1113,7 +1113,7 @@ static int rbd_do_request(struct request *rq,
 	layout->fl_stripe_unit = cpu_to_le32(1 << RBD_MAX_OBJ_ORDER);
 	layout->fl_stripe_count = cpu_to_le32(1);
 	layout->fl_object_size = cpu_to_le32(1 << RBD_MAX_OBJ_ORDER);
-	layout->fl_pg_pool = cpu_to_le32(rbd_dev->pool_id);
+	layout->fl_pg_pool = cpu_to_le32((int) rbd_dev->pool_id);
 	ret = ceph_calc_raw_layout(osdc, layout, snapid, ofs, &len, &bno,
 				   req, ops);
 	rbd_assert(ret == 0);
@@ -1982,7 +1982,7 @@ static ssize_t rbd_pool_id_show(struct device *dev,
 {
 	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);

-	return sprintf(buf, "%d\n", rbd_dev->pool_id);
+	return sprintf(buf, "%llu\n", (unsigned long long) rbd_dev->pool_id);
 }

 static ssize_t rbd_name_show(struct device *dev,
@@ -3170,7 +3170,7 @@ static ssize_t rbd_add(struct bus_type *bus,
 	rc = ceph_pg_poolid_by_name(osdc->osdmap, rbd_dev->pool_name);
 	if (rc < 0)
 		goto err_out_client;
-	rbd_dev->pool_id = rc;
+	rbd_dev->pool_id = (u64) rc;

 	rc = rbd_dev_probe(rbd_dev);
 	if (rc < 0)
-- 
1.7.9.5

