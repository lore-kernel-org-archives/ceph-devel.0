From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 1/4] rbd: pass num_op with ops array
Date: Fri, 04 Jan 2013 08:45:05 -0600
Message-ID: <50E6EAF1.7020203@inktank.com>
References: <50E6EA94.1040001@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f181.google.com ([209.85.210.181]:32980 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754746Ab3ADOpH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 09:45:07 -0500
Received: by mail-ia0-f181.google.com with SMTP id s32so13567585iak.40
        for <ceph-devel@vger.kernel.org>; Fri, 04 Jan 2013 06:45:07 -0800 (PST)
In-Reply-To: <50E6EA94.1040001@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Add a num_op parameter to rbd_do_request() and rbd_req_sync_op() to
indicate the number of entries in the array.  The callers of these
functions always know how many entries are in the array, so just
pass that information down.

This is in anticipation of eliminating the extra zero-filled entry
in these ops arrays.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 6b9643a..cee1334 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1119,6 +1119,7 @@ static int rbd_do_request(struct request *rq,
 			  struct page **pages,
 			  int num_pages,
 			  int flags,
+			  unsigned int num_op,
 			  struct ceph_osd_req_op *ops,
 			  struct rbd_req_coll *coll,
 			  int coll_index,
@@ -1259,6 +1260,7 @@ static void rbd_simple_req_cb(struct
ceph_osd_request *osd_req,
  */
 static int rbd_req_sync_op(struct rbd_device *rbd_dev,
 			   int flags,
+			   unsigned int num_op,
 			   struct ceph_osd_req_op *ops,
 			   const char *object_name,
 			   u64 ofs, u64 inbound_size,
@@ -1281,7 +1283,7 @@ static int rbd_req_sync_op(struct rbd_device *rbd_dev,
 			  object_name, ofs, inbound_size, NULL,
 			  pages, num_pages,
 			  flags,
-			  ops,
+			  num_op, ops,
 			  NULL, 0,
 			  NULL,
 			  linger_req, ver);
@@ -1351,7 +1353,7 @@ static int rbd_do_op(struct request *rq,
 			     bio,
 			     NULL, 0,
 			     flags,
-			     ops,
+			     1, ops,
 			     coll, coll_index,
 			     rbd_req_cb, 0, NULL);
 	if (ret < 0)
@@ -1380,7 +1382,7 @@ static int rbd_req_sync_read(struct rbd_device
*rbd_dev,
 		return -ENOMEM;

 	ret = rbd_req_sync_op(rbd_dev, CEPH_OSD_FLAG_READ,
-			       ops, object_name, ofs, len, buf, NULL, ver);
+			       1, ops, object_name, ofs, len, buf, NULL, ver);
 	rbd_destroy_ops(ops);

 	return ret;
@@ -1408,7 +1410,7 @@ static int rbd_req_sync_notify_ack(struct
rbd_device *rbd_dev,
 			  rbd_dev->header_name, 0, 0, NULL,
 			  NULL, 0,
 			  CEPH_OSD_FLAG_READ,
-			  ops,
+			  1, ops,
 			  NULL, 0,
 			  rbd_simple_req_cb, 0, NULL);

@@ -1460,7 +1462,7 @@ static int rbd_req_sync_watch(struct rbd_device
*rbd_dev)

 	ret = rbd_req_sync_op(rbd_dev,
 			      CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
-			      ops,
+			      1, ops,
 			      rbd_dev->header_name,
 			      0, 0, NULL,
 			      &rbd_dev->watch_request, NULL);
@@ -1497,7 +1499,7 @@ static int rbd_req_sync_unwatch(struct rbd_device
*rbd_dev)

 	ret = rbd_req_sync_op(rbd_dev,
 			      CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
-			      ops,
+			      1, ops,
 			      rbd_dev->header_name,
 			      0, 0, NULL, NULL, NULL);

@@ -1548,7 +1550,7 @@ static int rbd_req_sync_exec(struct rbd_device
*rbd_dev,
 	ops[0].cls.indata = outbound;
 	ops[0].cls.indata_len = outbound_size;

-	ret = rbd_req_sync_op(rbd_dev, CEPH_OSD_FLAG_READ, ops,
+	ret = rbd_req_sync_op(rbd_dev, CEPH_OSD_FLAG_READ, 1, ops,
 			       object_name, 0, inbound_size, inbound,
 			       NULL, ver);

-- 
1.7.9.5

