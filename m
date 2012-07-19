From: Alex Elder <elder@inktank.com>
Subject: [PATCH 05/12] rbd: snapc is unused in rbd_req_sync_read()
Date: Thu, 19 Jul 2012 16:08:35 -0500
Message-ID: <50087753.8010900@inktank.com>
References: <500874F5.4090205@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52993 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673Ab2GSVIg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 17:08:36 -0400
Received: by mail-yw0-f46.google.com with SMTP id m54so3293293yhm.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 14:08:36 -0700 (PDT)
In-Reply-To: <500874F5.4090205@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The "snapc" parameter to in rbd_req_sync_read() is not used, so
get rid of it.

Reported-by: Josh Durgin <josh.durgin@inktank.com>
Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 93b2447..06e022d 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1162,7 +1162,6 @@ static int rbd_req_read(struct request *rq,
  * Request sync osd read
  */
 static int rbd_req_sync_read(struct rbd_device *rbd_dev,
-			  struct ceph_snap_context *snapc,
 			  u64 snapid,
 			  const char *object_name,
 			  u64 ofs, u64 len,
@@ -1609,7 +1608,7 @@ static int rbd_read_header(struct rbd_device *rbd_dev,
 			return -ENOMEM;

 		rc = rbd_req_sync_read(rbd_dev,
-				       NULL, CEPH_NOSNAP,
+				       CEPH_NOSNAP,
 				       rbd_dev->header_name,
 				       0, len,
 				       (char *)dh, &ver);
-- 
1.7.5.4

