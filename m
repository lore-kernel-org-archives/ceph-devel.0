From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/7] rbd: snapc is unused in rbd_req_sync_read()
Date: Thu, 26 Jul 2012 13:57:18 -0500
Message-ID: <5011930E.7060403@inktank.com>
References: <50119076.1030307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34518 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428Ab2GZS5U (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jul 2012 14:57:20 -0400
Received: by yenl2 with SMTP id l2so2332418yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jul 2012 11:57:19 -0700 (PDT)
In-Reply-To: <50119076.1030307@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The "snapc" parameter to in rbd_req_sync_read() is not used, so
get rid of it.

Reported-by: Josh Durgin <josh.durgin@inktank.com>
Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 0fda2ed..64d3dbd 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1168,7 +1168,6 @@ static int rbd_req_read(struct request *rq,
  * Request sync osd read
  */
 static int rbd_req_sync_read(struct rbd_device *rbd_dev,
-			  struct ceph_snap_context *snapc,
 			  u64 snapid,
 			  const char *object_name,
 			  u64 ofs, u64 len,
@@ -1615,7 +1614,7 @@ static int rbd_read_header(struct rbd_device *rbd_dev,
 			return -ENOMEM;

 		rc = rbd_req_sync_read(rbd_dev,
-				       NULL, CEPH_NOSNAP,
+				       CEPH_NOSNAP,
 				       rbd_dev->header_name,
 				       0, len,
 				       (char *)dh, &ver);
-- 
1.7.9.5

