From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/5] rbd: move more initialization into rbd_dev_probe_image()
Date: Sat, 27 Apr 2013 14:39:18 -0500
Message-ID: <517C2966.5040103@inktank.com>
References: <517C2914.8030400@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:38224 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986Ab3D0TjU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Apr 2013 15:39:20 -0400
Received: by mail-ie0-f179.google.com with SMTP id 16so6022957iea.38
        for <ceph-devel@vger.kernel.org>; Sat, 27 Apr 2013 12:39:20 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id o10sm10147045igh.2.2013.04.27.12.39.19
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 12:39:19 -0700 (PDT)
In-Reply-To: <517C2914.8030400@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Move a block of initialization related to the "ceph-side" of an rbd
image out of rbd_dev_probe_finish() and into rbd_dev_probe_image().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 5fd923f..8a9ad60 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4742,19 +4742,6 @@ static int rbd_dev_probe_finish(struct rbd_device
*rbd_dev)
 {
 	int ret;

-	/* no need to lock here, as rbd_dev is not registered yet */
-	ret = rbd_dev_snaps_update(rbd_dev);
-	if (ret)
-		return ret;
-
-	ret = rbd_dev_spec_update(rbd_dev);
-	if (ret)
-		goto err_out_snaps;
-
-	ret = rbd_dev_probe_parent(rbd_dev);
-	if (ret)
-		goto err_out_snaps;
-
 	/* generate unique id: find highest unique id, add one */
 	rbd_dev_id_get(rbd_dev);

@@ -4817,8 +4804,6 @@ err_out_id:
 	rbd_dev_id_put(rbd_dev);
 	if (rbd_dev->parent);
 		rbd_dev_remove_parent(rbd_dev);
-err_out_snaps:
-	rbd_remove_all_snaps(rbd_dev);

 	return ret;
 }
@@ -4849,11 +4834,29 @@ static int rbd_dev_probe_image(struct rbd_device
*rbd_dev)
 	if (ret)
 		goto out_err;

+	ret = rbd_dev_snaps_update(rbd_dev);
+	if (ret)
+		goto out_err;
+
+	ret = rbd_dev_spec_update(rbd_dev);
+	if (ret)
+		goto err_out_snaps;
+
+	ret = rbd_dev_probe_parent(rbd_dev);
+	if (ret)
+		goto err_out_snaps;
+
 	ret = rbd_dev_probe_finish(rbd_dev);
 	if (ret)
-		rbd_header_free(&rbd_dev->header);
+		goto err_out_parent;

 	return ret;
+err_out_parent:
+	rbd_header_free(&rbd_dev->header);
+	if (rbd_dev->parent);
+		rbd_dev_remove_parent(rbd_dev);
+err_out_snaps:
+	rbd_remove_all_snaps(rbd_dev);
 out_err:
 	kfree(rbd_dev->spec->image_id);
 	rbd_dev->spec->image_id = NULL;
-- 
1.7.9.5

