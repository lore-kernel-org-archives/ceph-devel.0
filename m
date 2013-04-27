From: Alex Elder <elder@inktank.com>
Subject: [PATCH 6/6] rbd: probe for the parent earlier
Date: Sat, 27 Apr 2013 07:38:06 -0500
Message-ID: <517BC6AE.3010304@inktank.com>
References: <517BC608.5030008@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f170.google.com ([209.85.210.170]:57416 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755196Ab3D0MiH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Apr 2013 08:38:07 -0400
Received: by mail-ia0-f170.google.com with SMTP id k20so1360735iak.1
        for <ceph-devel@vger.kernel.org>; Sat, 27 Apr 2013 05:38:07 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id w8sm7705344igl.9.2013.04.27.05.38.06
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 05:38:06 -0700 (PDT)
In-Reply-To: <517BC608.5030008@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Probe for a parent device earlier in rbd_dev_probe_finish(), before
starting to set up the Linux side of the rbd device.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index c81b319..5fd923f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4751,6 +4751,10 @@ static int rbd_dev_probe_finish(struct rbd_device
*rbd_dev)
 	if (ret)
 		goto err_out_snaps;

+	ret = rbd_dev_probe_parent(rbd_dev);
+	if (ret)
+		goto err_out_snaps;
+
 	/* generate unique id: find highest unique id, add one */
 	rbd_dev_id_get(rbd_dev);

@@ -4781,10 +4785,6 @@ static int rbd_dev_probe_finish(struct rbd_device
*rbd_dev)
 	 * of the sysfs code (initiated by rbd_bus_del_dev()).
 	 */

-	ret = rbd_dev_probe_parent(rbd_dev);
-	if (ret)
-		goto err_out_bus;
-
 	ret = rbd_dev_header_watch_sync(rbd_dev, 1);
 	if (ret)
 		goto err_out_bus;
@@ -4806,8 +4806,6 @@ static int rbd_dev_probe_finish(struct rbd_device
*rbd_dev)
 	return ret;

 err_out_bus:
-	if (rbd_dev->parent)
-		rbd_dev_remove_parent(rbd_dev);
 	rbd_bus_del_dev(rbd_dev);

 	return ret;
@@ -4817,6 +4815,8 @@ err_out_blkdev:
 	unregister_blkdev(rbd_dev->major, rbd_dev->name);
 err_out_id:
 	rbd_dev_id_put(rbd_dev);
+	if (rbd_dev->parent);
+		rbd_dev_remove_parent(rbd_dev);
 err_out_snaps:
 	rbd_remove_all_snaps(rbd_dev);

-- 
1.7.9.5

