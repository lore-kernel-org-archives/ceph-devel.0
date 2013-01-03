From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 2/5] rbd: drop snapid parameter from rbd_req_sync_read()
Date: Thu, 03 Jan 2013 17:18:51 -0600
Message-ID: <50E611DB.3060100@inktank.com>
References: <50E61175.7010103@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f170.google.com ([209.85.210.170]:43394 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852Ab3ACXSx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 18:18:53 -0500
Received: by mail-ia0-f170.google.com with SMTP id i1so13575388iaa.29
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jan 2013 15:18:53 -0800 (PST)
In-Reply-To: <50E61175.7010103@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

There is only one caller of rbd_req_sync_read(), and it passes
CEPH_NOSNAP as the snapshot id argument.  Delete that parameter
and just use CEPH_NOSNAP within the function.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 5bca129..b86289f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1368,7 +1368,6 @@ done:
  * Request sync osd read
  */
 static int rbd_req_sync_read(struct rbd_device *rbd_dev,
-			  u64 snapid,
 			  const char *object_name,
 			  u64 ofs, u64 len,
 			  char *buf,
@@ -1382,7 +1381,7 @@ static int rbd_req_sync_read(struct rbd_device
*rbd_dev,
 		return -ENOMEM;

 	ret = rbd_req_sync_op(rbd_dev, NULL,
-			       snapid,
+			       CEPH_NOSNAP,
 			       CEPH_OSD_FLAG_READ,
 			       ops, object_name, ofs, len, buf, NULL, ver);
 	rbd_destroy_ops(ops);
@@ -1797,8 +1796,7 @@ rbd_dev_v1_header_read(struct rbd_device *rbd_dev,
u64 *version)
 		if (!ondisk)
 			return ERR_PTR(-ENOMEM);

-		ret = rbd_req_sync_read(rbd_dev, CEPH_NOSNAP,
-				       rbd_dev->header_name,
+		ret = rbd_req_sync_read(rbd_dev, rbd_dev->header_name,
 				       0, size,
 				       (char *) ondisk, version);

-- 
1.7.9.5

