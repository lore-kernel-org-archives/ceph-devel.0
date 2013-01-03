From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 4/5] rbd: kill rbd_req_sync_op() snapc and snapid parameters
Date: Thu, 03 Jan 2013 17:19:32 -0600
Message-ID: <50E61204.6040905@inktank.com>
References: <50E61175.7010103@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:57542 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852Ab3ACXTg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 18:19:36 -0500
Received: by mail-ia0-f182.google.com with SMTP id x2so13192519iad.41
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jan 2013 15:19:34 -0800 (PST)
In-Reply-To: <50E61175.7010103@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The snapc and snapid parameters to rbd_req_sync_op() always take
the values NULL and CEPH_NOSNAP, respectively.  So just get rid
of them and use those values where needed.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 126d5c0..821d93c 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1257,8 +1257,6 @@ static void rbd_simple_req_cb(struct
ceph_osd_request *osd_req,
  * Do a synchronous ceph osd operation
  */
 static int rbd_req_sync_op(struct rbd_device *rbd_dev,
-			   struct ceph_snap_context *snapc,
-			   u64 snapid,
 			   int flags,
 			   struct ceph_osd_req_op *ops,
 			   const char *object_name,
@@ -1278,7 +1276,7 @@ static int rbd_req_sync_op(struct rbd_device *rbd_dev,
 	if (IS_ERR(pages))
 		return PTR_ERR(pages);

-	ret = rbd_do_request(NULL, rbd_dev, snapc, snapid,
+	ret = rbd_do_request(NULL, rbd_dev, NULL, CEPH_NOSNAP,
 			  object_name, ofs, inbound_size, NULL,
 			  pages, num_pages,
 			  flags,
@@ -1380,9 +1378,7 @@ static int rbd_req_sync_read(struct rbd_device
*rbd_dev,
 	if (!ops)
 		return -ENOMEM;

-	ret = rbd_req_sync_op(rbd_dev, NULL,
-			       CEPH_NOSNAP,
-			       CEPH_OSD_FLAG_READ,
+	ret = rbd_req_sync_op(rbd_dev, CEPH_OSD_FLAG_READ,
 			       ops, object_name, ofs, len, buf, NULL, ver);
 	rbd_destroy_ops(ops);

@@ -1461,8 +1457,7 @@ static int rbd_req_sync_watch(struct rbd_device
*rbd_dev)
 	ops[0].watch.cookie = cpu_to_le64(rbd_dev->watch_event->cookie);
 	ops[0].watch.flag = 1;

-	ret = rbd_req_sync_op(rbd_dev, NULL,
-			      CEPH_NOSNAP,
+	ret = rbd_req_sync_op(rbd_dev,
 			      CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
 			      ops,
 			      rbd_dev->header_name,
@@ -1499,8 +1494,7 @@ static int rbd_req_sync_unwatch(struct rbd_device
*rbd_dev)
 	ops[0].watch.cookie = cpu_to_le64(rbd_dev->watch_event->cookie);
 	ops[0].watch.flag = 0;

-	ret = rbd_req_sync_op(rbd_dev, NULL,
-			      CEPH_NOSNAP,
+	ret = rbd_req_sync_op(rbd_dev,
 			      CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
 			      ops,
 			      rbd_dev->header_name,
@@ -1553,8 +1547,7 @@ static int rbd_req_sync_exec(struct rbd_device
*rbd_dev,
 	ops[0].cls.indata = outbound;
 	ops[0].cls.indata_len = outbound_size;

-	ret = rbd_req_sync_op(rbd_dev, NULL,
-			       CEPH_NOSNAP, CEPH_OSD_FLAG_READ, ops,
+	ret = rbd_req_sync_op(rbd_dev, CEPH_OSD_FLAG_READ, ops,
 			       object_name, 0, inbound_size, inbound,
 			       NULL, ver);

-- 
1.7.9.5

