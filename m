From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: activate support for layered images
Date: Sun, 21 Apr 2013 16:54:57 -0500
Message-ID: <51746031.1030109@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f176.google.com ([209.85.210.176]:40161 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850Ab3DUVy7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Apr 2013 17:54:59 -0400
Received: by mail-ia0-f176.google.com with SMTP id i9so4805385iad.21
        for <ceph-devel@vger.kernel.org>; Sun, 21 Apr 2013 14:54:58 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

(This patch and the next one are available in the
"review/wip-enable-layering" branch of the ceph-client
git respository.)


Now that we have most everything in place to support layered rbd
images, enable support for them in the kernel client.  Issue a
warning to the log that the support is considered experimental
whenever a format 2 layered image is mapped.

Note that we also have to claim to support the STRIPINGV2 feature,
due to a mistake in the way the rbd CLI set up those flags.  This
feature can work if it has the right parameters, and safeguards
have been put in place to reject those images that do not have
compatible parameters.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index d23cc8f..1ddbcdc 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -80,7 +80,7 @@

 /* Features supported by this (client software) implementation. */

-#define RBD_FEATURES_SUPPORTED	(0)
+#define RBD_FEATURES_SUPPORTED	(RBD_FEATURES_ALL)

 /*
  * An RBD device name will be "rbd#", where the "rbd" comes from
@@ -4723,6 +4723,8 @@ static int rbd_dev_v2_probe(struct rbd_device
*rbd_dev)
 		ret = rbd_dev_v2_parent_info(rbd_dev);
 		if (ret)
 			goto out_err;
+		rbd_warn(rbd_dev, "WARNING: layered rbd image support "
+					"is EXPERIMENTAL!");
 	}

 	/* If the image supports fancy striping, get its parameters */
-- 
1.7.9.5

