From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/4] rbd: drop snapid parameter from rbd_req_sync_read()
Date: Fri, 09 Nov 2012 21:44:08 -0600
Message-ID: <509DCD88.5030503@inktank.com>
References: <509DCCE6.5060009@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57136 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705Ab2KJDoK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 22:44:10 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so6904726iea.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Nov 2012 19:44:10 -0800 (PST)
In-Reply-To: <509DCCE6.5060009@inktank.com>
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
index 499e53a..6a31f38 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1370,7 +1370,6 @@ done:
  * Request sync osd read
  */
 static int rbd_req_sync_read(struct rbd_device *rbd_dev,
-			  u64 snapid,
 			  const char *object_name,
 			  u64 ofs, u64 len,
 			  char *buf,
@@ -1384,7 +1383,7 @@ static int rbd_req_sync_read(struct rbd_device
*rbd_dev,
 		return -ENOMEM;

 	ret = rbd_req_sync_op(rbd_dev, NULL,
-			       snapid,
+			       CEPH_NOSNAP,
 			       CEPH_OSD_FLAG_READ,
 			       ops, object_name, ofs, len, buf, NULL, ver);
 	rbd_destroy_ops(ops);
@@ -1794,8 +1793,7 @@ rbd_dev_v1_header_read(struct rbd_device *rbd_dev,
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

