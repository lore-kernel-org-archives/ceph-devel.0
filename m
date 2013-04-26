From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/4] rbd: fix image id leak in initial probe
Date: Fri, 26 Apr 2013 09:52:36 -0500
Message-ID: <517A94B4.4080804@inktank.com>
References: <517A945B.9040304@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:64011 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642Ab3DZOwj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 10:52:39 -0400
Received: by mail-ie0-f175.google.com with SMTP id a11so4948365iee.20
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 07:52:38 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id qs4sm3479277igb.10.2013.04.26.07.52.37
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 07:52:37 -0700 (PDT)
In-Reply-To: <517A945B.9040304@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

If a format 2 image id is found for an image being mapped, but the
subsequent probe of the image fails, rbd_dev_probe() quits without
freeing the image id.  Fix that.

Also drop a redundant hunk of code in rbd_dev_image_id().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 0774ae1..e79dfe2 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4794,17 +4794,21 @@ static int rbd_dev_probe(struct rbd_device *rbd_dev)
 		ret = rbd_dev_v2_probe(rbd_dev);
 	else
 		ret = rbd_dev_v1_probe(rbd_dev);
-	if (ret) {
-		dout("probe failed, returning %d\n", ret);
-
-		return ret;
-	}
+	if (ret)
+		goto out_err;

 	ret = rbd_dev_probe_finish(rbd_dev);
 	if (ret)
 		rbd_header_free(&rbd_dev->header);

 	return ret;
+out_err:
+	kfree(rbd_dev->spec->image_id);
+	rbd_dev->spec->image_id = NULL;
+
+	dout("probe failed, returning %d\n", ret);
+
+	return ret;
 }

 static ssize_t rbd_add(struct bus_type *bus,
-- 
1.7.9.5

