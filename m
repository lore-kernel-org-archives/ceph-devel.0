From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/4] rbd: add warnings to rbd_dev_probe_update_spec()
Date: Thu, 01 Nov 2012 10:27:11 -0500
Message-ID: <509294CF.8050908@inktank.com>
References: <50929419.6020302@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45910 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935828Ab2KAP1V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 11:27:21 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so3726066iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 08:27:21 -0700 (PDT)
In-Reply-To: <50929419.6020302@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

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
index 3ab3970..5de49a1 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2646,8 +2646,11 @@ static int rbd_dev_probe_update_spec(struct
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
@@ -2665,6 +2668,8 @@ static int rbd_dev_probe_update_spec(struct
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

