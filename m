From: Alex Elder <elder@inktank.com>
Subject: [PATCH 7/9] rbd: update remaining header fields for v2
Date: Fri, 07 Sep 2012 16:15:25 -0500
Message-ID: <504A63ED.5070008@inktank.com>
References: <504A6273.7030807@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45931 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756453Ab2IGVP2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 17:15:28 -0400
Received: by ieje11 with SMTP id e11so43209iej.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 14:15:28 -0700 (PDT)
In-Reply-To: <504A6273.7030807@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There are three fields that are not yet updated for format 2 rbd
image headers:  the version of the header object; the encryption
type; and the compression type.  There is no interface defined for
fetching the latter two, so just initialize them explicitly to 0 for
now.

Change rbd_dev_v2_snap_context() so the caller can be supplied the
version for the header object.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index c6922a1..ad27be2 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2235,7 +2235,7 @@ static int rbd_dev_v2_features(struct rbd_device
*rbd_dev)
 						&rbd_dev->header.features);
 }

-static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev)
+static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev, u64 *ver)
 {
 	size_t size;
 	int ret;
@@ -2263,7 +2263,7 @@ static int rbd_dev_v2_snap_context(struct
rbd_device *rbd_dev)
 				"rbd", "get_snapcontext",
 				NULL, 0,
 				reply_buf, size,
-				CEPH_OSD_FLAG_READ, NULL);
+				CEPH_OSD_FLAG_READ, ver);
 	dout("%s: rbd_req_sync_exec returned %d\n", __func__, ret);
 	if (ret < 0)
 		goto out;
@@ -2899,6 +2899,7 @@ static int rbd_dev_v2_probe(struct rbd_device
*rbd_dev)
 {
 	size_t size;
 	int ret;
+	u64 ver = 0;

 	/*
 	 * Image id was filled in by the caller.  Record the header
@@ -2929,11 +2930,18 @@ static int rbd_dev_v2_probe(struct rbd_device
*rbd_dev)
 	if (ret < 0)
 		goto out_err;

-	/* Get the snapshot context */
+	/* crypto and compression type aren't (yet) supported for v2 images */
+
+	rbd_dev->header.crypt_type = 0;
+	rbd_dev->header.comp_type = 0;

-	ret = rbd_dev_v2_snap_context(rbd_dev);
+	/* Get the snapshot context, plus the header version */
+
+	ret = rbd_dev_v2_snap_context(rbd_dev, &ver);
 	if (ret)
 		goto out_err;
+	rbd_dev->header.obj_version = ver;
+
 	rbd_dev->image_format = 2;

 	dout("discovered version 2 image, header name is %s\n",
-- 
1.7.9.5

