From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/7] rbd: simplify rbd_dev_v1_probe()
Date: Mon, 06 May 2013 20:53:32 -0500
Message-ID: <51885E9C.2020001@inktank.com>
References: <51885E06.8020201@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f43.google.com ([209.85.128.43]:54799 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759121Ab3EGBxe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 May 2013 21:53:34 -0400
Received: by mail-qe0-f43.google.com with SMTP id 1so31370qec.30
        for <ceph-devel@vger.kernel.org>; Mon, 06 May 2013 18:53:34 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id s10sm42558873qam.7.2013.05.06.18.53.33
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 06 May 2013 18:53:33 -0700 (PDT)
In-Reply-To: <51885E06.8020201@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

An rbd_dev structure's fields are all zero-filled for an initial
probe, so there's no need to explicitly zero the parent_spec
and parent_overlap fields in rbd_dev_v1_probe().  Removing these
assignments makes rbd_dev_v1_probe() *almost* trivial.

Move the dout() message that announces discovery of an image into
rbd_dev_image_probe(), generalize to support images in either format
and only show it if an image is fully discovered.

This highlights that are some unnecessary cleanups in the error
path for rbd_dev_v1_probe(), so they can be removed.

Now rbd_dev_v1_probe() *is* a trivial wrapper function.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   37 +++++++------------------------------
 1 file changed, 7 insertions(+), 30 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index a7985d9..ed18888 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4469,31 +4469,7 @@ static void rbd_dev_unprobe(struct rbd_device
*rbd_dev)

 static int rbd_dev_v1_probe(struct rbd_device *rbd_dev)
 {
-	int ret;
-
-	/* Populate rbd image metadata */
-
-	ret = rbd_dev_v1_header_read(rbd_dev);
-	if (ret < 0)
-		goto out_err;
-
-	/* Version 1 images have no parent (no layering) */
-
-	rbd_dev->parent_spec = NULL;
-	rbd_dev->parent_overlap = 0;
-
-	dout("discovered version 1 image, header name is %s\n",
-		rbd_dev->header_name);
-
-	return 0;
-
-out_err:
-	kfree(rbd_dev->header_name);
-	rbd_dev->header_name = NULL;
-	kfree(rbd_dev->spec->image_id);
-	rbd_dev->spec->image_id = NULL;
-
-	return ret;
+	return rbd_dev_v1_header_read(rbd_dev);
 }

 static int rbd_dev_v2_probe(struct rbd_device *rbd_dev)
@@ -4553,9 +4529,6 @@ static int rbd_dev_v2_probe(struct rbd_device
*rbd_dev)
 	if (ret)
 		goto out_err;

-	dout("discovered version 2 image, header name is %s\n",
-		rbd_dev->header_name);
-
 	return 0;
 out_err:
 	rbd_dev->parent_overlap = 0;
@@ -4758,9 +4731,13 @@ static int rbd_dev_image_probe(struct rbd_device
*rbd_dev, bool read_only)
 	rbd_dev->mapping.read_only = read_only;

 	ret = rbd_dev_probe_parent(rbd_dev);
-	if (!ret)
-		return 0;
+	if (ret)
+		goto err_out_probe;
+
+	dout("discovered format %u image, header name is %s\n",
+		rbd_dev->image_format, rbd_dev->header_name);

+	return 0;
 err_out_probe:
 	rbd_dev_unprobe(rbd_dev);
 err_out_watch:
-- 
1.7.9.5

