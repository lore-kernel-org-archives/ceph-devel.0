From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 4/4] rbd: add warnings to rbd_dev_probe_update_spec()
Date: Thu, 03 Jan 2013 13:12:22 -0600
Message-ID: <50E5D816.9010104@inktank.com>
References: <50E5D7A9.6040101@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:61292 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539Ab3ACTMZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 14:12:25 -0500
Received: by mail-ie0-f181.google.com with SMTP id 16so18507233iea.26
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jan 2013 11:12:24 -0800 (PST)
In-Reply-To: <50E5D7A9.6040101@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Josh suggested adding warnings to this function to help users
diagnose problems.

Other than memory allocatino errors, there are two places where
errors can be returned.  Both represent problems that should
have been caught earlier, and as such might well have been
handled with BUG_ON() calls.  But if either ever did manage to
happen, it will be reported.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index ce6c0cb..530a121 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2644,8 +2644,11 @@ static int rbd_dev_probe_update_spec(struct
rbd_device *rbd_dev)

 	osdc = &rbd_dev->rbd_client->client->osdc;
 	name = ceph_pg_pool_name_by_id(osdc->osdmap, rbd_dev->spec->pool_id);
-	if (!name)
-		return -EIO;	/* pool id too large (>= 2^31) */
+	if (!name) {
+		rbd_warn(rbd_dev, "there is no pool with id %llu",
+			rbd_dev->spec->pool_id);	/* Really a BUG() */
+		return -EIO;
+	}

 	rbd_dev->spec->pool_name = kstrdup(name, GFP_KERNEL);
 	if (!rbd_dev->spec->pool_name)
@@ -2663,6 +2666,8 @@ static int rbd_dev_probe_update_spec(struct
rbd_device *rbd_dev)

 	name = rbd_snap_name(rbd_dev, rbd_dev->spec->snap_id);
 	if (!name) {
+		rbd_warn(rbd_dev, "no snapshot with id %llu",
+			rbd_dev->spec->snap_id);	/* Really a BUG() */
 		ret = -EIO;
 		goto out_err;
 	}
-- 
1.7.9.5

