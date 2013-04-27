From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/5] rbd: set up watch in rbd_dev_probe_image()
Date: Sat, 27 Apr 2013 14:40:10 -0500
Message-ID: <517C299A.6030109@inktank.com>
References: <517C2914.8030400@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:56672 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461Ab3D0TkM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Apr 2013 15:40:12 -0400
Received: by mail-ia0-f180.google.com with SMTP id t4so3540989iag.25
        for <ceph-devel@vger.kernel.org>; Sat, 27 Apr 2013 12:40:12 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id wx2sm10133070igb.4.2013.04.27.12.40.10
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 12:40:11 -0700 (PDT)
In-Reply-To: <517C2914.8030400@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Move setting up the watch request for an image so it's done in
rbd_dev_probe_image() rather than rbd_dev_probe_finish().  Move
it all the way up to before doing the initial probe.  This avoids
a potential race condition, in which we get (and use) the initial
snapshot context for an image, and it gets changed between that
time and the time we get the watch set up.

This resolves:
    http://tracker.ceph.com/issues/3871

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 1832b6a..5fcf23f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4705,10 +4705,6 @@ static int rbd_dev_probe_finish(struct rbd_device
*rbd_dev)
 {
 	int ret;

-	ret = rbd_dev_header_watch_sync(rbd_dev, 1);
-	if (ret)
-		return ret;
-
 	/* generate unique id: find highest unique id, add one */
 	rbd_dev_id_get(rbd_dev);

@@ -4767,7 +4763,6 @@ err_out_id:
 	rbd_dev_id_put(rbd_dev);
 	if (rbd_dev->parent);
 		rbd_dev_remove_parent(rbd_dev);
-	(void)rbd_dev_header_watch_sync(rbd_dev, 0);

 	return ret;
 }
@@ -4824,12 +4819,16 @@ static int rbd_dev_probe_image(struct rbd_device
*rbd_dev)
 	if (ret)
 		goto out_err;

+	ret = rbd_dev_header_watch_sync(rbd_dev, 1);
+	if (ret)
+		goto out_header_name;
+
 	if (rbd_dev->image_format == 1)
 		ret = rbd_dev_v1_probe(rbd_dev);
 	else
 		ret = rbd_dev_v2_probe(rbd_dev);
 	if (ret)
-		goto out_header_name;
+		goto err_out_watch;

 	ret = rbd_dev_snaps_update(rbd_dev);
 	if (ret)
@@ -4841,7 +4840,7 @@ static int rbd_dev_probe_image(struct rbd_device
*rbd_dev)

 	ret = rbd_dev_probe_parent(rbd_dev);
 	if (ret)
-		goto err_out_snaps;
+		goto err_out_watch;

 	ret = rbd_dev_probe_finish(rbd_dev);
 	if (ret)
@@ -4857,6 +4856,8 @@ err_out_snaps:
 out_header_name:
 	kfree(rbd_dev->header_name);
 	rbd_dev->header_name = NULL;
+err_out_watch:
+	(void)rbd_dev_header_watch_sync(rbd_dev, 0);
 out_err:
 	kfree(rbd_dev->spec->image_id);
 	rbd_dev->spec->image_id = NULL;
-- 
1.7.9.5

